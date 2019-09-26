#include <assert.h>
#include <pthread.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "monetdb_config.h"
#include "gdk.h"
#include "gdk_stalker.h"

pthread_t flushing_thread;
pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;

// 0 -> stalker
// 1 -> secondary_stalker
gdk_stalker stalker = { .allocated_size = 0, .id = 0 };
gdk_stalker secondary_stalker = { .allocated_size = 0, .id = 1 };
ATOMIC_TYPE SELECTED_STALKER_ID = 0;

bool GDK_STALKER_STOP = false;

FILE *output_file;
int file_size = 0;
int file_id = 1;

ATOMIC_TYPE CUR_LOG_LEVEL = DEFAULT_LOG_LEVEL;
ATOMIC_TYPE CUR_FLUSH_LEVEL = DEFAULT_FLUSH_LEVEL;

// Internal info messages in GDKstalker
static void _GDKstalker_info(const char *function_name, char *error_msg)
{
    fprintf(stderr, "[%s] %s\n", function_name, error_msg);
}


// Output error from snprintf of vsnprintf
static void _GDKstalker_log_output_error(int bytes_written)
{
    assert(bytes_written >= 0);
}


// Check if log file is open
static void _GDKstalker_file_is_open(void)
{
    assert(output_file);
}


// Prepares a file in order to write the contents of the buffer 
// when necessary. The file name each time is merovingian_{int}.log
static void _GDKstalker_create_file(void)
{
    char id[INT_MAX_LEN]; 
    snprintf(id, INT_MAX_LEN, "%d", file_id);

    char file_name[FILENAME_MAX];
    sprintf(file_name, "%s%s%s%s", FILE_NAME, "_", id, ".log");

    output_file = fopen(file_name, "a+");

    _GDKstalker_file_is_open();
}


static int _GDKstalker_fill_stalker(gdk_stalker *sel_stalker, const char *fmt, ...)
{
    va_list va;
    va_start(va, fmt);
    // vsnprintf(char *str, size_t count, ...) -> including null terminating character
    int bytes_written = vsnprintf(sel_stalker->buffer + sel_stalker->allocated_size, BUFFER_SIZE - sel_stalker->allocated_size, fmt, va);
    va_end(va);

    _GDKstalker_log_output_error(bytes_written);

    // vsnprintf returned value -> does not include the null terminating character
    return bytes_written++;
}


static void* _GDKstalker_flush_buffer_helper()
{
    return (void*) GDKstalker_flush_buffer();
}




/**
 * 
 * API CALLS
 * 
 */ 
char* GDKstalker_timestamp(void)
{
    static char datetime[20];
    time_t now = time(NULL);
    struct tm *tmp = localtime(&now);
    strftime(datetime, sizeof(datetime), "%Y-%m-%d %H:%M:%S", tmp);

    return datetime;
}


gdk_return GDKstalker_init(void)
{
    _GDKstalker_info(__func__, "Starting GDKstalker");
    _GDKstalker_create_file();
    return GDK_SUCCEED;
}


gdk_return GDKstalker_stop(void)
{
    GDK_STALKER_STOP = true;
    return GDKstalker_flush_buffer();
}


gdk_return GDKstalker_set_log_level(LOG_LEVEL level)
{
    if(CUR_LOG_LEVEL == level)
        return GDK_SUCCEED;

    if(level == M_NONE && CUR_LOG_LEVEL != M_NONE)
    {
        int GDK_result = GDKstalker_flush_buffer();
        if(GDK_result == GDK_FAIL)
            return GDK_FAIL;
    }

    ATOMIC_SET(&CUR_LOG_LEVEL, level);

    return GDK_SUCCEED;
}


gdk_return GDKstalker_reset_log_level(void)
{  
    if(CUR_LOG_LEVEL == M_NONE)
        return GDK_SUCCEED;
   
    int GDK_result = GDKstalker_flush_buffer();
    if(GDK_result == GDK_FAIL)
        return GDK_FAIL;

    ATOMIC_SET(&CUR_LOG_LEVEL, M_NONE);

    return GDK_SUCCEED;
}


gdk_return GDKstalker_set_flush_level(LOG_LEVEL level)
{
    if(CUR_FLUSH_LEVEL == level)
        return GDK_SUCCEED;
    
    ATOMIC_SET(&CUR_FLUSH_LEVEL, level);

    return GDK_SUCCEED;
}


gdk_return GDKstalker_reset_flush_level(void)
{
    if(CUR_FLUSH_LEVEL == M_ERROR)
        return GDK_SUCCEED;

    ATOMIC_SET(&CUR_FLUSH_LEVEL, M_ERROR);

    return GDK_SUCCEED;
}


gdk_return GDKstalker_log(LOG_LEVEL level, int event_id, const char *fmt, ...)
{
    printf("MPIKA\n");
    _GDKstalker_file_is_open();
    
    if(level >= CUR_LOG_LEVEL && CUR_LOG_LEVEL > M_NONE)
    {
        // Select a stalker
        gdk_stalker *fill_stalker;
        if(ATOMIC_GET(&SELECTED_STALKER_ID) == stalker.id)
            fill_stalker = &stalker;
        else
            fill_stalker = &secondary_stalker;

        printf("Selected stalker -> %lu\n", fill_stalker->id);

        pthread_mutex_lock(&mutex);
        {
            va_list va;
            va_start(va, fmt);
            int bytes_written = _GDKstalker_fill_stalker(fill_stalker, fmt, va);
            va_end(va);

            // The message fits the buffer OR the buffer is empty (we don't care if it fits - just cut it off)
            if(bytes_written < (BUFFER_SIZE - fill_stalker->allocated_size) || 
               fill_stalker->allocated_size == 0)
            {
                printf("CONTENT IS %s\n", fill_stalker->buffer);
                printf("Filling buffer %lu\n", fill_stalker->id);
                
                fill_stalker->allocated_size += bytes_written;
                printf("EDW -> TELOS");
            }
            else
            {
                printf("Flushing buffer %lu", fill_stalker->id);

                // Switch stalker
                if(ATOMIC_GET(&SELECTED_STALKER_ID) == stalker.id)
                    fill_stalker = &secondary_stalker;
                else
                    fill_stalker = &stalker;

                printf(" and filling buffer %lu\n", fill_stalker->id);

                // Flush current stalker
                pthread_create(&flushing_thread, NULL, _GDKstalker_flush_buffer_helper, NULL);
                
                va_list va;
                va_start(va, fmt);
                bytes_written = _GDKstalker_fill_stalker(fill_stalker, fmt, va);
                va_end(va);

                void *GDK_th_result;
                pthread_join(flushing_thread, &GDK_th_result); 
                if(GDK_th_result == GDK_FAIL)
                    return GDK_FAIL;

                // Set the new selected stalker 
                ATOMIC_SET(&SELECTED_STALKER_ID, fill_stalker->id);
                printf("NEW selected buffer is %lu\n", fill_stalker->id);
            }
        }
        pthread_mutex_lock(&mutex);


        // Flush the current buffer in case the event is 
        // important depending on the flush-level
        if(event_id >= (int) ATOMIC_GET(&CUR_FLUSH_LEVEL))
        {
            printf("Event IS IMPORTANT -> Flushing buffer %llu\n", ATOMIC_GET(&SELECTED_STALKER_ID));
            int GDK_result = GDKstalker_flush_buffer();
            if(GDK_result == GDK_FAIL)
                return GDK_FAIL;
        }
    }

    return GDK_SUCCEED;
}


gdk_return GDKstalker_flush_buffer()
{
    printf("EDW EimI");
    // Select a stalker
    gdk_stalker *fl_stalker;
    if(ATOMIC_GET(&SELECTED_STALKER_ID) == stalker.id)
        fl_stalker = &stalker;
    else
        fl_stalker = &secondary_stalker;

    pthread_mutex_lock(&mutex);
    {
        fwrite(&fl_stalker->buffer, fl_stalker->allocated_size, 1, output_file);
        fflush(output_file);
        
        // Increase file size tracking
        file_size += fl_stalker->allocated_size;

        // Reset buffer
        memset(fl_stalker->buffer, 0, BUFFER_SIZE);
        fl_stalker->allocated_size = 0;
    }
    pthread_mutex_unlock(&mutex);

    // Even if the existing file is full, the logger should not create
    // a new file in case GDKstalker_stop has been called
    if (file_size >= MAX_FILE_SIZE && !GDK_STALKER_STOP)
    {
        fclose(output_file);
        file_size = 0;
        file_id++;
        _GDKstalker_create_file();
    }
    else if(GDK_STALKER_STOP)
    {
        fclose(output_file);
    }
    
    return GDK_SUCCEED;
}

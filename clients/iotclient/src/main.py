import argparse
import getpass
import os
import signal
import sys
import time
from multiprocessing import Process
from threading import Thread
from uuid import getnode as get_mac

from IPy import IP

from Flask.app import start_flask_iot_app, start_flask_admin_app
from Flask.restresources import init_rest_resources
from Settings.filesystem import init_file_system, DEFAULT_FILESYSTEM
from Settings.iotlogger import init_logging, add_log, DEFAULT_LOGGING
from Settings.mapiconnection import init_monetdb_connection, check_hugeint_type
from Streams.jsonschemas import init_create_streams_schema
from Streams.streampolling import polling_add_hugeint_type, init_stream_polling_thread
from Streams.streams import init_streams_hosts
from Streams.streamscontext import init_streams_context
from Streams.streamscreator import creator_add_hugeint_type

subprocess = None


def signal_handler(signal, frame):
    subprocess.terminate()
    add_log(20, 'Stopped IOT Stream Server')


def start_process(filesystem_location, polling, host_identifier, admin_host, admin_port, app_host, app_port,
                  con_hostname, con_port, con_user, con_password, con_database):
    try:
        # WARNING The initiation order must be this!!!
        init_file_system(filesystem_location)  # init filesystem

        connection = init_monetdb_connection(con_hostname, con_port, con_user, con_password, con_database)
        if check_hugeint_type(connection):
            polling_add_hugeint_type()
            creator_add_hugeint_type()
            init_create_streams_schema(add_hugeint=True)
        else:
            init_create_streams_schema(add_hugeint=False)

        init_streams_context(con_hostname, con_port, con_user, con_password, con_database)
        init_streams_hosts(host_identifier)  # init hostname column for streams
        init_rest_resources()  # init validators for RESTful requests
        init_stream_polling_thread(polling, connection, con_hostname, con_port, con_user, con_password, con_database)

        log_message = 'User %s connected successfully to database %s' % (con_user, con_database)
        print log_message
        add_log(20, log_message)
    except BaseException as ex:
        print ex
        add_log(50, ex)
        sys.exit(1)

    thread1 = Thread(target=start_flask_admin_app, args=(admin_host, admin_port))
    thread2 = Thread(target=start_flask_iot_app, args=(app_host, app_port))
    thread1.start()
    time.sleep(1)  # problem while handling Flask's loggers, so it is used this sleep
    thread2.start()
    add_log(20, 'Started IOT Stream Server')
    thread1.join()
    thread2.join()


def check_path(value):
    if not os.path.isabs(value):
        raise argparse.ArgumentTypeError("%s is an invalid path" % value)
    return value


def check_positive_int(value):
    ivalue = int(value)
    if ivalue <= 0:
        raise argparse.ArgumentTypeError("%s is an invalid positive int value" % value)
    return ivalue


def check_ipv4_address(value):
    try:
        IP(value)
    except:
        raise argparse.ArgumentTypeError("%s is an invalid IPv4 address" % value)
    return value


def main():
    global subprocess

    parser = argparse.ArgumentParser(description='IOT Web Server for MonetDB', epilog="There might exist bugs!",
                                     add_help=False)
    parser.add_argument('-f', '--filesystem', type=check_path, nargs='?', default=DEFAULT_FILESYSTEM,
                        help='Baskets location directory (default: %s)' % DEFAULT_FILESYSTEM, metavar='DIRECTORY')
    parser.add_argument('-l', '--log', type=check_path, nargs='?', default=DEFAULT_LOGGING,
                        help='Logging file location (default: %s)' % DEFAULT_LOGGING, metavar='FILE_PATH')
    parser.add_argument('-po', '--polling', type=check_positive_int, nargs='?', default=60, metavar='POLLING',
                        help='Polling interval in seconds to the database for streams updates (default: 60)')
    parser.add_argument('-n', '--name', nargs='?',
                        default=':'.join(("%012X" % get_mac())[i:i + 2] for i in range(0, 12, 2)),
                        help='Host identifier name. If not provided, the machine MAC address will be used')
    parser.add_argument('-ih', '--ihost', type=check_ipv4_address, nargs='?', default='0.0.0.0',
                        help='Administration server host (default: 0.0.0.0)', metavar='HOST')
    parser.add_argument('-ip', '--iport', type=check_positive_int, nargs='?', default=8001,
                        help='Administration server port (default: 8001)', metavar='PORT')
    parser.add_argument('-ah', '--ahost', type=check_ipv4_address, nargs='?', default='127.0.0.1',
                        help='Application server host (default: 127.0.0.1)', metavar='HOST')
    parser.add_argument('-ap', '--aport', type=check_positive_int, nargs='?', default=8000,
                        help='Application server port (default: 8000)', metavar='PORT')
    parser.add_argument('-h', '--host', nargs='?', default='127.0.0.1',
                        help='MonetDB database host (default: 127.0.0.1)', metavar='HOST')
    parser.add_argument('-p', '--port', type=check_positive_int, nargs='?', default=50000,
                        help='Database listening port (default: 50000)', metavar='PORT')
    parser.add_argument('-d', '--database', nargs='?', default='iotdb', help='Database name (default: iotdb)')
    parser.add_argument('-u', '--user', nargs='?', default='monetdb', help='Database user (default: monetdb)')
    parser.add_argument('-?', '--help', action='store_true', help='Display this help')

    try:
        args = vars(parser.parse_args())
    except BaseException as ex:
        print ex
        sys.exit(1)

    if args['help']:
        parser.print_help()
        sys.exit(0)

    print 'Using host identifier: ', args['name']

    con_password = getpass.getpass(prompt='Insert password for user ' + args['user'] + ':')
    init_logging(args['log'])  # init logging context
    subprocess = Process(target=start_process, args=(args['filesystem'], args['polling'], args['name'], args['ihost'],
                                                     args['iport'], args['ahost'], args['aport'], args['host'],
                                                     args['port'], args['user'], con_password, args['database']))
    subprocess.start()
    signal.signal(signal.SIGINT, signal_handler)
    subprocess.join()

if __name__ == "__main__":
    main()

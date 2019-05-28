# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0.  If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Copyright 1997 - July 2008 CWI, August 2008 - 2019 MonetDB B.V.

from __future__ import print_function

import os
import argparse


parser = argparse.ArgumentParser(description='Convert MonetDB MAL scripts to C header files to be inlined')
parser.add_argument('-f', '--file', metavar='F', dest='file', type=str, help='The MAL file to convert')
parser.add_argument('-o', '--output', metavar='O', dest='output', type=str, help='The output header file to write to')
parser.add_argument('-t', '--trim', dest='trim', action='store_true', help='trim whitespaces')
parser.add_argument('-r', '--rcomments', dest='rcom', action='store_true', help='remove comments')

# check arguments and veracity of the input file first
args = parser.parse_args()

if not os.path.exists(args.file):
    raise Exception("File {0} doesn't exist".format(args.file))
if not os.path.isfile(args.file):
    raise Exception("{0} is not a file".format(args.file))

file_stat = os.stat(args.file)
if file_stat.st_size > (1 << 29):
    raise Exception("File {0} is too large to process".format(args.file))

# get the file name and extension
input_file_base = os.path.basename(args.file)
input_file_split = os.path.splitext(input_file_base)
if len(input_file_split) < 2 or input_file_split[1] != '.mal':
    raise Exception("Only .mal files are supported for the input file")

output_file_base = os.path.basename(args.output)
output_file_split = os.path.splitext(output_file_base)
if len(output_file_split) < 2 or output_file_split[1] != '.h':
    raise Exception("Only .h files are supported for the output file")

mal_content_file = open(args.file, 'r')
mal_content = mal_content_file.read()
mal_content_file.close()

filebasename = output_file_split[0]
# output file will be written on the same directory
mal_h_output_file = open(args.output, 'w')

# write the common header, plus the C array entry
insert1 = (
'/*\n'
'* This Source Code Form is subject to the terms of the Mozilla Public\n'
'* License, v. 2.0.  If a copy of the MPL was not distributed with this\n'
'* file, You can obtain one at http://mozilla.org/MPL/2.0/.\n'
'*\n'
'* Copyright 1997 - July 2008 CWI, August 2008 - 2019 MonetDB B.V.\n'
'*/\n'
'\n'
'// This file was generated automatically with mal2h.py. Do not edit this file directly.\n'
'{{ "{0}", "').format(filebasename)

mal_h_output_file.write(insert1)

# Let's remove comments from the mal script with a Markov chain :) Bugs might still be there
# STATES 0 - OK, 1 in # comment, 2 between comment keyword and comment block (removing comments),
# 3 inside address comment block (removing comments),
# 4 between comment keyword and comment block (not removing comments),
# 5 inside address comment block (not removing comments), 6 inside " string, 7 inside whitespaces
CACHE_SIZE = file_stat.st_blksize  # we will set the cache size to the filesystem blocksize

buffer = ['\0'] * CACHE_SIZE
cur_state = 0
current_pointer = 0
i = 0
endloop = len(mal_content) - 1


def write_to_buffer(input_c):
    global current_pointer, mal_h_output_file, buffer
    if current_pointer == CACHE_SIZE:
        mal_h_output_file.write("".join(buffer))
        current_pointer = 0
    buffer[current_pointer] = input_c
    current_pointer += 1


while i < endloop:
    c = mal_content[i]

    if cur_state == 1:  # inside an hashtag comment
        if c == '\n':
            cur_state = 0
        i += 1
        continue
    elif cur_state == 2:  # before entering a MAL comment, and removing it
        if c == '"':
            cur_state = 3
        i += 1
        continue
    elif cur_state == 3:  # inside a MAL comment, and removing it
        if c == '\\':
            i += 2
        elif c == '"':
            cur_state = 0
            i += 1
        else:
            i += 1
        continue
    elif cur_state == 4:  # before entering a MAL comment, but not removing it
        if c == '"':
            write_to_buffer('\\')
            write_to_buffer('"')
            cur_state = 5
        i += 1
        continue
    elif cur_state == 5:  # inside a MAL comment, but not removing it
        if c == '\\' and i + 1 < endloop:
            write_to_buffer('\\')
            write_to_buffer('\\')
            write_to_buffer('\\')
            write_to_buffer('\\')
            write_to_buffer('\\')
            write_to_buffer(mal_content[i + 1])
            i += 2
        elif c == '\n':
            write_to_buffer('\\')
            write_to_buffer('n')
            i += 1
        elif c == '\t':
            write_to_buffer('\\')
            write_to_buffer('t')
            i += 1
        else:
            if c == '"':
                write_to_buffer('\\')
                write_to_buffer('\"')
                cur_state = 0
            else:
                write_to_buffer(c)
            i += 1
        continue
    elif cur_state == 6:  # inside a string
        if c == '\\' and i + 1 < endloop:
            write_to_buffer('\\')
            write_to_buffer('\\')
            write_to_buffer('\\')
            write_to_buffer(mal_content[i + 1])
            i += 2
        elif c == '\n':
            write_to_buffer('\\')
            write_to_buffer('n')
            i += 1
        elif c == '\t':
            write_to_buffer('\\')
            write_to_buffer('t')
            i += 1
        else:
            if c == '"':
                cur_state = 0
                write_to_buffer('\\')
            write_to_buffer(c)
            i += 1
        continue
    elif cur_state == 7:  # inside whitespaces
        if c not in (' ', '\t', '\n'):
            cur_state = 0
            continue
        i += 1
        continue

    if c == '#':
        cur_state = 1
        i += 1
        continue
    elif c == 'c':
        if i + 8 < endloop and mal_content[i:i+8] == 'comment ':
            if args.rcom:
                cur_state = 2
            else:
                for mchar in 'comment ':
                    write_to_buffer(mchar)
                cur_state = 4
            i += 7
        else:
            write_to_buffer('c')
            i += 1
        continue
    elif c == '"':
        write_to_buffer('\\')
        write_to_buffer(c)
        cur_state = 6
        i += 1
        continue
    elif c in (' ', '\t', '\n'):
        if c == '\n':
            write_to_buffer('\\')
            write_to_buffer('n')
        elif c == '\t':
            write_to_buffer('\\')
            write_to_buffer('t')
        else:
            write_to_buffer(c)
        if args.trim:
            cur_state = 7
        i += 1
        continue

    if c == '\\':
        write_to_buffer('\\')
    write_to_buffer(c)
    i += 1

if current_pointer > 0:
    mal_h_output_file.write("".join(buffer[:current_pointer]))

# finish C array entry
mal_h_output_file.write('" }}, \n'.format())
mal_h_output_file.close()

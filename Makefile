#
# Project: udptunnel
# File: Makefile
#
# Copyright (C) 2009 Daniel Meekins
# Contact: dmeekins - gmail
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Uncomment appropriate one for the system this is compiling for
#OS=LINUX
#OS=SOLARIS
OS=CYGWIN

CC=gcc
CFLAGS=-Wall -Wshadow -Wpointer-arith -Wwrite-strings -D ${OS}

ifeq (${OS}, SOLARIS)
LDFLAGS=-lnsl -lsocket -lresolv
endif

all: udptunnel

#
# Main program
#
OBJS=socket.o message.o client.o list.o udpserver.o udpclient.o
udptunnel: udptunnel.c ${OBJS}
	${CC} ${CFLAGS} -o udptunnel udptunnel.c ${OBJS} ${LDFLAGS}

#
# Supporting code
#
list.o: list.c list.h common.h
socket.o: socket.c socket.h common.h
client.o: client.c client.h common.h
message.o: message.c message.h common.h
udpclient.o: udpclient.c list.h socket.h client.h message.h common.h
udpserver.o: udpserver.c list.h socket.h client.h message.h common.h

#
# Clean compiled and temporary files
#
clean:
ifeq (${OS}, CYGWIN)
	rm -f udptunnel.exe
else
	rm -f udptunnel
endif
	rm -f *~ *.o

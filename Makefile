# Copyright (c) 2009 Mikolaj Golub
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 
# THIS SOFTWARE IS PROVIDED BY AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
#
# $Id: $
#

# Try to keep it GNU make/BSD make compatible.

PREFIX?=	/usr/local
CONFDIR?=	${PREFIX}/etc/gather
CONFILE?=	${CONFDIR}/gather.cfg
MAPFILE?=	${CONFDIR}/gather.map
DATADIR?=	/var/db/gather

all: gather gather.cfg gather.1

gather: gather.pl.in
	perl -pe "s|\\@PERL\\@|`which perl`|; \
	          s|\\@CONFILE\\@|'${CONFILE}'|; \
	          s|\\@MAPFILE\\@|'${MAPFILE}'|; \
	          s|\\@DATADIR\\@|'${DATADIR}'|;" ${?} > ${@}
	chmod 0755 ${@}

gather.cfg: gather.cfg.in
	perl -pe "s|\\@MAPFILE\\@|'${MAPFILE}'|; \
	          s|\\@DATADIR\\@|'${DATADIR}'|;" ${?} > ${@}

gather.1: gather.pl.in
	pod2man ${?} > ${@}

clean:
	rm -f gather gather.1 gather.cfg

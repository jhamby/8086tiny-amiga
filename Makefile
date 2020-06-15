# 8086tiny: a tiny, highly functional, highly portable PC emulator/VM
# Copyright 2013-14, Adrian Cable (adrian.cable@gmail.com) - http://www.megalith.co.uk/8086tiny
#
# This work is licensed under the MIT License. See included LICENSE.TXT.

# 8086tiny builds with graphics and sound support
# 8086tiny_slowcpu improves graphics performance on slow platforms (e.g. Raspberry Pi)
# no_graphics compiles without SDL graphics/sound

OPTS_ALL=-O3 -fsigned-char -std=c99 -fno-strict-aliasing -Wall -Wno-unused-value

# Uncomment the next two lines for native build
STRIP=strip
OPTS_SDL=`sdl-config --cflags --libs`

# Or, uncomment the following lines for cross-compiling to AmigaOS
#CC=m68k-amigaos-gcc
#STRIP=m68k-amigaos-strip
#OPTS_SDL=-I/opt/amiga/m68k-amigaos/include/SDL -lc -lSDL

OPTS_NOGFX=-DNO_GRAPHICS
OPTS_SLOWCPU=-DGRAPHICS_UPDATE_DELAY=25000

8086tiny: 8086tiny.c
	${CC} 8086tiny.c ${OPTS_SDL} ${OPTS_ALL} -o 8086tiny
	${STRIP} 8086tiny

8086tiny_slowcpu: 8086tiny.c
	${CC} 8086tiny.c ${OPTS_SDL} ${OPTS_ALL} ${OPTS_SLOWCPU} -o 8086tiny
	${STRIP} 8086tiny

no_graphics: 8086tiny.c
	${CC} 8086tiny.c ${OPTS_NOGFX} ${OPTS_ALL} -o 8086tiny
	${STRIP} 8086tiny

clean:
	rm -f 8086tiny 8086tiny.o

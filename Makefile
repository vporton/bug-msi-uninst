#!/usr/bin/make -f

SHELL=/bin/bash
ARCH=x64

.PHONY: msi
msi: my-${ARCH}.msi

.PHONY: clean
clean:
	rm -f src/*.exe windows/*.wixobj *.wixpdb *.msi

my-${ARCH}.msi: windows/my-${ARCH}.wixobj
	light -o $@ windows/my-${ARCH}.wixobj

%-${ARCH}.wixobj: %.wxs
	ARCH=${ARCH} MySource="src" candle -arch ${ARCH} $< -o $@

ifeq (${ARCH}, x64)
GCC_FLAGS = -m64
else
GCC_FLAGS = -m32
endif

src/main.exe: src/main.c
	gcc -o $@ ${GCC_FLAGS} -O2 $<
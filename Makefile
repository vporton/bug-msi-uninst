#!/usr/bin/make -f

SHELL=/bin/bash
ARCH=x64

.PHONY: msi
msi: my-${ARCH}.msi

.PHONY: clean
clean:
	rm -f src/*.exe windows/*.wixobj *.wixpdb *.msi

my-${ARCH}.msi: windows/my-${ARCH}.wixobj src/main.exe windows/custom.exe
	light -o $@ windows/my-${ARCH}.wixobj

%-${ARCH}.wixobj: %.wxs
	ARCH=${ARCH} MySource="src" candle -arch ${ARCH} $< -o $@

ifeq (${ARCH}, x64)
GCC_FLAGS = #-m64  # does not work on my installation
else
GCC_FLAGS = -m32
endif

src/main.exe: src/main.c
	gcc -o $@ ${GCC_FLAGS} -O2 $<

windows/custom.exe: windows/custom.cpp
	g++ -m64 -o $@ -O2 -Wall -Werror $<
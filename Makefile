#!/usr/bin/make -f

SHELL=/bin/bash
ARCH=x64

.PHONY: msi
msi: my-${ARCH}.msi

my-${ARCH}.msi: windows/my-${ARCH}.wixobj windows/files-${ARCH}.tmp-${ARCH}.wixobj
	light -o $@ windows/my-${ARCH}.wixobj windows/files-${ARCH}.tmp-${ARCH}.wixobj

windows/files-${ARCH}.tmp.wxs: src/main.exe
	heat dir src -o $@ -scom -frag -srd -sreg -gg -cg MyComponentGroupId -dr src -var env.MySource

%-${ARCH}.wixobj: %.wxs
	ARCH=${ARCH} MySource="src" candle -arch ${ARCH} $< -o $@

src/main.exe: src/main.c
	gcc -o $@ $<
#!/usr/bin/env bash

echo "Make sure /system/ is writable"

PREFIX=./android_tshark_lib

function adbpush() {
    if [ -f "$1" ] ; then
        adb push $1 /sdcard
        adb shell "su -c 'mv /sdcard/$1 /system/lib/'"
    else
         echo "'$1' is not a valid file"
    fi
}

cd $PREFIX/bin
adb push dumpcap /sdcard/
adb shell "su -c 'mv /sdcard/dumpcap /system/bin/ && chown root:shell /system/bin/dumpcap && chmod 4711 /system/bin/dumpcap'"
adb push tshark /sdcard/
adb shell "su -c 'mv /sdcard/tshark /system/bin/ && chown root:shell /system/bin/tshark && chmod +x /system/bin/tshark'"

cd ../../

cd $PREFIX/lib
adbpush libgmp.so
adbpush libhogweed.so.4
adbpush libnettle.so.6
adbpush libtasn1.so.6
adbpush libffi.so.6
adbpush libp11-kit.so
adbpush libgnutls.so
adbpush libgmodule-2.0.so
adbpush libgthread-2.0.so
adbpush libgpg-error.so
adbpush libgcrypt.so
adbpush libpcap.so.1
adbpush libglib-2.0.so
adbpush libwsutil.so
adbpush libiconv.so
adbpush libwiretap.so
adbpush libintl.so
adbpush libwireshark.so
adbpush libxml2.so
adbpush liblzma.so


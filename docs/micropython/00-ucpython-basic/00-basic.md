#Cài đặt

## Cài đặt esp-open-sdk

Bởi vì `micropython` build cho ESP8266 cần 1 số sự thay đổi trong compile và thư viện đi kèm nên phải sử dụng compiler, sdk từ esp-open-sdk 

Cài đặt theo hướng dẫn tại [esp-open-sdk](https://github.com/pfalcon/esp-open-sdk)
```
sed -i.bak '1s/^/gettext=\'$'\n/' crosstool-NG/kconfig/Makefile
sed -i.bak -e 's/[[:<:]]sed[[:>:]]/gsed/' Makefile
sed -i.bak -e 's/[[:<:]]awk[[:>:]]/\$(AWK)/' lx106-hal/src/Makefile.am
sed -i.bak 's/AM_PROG_AS/AM_PROG_AS\'$'\nAM_PROG_AR/' lx106-hal/configure.ac 
```

## IDE 

Sử dụng https://github.com/eduvik/mu/tree/feature/multi-board
https://www.pycom.io/solutions/pymakr/

Lư ý việc Flash firmware cho ESP8266 dùng esptool.py 
```
esptool.py --port /dev/tty.SLAB_USBtoUART --baud 921600 write_flash --verify --flash_size=32m --flash_mode=qio 0 build/firmware-combined.bin
```

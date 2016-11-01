#Cài đặt

## Cài đặt esp-open-sdk

Bởi vì `micropython` build cho ESP8266 cần 1 số sự thay đổi trong compile và thư viện đi kèm nên phải sử dụng compiler, sdk từ esp-open-sdk

Cài đặt theo hướng dẫn tại [esp-open-sdk](https://github.com/pfalcon/esp-open-sdk)

Trước khi thực hiện `make` thì thực hiện lệnh này trước:
```bash
sed -i.bak '1s/^/gettext=\'$'\n/' crosstool-NG/kconfig/Makefile
sed -i.bak -e 's/[[:<:]]sed[[:>:]]/gsed/' Makefile
sed -i.bak -e 's/[[:<:]]awk[[:>:]]/\$(AWK)/' lx106-hal/src/Makefile.am
sed -i.bak 's/AM_PROG_AS/AM_PROG_AS\'$'\nAM_PROG_AR/' lx106-hal/configure.ac 
```

## Biên dịch Firmware Micropython cho ESP8266

```bash
git clone --recursive https://github.com/micropython/micropython.git 
git submodule update --init
cd micropython
make -C mpy-cross
cd esp8266
make axtls
make
```

Xem hướng dẫn rõ hơn tại đây: [https://github.com/micropython/micropython/tree/master/esp8266](https://github.com/micropython/micropython/tree/master/esp8266)

## Download firmware 

Tốt nhất bạn nên có thể tự build firmware cho micropython, bởi vì firmware được cập nhật liên tục. Tuy nhiên, vì vấn đề bạn muốn thử firmware thật nhanh và không quan tâm tới tính năng. Đường link bên dưới cung cấp firmware đã được build sẵn, và được cập nhật bất cứ khi nào có thể:
- [dropbox 1.8.5 build 20-oct-2016](https://www.dropbox.com/s/zjjmh984cuivy2w/firmware-combined.1.8.5.bin?dl=0)

## Flash firmware 
Lưu ý việc Flash firmware cho ESP8266 dùng esptool.py 

```bash
esptool.py --port /dev/tty.SLAB_USBtoUART --baud 921600 write_flash --verify --flash_size=32m --flash_mode=qio 0 build/firmware-combined.bin
```

## Phần cứng - Pinout 

!!! note "Lưu ý"
    Lưu ý là Micropython sử dụng GPIO giống với tên GPIO cho chip ESP8266, khác cách đặt tên của NodeMCU, do vậy, nếu bạn sử dụng Board NodeMCU hoặc các board nào khác thì lưu ý

![NodeMCU Pinout](../../introduction/images/esp8266_devkit.svg)

Ví dụ: 
```python
from machine import Pin 
led = Pin(16, Pin.OUT) #Tương đương LED trên board NodeMCU
gpio13 = Pin(13, Pin.OUT) # Tương đương chân D7 trên NodeMCU
```

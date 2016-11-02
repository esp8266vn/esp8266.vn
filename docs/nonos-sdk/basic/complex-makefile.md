[TOC]

# Sử dụng sự án có Makefile phức tạp

Để biên dịch sự án có nhiều file hơn nữa thì việc sử dụng Makefile như các ví dụ trên khá phiền phức, phải thay đổi nhiều chỗ. Mục đích của Makefile đơn giản là giúp chúng ta hiểu được nguyên lý hoạt động của compiler và cách thức biên dịch ứng dụng với Nonos-sdk. 
Để tiện lợi, kể từ mục này trở đi, chúng ta sử dụng Makefile trong dự án mẫu và phân bổ dự án theo cấu trúc như bên dưới. Dự án đã viết sẵn Makefile tự động tìm và biên dịch các file `.c` 

## Dự án mẫu 

- [https://github.com/esp8266vn/esp8266-nonos-sdk-boilerplate](https://github.com/esp8266vn/esp8266-nonos-sdk-boilerplate)
- Hoặc lấy dự án về từ Github: 

```
git clone https://github.com/esp8266vn/esp8266-nonos-sdk-boilerplate.git
```


## Cấu trúc dự án 

```
esp8266-nonos-sdk-boilerplate
    |--- Makefile
    |--- modules
    |   |--- moduleA
    |   |   |-- Makefile
    |   |   |-- include
    |   |   |   `-- modulea.h 
    |   |   `-- modulea.c
    |--- include
    |   `-- user_config.h
    |--- user
        |-- Makefile
        |-- user_main.c 
        `-- rfinit.c

```

Trong đó: 

- Thư mục `modules` chứa các module liên quan, mỗi module có định nghĩa prototype đặt trong thư mục `include`

## Lưu ý

- Đường dẫn mặc định của project trong makefile
```
# base directory of the ESP8266 SDK package, absolute
SDK_BASE    ?= /tools/esp8266/sdk/ESP8266_NONOS_SDK

#Esptool.py path and port
ESPTOOL     ?= /tools/esp8266/esptool/esptool.py

```
- Thay đổi cổng COM
```
ESPPORT     ?= /dev/tty.SLAB_USBtoUART
```
Với ubuntu/linux sẽ có dạng `ESPPORT        ?= /dev/ttyUSB0`
- Tốc độ baud nạp chương trình là 460800
```
ESPBAUD     ?= 460800
```
- Thực hiện build thử project esp8266-nonos-sdk-boilerplate, nếu thành công sẽ xuất hiện thư mục firmware chứa firmware để nạp xuống.

### Cấu trúc dự án sau khi build thành công

```
esp8266-nonos-sdk-boilerplate
.
├── build
│   ├── esp8266-nonos-app.a
│   ├── esp8266-nonos-app.out
│   └── user
│       ├── rfinit.o
│       └── user_main.o
├── firmware
│   ├── esp8266-nonos-app0x00000.bin
│   └── esp8266-nonos-app0x10000.bin
├── include
│   └── user_config.h
├── Makefile
├── README.md
├── SublimeAStyleFormatter.sublime-settings
└── user
    ├── Makefile
    ├── rfinit.c
    └── user_main.c

5 directories, 13 files

```

## Mã nguồn
```
esp8266-nonos-sdk-boilerplate/user_main.c
#include "osapi.h"
#include "user_interface.h"

void ICACHE_FLASH_ATTR print_info()
{
  uart_div_modify(0, UART_CLK_FREQ / 115200);
  os_printf("\r\n\r\n[INFO] BOOTUP...\r\n");
  os_printf("[INFO] SDK: %s\r\n", system_get_sdk_version());
  os_printf("[INFO] Chip ID: %08X\r\n", system_get_chip_id());
  os_printf("[INFO] Memory info:\r\n");
  system_print_meminfo();

  os_printf("[INFO] -------------------------------------------\n");
  os_printf("[INFO] Build time: %s\n", BUID_TIME);
  os_printf("[INFO] -------------------------------------------\n");

}


void ICACHE_FLASH_ATTR app_init()
{


  print_info();


  wifi_set_opmode_current(STATION_MODE);

}

void ICACHE_FLASH_ATTR user_init(void)
{
  system_init_done_cb(app_init);

}

```

Chương trình sẽ in ra màn hình một số thông tin về SDK, ID chip và thông tin về Memory, thời gian build,..
###Lưu ý
- Tốc độ baud hiển thị thông tin ra terminal là 115200

## Kết quả
Sau khi build và nạp chương trình xuống sẽ hiện thông báo như sau
```
[INFO] BOOTUP...
[INFO] SDK: 2.0.0(656edbf)
[INFO] Chip ID: 00135C7D
[INFO] Memory info:
data  : 0x3ffe8000 ~ 0x3ffe836c, len: 876
rodata: 0x3ffe8370 ~ 0x3ffe8574, len: 516
bss   : 0x3ffe8578 ~ 0x3ffee808, len: 25232
heap  : 0x3ffee808 ~ 0x3fffc000, len: 55288
[INFO] -------------------------------------------
[INFO] Build time: 2016-Th10-31_00:02:21_ICT
[INFO] -------------------------------------------
bcn 0
del if1
usl
mode : sta(5c:cf:7f:13:5c:7d)
add if0
```
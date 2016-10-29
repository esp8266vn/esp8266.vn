[TOC]

# Biên dịch dự án đầu tiên 

Trước khi biên dịch dự án mẫu, bạn cần phải cài đặt đầy đủ **Trình biên dịch**, tải về **esptool.py** và **ESP8266-NONOS-SDK** như hướng dẫn Cài đặt

Trong phần này sẽ trình bày rất chi tiết để biên dịch một dự án hoàn chỉnh, bao gồm một số kiến thức bổ trợ liên quan tới lập trình **C** và được giải thích rõ ràng, cẩn thận. Bạn có thể bỏ qua phần này nếu đã hiểu rõ về **lập trình C**

!!! note "Nội dung"
    Hiển thị `helloworld` trên terminal

## Lấy dự án mẫu từ Github: 

Bạn có thể lấy dự án mẫu từ github và biên dịch ngay:

```bash
git clone https://github.com/esp8266vn/esp-iot-basic.git
cd esp-iot-basic && make
```

## Sơ đồ file

```
esp-iot-basic
    |-- Makefile
    |-- main.c
    |-- rf_init.c
    `-- user_config.h
```
- `Makefile` Giúp cho công cụ `make` thực hiện việc biên dịch dự án một cách tự động
- `main.c` Chứa mã nguồn thực thi chính của chương trình
- `rf_init.c` Khi khởi động, {esp} sẽ thực hiện một số lệnh cấu hình RF (thu phát không dây), SDK sẽ gọi các hàm này. Bạn bắt buộc phải cung cấp giá trị trả về cho nó.
- `user_config.h` Khi biên dịch, SDK sẽ `include` file này, bạn có thể để file trống không nội dung.

### Makefile

```Makefile
#esp-iot-basic/Makefile
XTENSA    ?= 
SDK_BASE  ?= /tools/esp8266/sdk/ESP8266_NONOS_SDK 
ESPTOOL   ?= /tools/esp8266/esptool/esptool.py
SDK_LIBS  := -lc -lgcc -lhal -lphy -lpp -lnet80211 -lwpa -lmain\
            -llwip -lcrypto -ljson 
CC        := $(XTENSA)xtensa-lx106-elf-gcc
LD        := $(XTENSA)xtensa-lx106-elf-gcc
AR        := $(XTENSA)xtensa-lx106-elf-ar
LDFLAGS   = -nostdlib -Wl,--no-check-sections -u call_user_start -Wl,-static
CFLAGS    = -g -Wpointer-arith -Wundef -Wl,-EL -fno-inline-functions -nostdlib\ 
        -mlongcalls -mtext-section-literals -ffunction-sections -fdata-sections\
        -fno-builtin-printf -DICACHE_FLASH\
        -I.\
        -I$(SDK_BASE)/include
LD_SCRIPT = -T$(SDK_BASE)/ld/eagle.app.v6.ld 

all: main.bin

main.bin: main.out
  $(ESPTOOL) elf2image $(ESPTOOL_FLASHDEF) main.out -o main
  
main.out: main.a
  @echo "LD main.out"
  $(LD) -L$(SDK_BASE)/lib $(LD_SCRIPT) $(LDFLAGS) -L$(SDK_BASE)/lib\
  -Wl,--start-group $(SDK_LIBS) main.a -Wl,--end-group -o main.out 

main.a: main.o
  @echo "AR main.o"
  $(AR) cru main.a main.
  
main.o:
  @echo "CC main.c & rf_init.c"
  $(CC) $(CFLAGS) -c main.c -o main.o <14>
  $(CC) $(CFLAGS) -c rf_init.c -o rf_init.o <14>
  
clean:
  rm -rf *.o *.bin *.a *.out 
  
flash:
  $(ESPTOOL) --port /dev/tty.SLAB_USBtoUART \
                   --baud 480600 \
                   write_flash --flash_freq 40m --flash_mode dio --flash_size 32m \
                   0x00000 main0x00000.bin \
                   0x10000 main0x10000.bin \
                   0x3fc000 $(SDK_BASE)/bin/esp_init_data_default.bin
.PHONY: all clean flash
```

!!! note "Lưu ý"
    Nếu bạn sử dụng ví dụ này cho bản Unofficial Developement KIT trên Windows, với đường dẫn cài đặt mặc định là `C:\Espressif`, Makefile cần thay đổi như sau:

```makefile
XTENSA    ?=
SDK_BASE  ?= C:/Espressif/ESP8266_SDK
ESPTOOL   ?= C:/Espressif/utils/ESP8266/esptool.py
...
# Ví dụ cổng serial dùng để nạp cho ESP8266 là COM3:
flash:
   $(ESPTOOL) --port COM3 \
          --baud 480600 \
          write_flash --flash_freq 40m --flash_mode dio --flash_size 32m \
          0x00000 main0x00000.bin \
          0x10000 main0x10000.bin \
          0x3fc000 $(SDK_BASE)/bin/esp_init_data_default.bin
```

Giải thích Makefile như sau:

- `XTENSA` Đường dẫn tới trình biên dịch, để trống nếu bạn đã thêm vào biến môi trường `PATH` của hệ điều hành, hoặc có dạng `/tools/esp8266/compiler/xtensa-lx106-elf/bin/`
- `SDK_BASE` Đường dẫn tới **SDK**, nếu là Windows có dạng `C:\Espressif\ESP8266_NONOS_SDK`
- `ESPTOOL` Đường dẫn tới **esptool.py**, nhớ đảm bảo quyền thực thi cho file này (thực hiện lệnh `chmod +x`)
- `SDK_LIBS` Các thư viện đi kèm với **SDK**, ví dụ nếu bạn dùng `smartconfig` thì thêm vào `-lsmartconfig`
- `CC`, `AR`, `LD` Định nghĩa ngắn gọn Compiler, Linker, Archiver
- `LDFLAGS` là cờ dành cho Linker 
- `CFLAGS` là cờ dành cho Compiler
- Cờ `-I.` để báo Compiler biết có thể tìm header file (từ khóa `#include`) trong thư mục hiện tại và SDK include
- `LD_SCRIPT` Linker scirpt mặc định của **SDK** cho chip ESP8266
- Mặc định khi gọi `make` hay `make all` sẽ gọi `all`, nhưng trước đó sẽ cần gọi `main.bin`

- Thực hiện `make clean` xóa hết các file được tạo ra khi gọi `make all`
- Thực hiện `make flash` để nạp ESP8266, cần chắc chắc mạch nạp đã được kết nối máy tính, và tên cổng được thay thế đúng cho `/dev/tty.SLAB_USBtoUART`. Bạn có thể tìm hiểu thêm về việc đọc tên công COM trên máy tính tại (OSX, Windows, Linux)

!!! warning "Quan trọng"
    * Dấu `\` báo chưa kết thúc dòng trong Makefile
    * Trong `Makefile`, luôn luôn đặt chế độ Indent là Tab, nếu dùng Space sẽ báo lỗi `Makefile:35: *** missing separator.  Stop.`


Các bạn có thể tìm hiểu rõ hơn về Makefile bằng google với từ khóa `Makefile basic`. Makefile này như là 1 kịch bản đơn giản nhất để công cụ `make` thực hiện việc biên dịch mã nguồn **C** sang mã máy để nạp cho ESP8266. Mục đích để bản nắm rõ hơn về cách thức hoạt động của SDK, trình biên dịch. Các ví dụ sau này sẽ dùng Makefile phức tạp hơn, và được cung cấp kèm với các dự án mẫu tại https://github.com/esp8266vn

### rf_init.c

```c
//esp-iot-basic/rf_init.c
#include <stdio.h>
#include "osapi.h"
#include "user_interface.h"

void __attribute__((weak)) user_rf_pre_init(void) //Hàm này sẽ được SDK gọi cấu hình công suất phát WiFi
{
  system_phy_set_rfoption(1);
  system_phy_set_max_tpw(82); //công suất truyền, Giá trị từ 1-82
}

uint32_t __attribute__((weak)) user_rf_cal_sector_set(void) 
{
  enum flash_size_map size_map = system_get_flash_size_map();
  uint32 rf_cal_sec = 0;

  switch (size_map) {
    case FLASH_SIZE_4M_MAP_256_256:
      rf_cal_sec = 128 - 5;
      break;

    case FLASH_SIZE_8M_MAP_512_512:
      rf_cal_sec = 256 - 5;
      break;

    case FLASH_SIZE_16M_MAP_512_512:
    case FLASH_SIZE_16M_MAP_1024_1024:
      rf_cal_sec = 512 - 5;
      break;

    case FLASH_SIZE_32M_MAP_512_512:
    case FLASH_SIZE_32M_MAP_1024_1024:
      rf_cal_sec = 1024 - 5;
      break;

    default:
      rf_cal_sec = 0;
      break;
  }
  return rf_cal_sec;
}
```

### main.c

```c
#include <stdio.h>
#include "osapi.h"
#include "user_interface.h"

void app_init()
{
    os_printf("hello world\r\n");
}

void user_init(void)
{
    system_init_done_cb(app_init);
}
```

## Biên dịch

Thực hiện biên dịch dự án
```bash
cd esp-iot-basic
make clean
make
make flash
```

Màn hình Terminal kết thúc như sau là đã hoàn thành việc ghi vào ESP8266:

```bash
esptool.py v1.2-dev
Connecting...
Running Cesanta flasher stub...
Flash params set to 0x0240
Writing 32768 @ 0x0... 32768 (100 %)
Wrote 32768 bytes at 0x0 in 0.8 seconds (334.0 kbit/s)...
Writing 196608 @ 0x10000... 196608 (100 %)
Wrote 196608 bytes at 0x10000 in 4.7 seconds (334.5 kbit/s)...
Writing 4096 @ 0x3fc000... 4096 (100 %)
Wrote 4096 bytes at 0x3fc000 in 0.1 seconds (320.4 kbit/s)...
Leaving...
```

## Kết quả

Mở cổng COM bằng bất kỳ phần mềm nào hỗ trợ. Windows có thể sử dụng teraterm, putty; MacOS/OSX, Linux thì sử dụng screen, minicom. Sau khi kết nối xong, bấm nút RESET trên board phát triển, bạn sẽ nhận được 1 loạt các ký tự lạ đầu tiên. Đó là các ký tự do các module của SDK sinh ra, nhưng trước khi ứng dụng mẫu cấu hình đúng tốc độ Baud:

```bash
...
hello world
scandone
```

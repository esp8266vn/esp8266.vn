# Truyền nhận UART

ESP8266 có 2 UART, trong đó UART0 có đầy đủ 2 tính năng TX, RX, và dùng làm ngõ ra mặc định cho các thông tin debug cho SDK, cũng như là cổng nạp chương trình.

Tổ chức file căn cứ theo bài [Biên dịch dự án đầu tiên](./compile-first-time.md), bổ sung thêm file `uart.c`, `uart.h` để cấu hình cổng UART0 cho việc nhận dữ liệu

- UART0 của ESP8266 hỗ trợ 128 Byte FIFO và tính năng Ngắt Timeout, ngắt khi đầy FIFO. Có thể hiểu nếu bạn cấu hình ngắt 128 bytes FIFO, và ngắt Timeout, khi UART nhận đầy FIFO sẽ kích hoạt ngắt đầy FIFO, hoặc nếu trường hợp chưa đầy FIFO nhưng qua 1 khoảng thời gian (có thể cấu hình được) mà không nhận được dữ liệu nữa thì cũng phát sinh ngắt TOUT 
- Bạn có thể lấy driver trực tiếp từ bài này hoặc các ví dụ từ SDK mà không phải làm gì nữa nếu việc truyền nhận không quá phức tạp


!!! note "Nội dung"
    Khi nhận được ký tự `1` từ Terminal, bật đèn LED, xuất nội dung `LED On` trở lại, và `0` sẽ tắt, xuất nội dung `LED Off`

## Lấy dự án về từ Github: 

```
git clone https://github.com/esp8266vn/eps-iot-uart
cd eps-iot-uart
make
```

## Sơ đồ file

```
esp-iot-uart
    |-- Makefile
    |-- main.c
    |-- rf_init.c
    |-- uart.c
    |-- uart.h
    |-- led_btn.c
    |-- led_btn.h
    `-- user_config.h
```

Ta sẽ gom phần [LED](./blink-led.md) và [Nút nhấn](./button.md) thành 1 file `led_btn.c`. Bổ sung thêm file `uart.c` để cấu hình UART

## Mã nguồn


```c
//main.c
#include <stdio.h>
#include "osapi.h"
#include "user_interface.h"
#include "led_btn.h"
#include "uart.h"

void btn_pressed()
{
    led_toggle();
}
void uart_received(char data)
{
  if(data == '0') {
    led_off();
    os_printf("LED off\n");
  } else if(data == '1') {
    led_on();
    os_printf("LED on\n");
  }
}
void app_init()
{
    led_init();
    btn_init(btn_pressed);
    uart_setup(uart_received);
}
void user_init(void)
{
    system_init_done_cb(app_init);
}
```

Nội dung file [uart.c](https://github.com/esp8266vn/eps-iot-uart/blob/master/uart.c) khá dài, có thể xem trực tiếp trên github


 

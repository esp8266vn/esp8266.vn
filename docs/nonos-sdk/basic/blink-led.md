
# Bật tắt LED

Tổ chức file căn cứ theo bài [Biên dịch dự án đầu tiên](./compile-first-time.md), toàn bộ cấu trúc file, **Makefile, user_config.h, rf_init.c** giữ nguyên, chỉ thay đổi nội dung file `main.c`. 

!!! note "Nội dung"
    Chớp tắt đèn LED mỗi 1 giây

## Lấy dự án về từ Github: 

```bash
git clone https://github.com/esp8266vn/esp-iot-led-blink.git
cd esp-iot-led-blink && make
```

## Sơ đồ file

```
esp-iot-led-blink
    |-- Makefile
    |-- main.c
    |-- rf_init.c
    `-- user_config.h
```

## Mã nguồn

```c
//esp-led/main.c
#include <stdio.h>
#include "osapi.h"
#include "user_interface.h"
static os_timer_t led_timer;
static int led_value = 0;
void led_service_cb(void *args) //Hàm này sẽ được gọi khi soft timer `led_timer` hoàn thành việc đếm 
{
    led_value ^= 0x01;
    //Ghi giá trị ra LED IO, `led_value` khi thực hiện **XOR** với 1 sẽ đảo giá trị giữa 1 và 0
    WRITE_PERI_REG(RTC_GPIO_OUT, (READ_PERI_REG(RTC_GPIO_OUT) & (uint32_t)0xfffffffe)| (uint32_t)(led_value & 1)); 
    os_printf("Blink\r\n");
}
void app_init()
{
    //Cấu hình ngõ ra UART 115200 baud
    uart_div_modify(0, UART_CLK_FREQ / 115200); 

    //Cấu hình chân LED là chức năng chính GPIO, ngõ ra 
    WRITE_PERI_REG(PAD_XPD_DCDC_CONF, (READ_PERI_REG(PAD_XPD_DCDC_CONF) & 0xffffffbc)| (uint32_t)0x1);  
    WRITE_PERI_REG(RTC_GPIO_CONF, (READ_PERI_REG(RTC_GPIO_CONF) & (uint32_t)0xfffffffe)| (uint32_t)0x0); 
    WRITE_PERI_REG(RTC_GPIO_ENABLE, (READ_PERI_REG(RTC_GPIO_ENABLE) & (uint32_t)0xfffffffe)| (uint32_t)0x1); 
    
    //Cấu hình địa chỉ hàm gọi khi timer `led_timer` đếm xong 
    os_timer_setfn(&led_timer, (os_timer_func_t *)led_service_cb, NULL); 

    //Cấu hình `led_timer` tới hạn trong 1000 mili giây và khởi động lại khi tới hạn
    os_timer_arm(&led_timer, 1000, 1); 
}

void user_init(void)
{
    system_init_done_cb(app_init);
}

```


Ở phần này chúng ta sẽ biết thêm về cách thức đọc/ghi thanh ghi của ESP8266, đồng thời sử dụng Software Timer:

- Để ghi vào thanh ghi, chúng ta dùng định nghĩa: `WRITE_PERI_REG` với tham số đầu tiên là địa chỉ thanh ghi, thông số thứ 2 là giá trị. Tương tự với việc đọc, định nghĩa `READ_PERI_REG` chỉ cần 1 tham số là địa chỉ thanh ghi, và trả về giá trị của thanh ghi.
- Trước khi sử dụng Software Timer, cần định nghĩa trước biến chưa thông tin là `os_timer_t led_timer`, khởi tạo hàm sẽ gọi khi Timer đến tới hạn với `os_timer_setfn` và `os_timer_arm` với tham số thứ 3 = 1 đảm bảo sẽ lặp lại việc đếm liên tục.

## Gợi ý

Có thể tìm thấy định nghĩa các địa chỉ thanh ghi tại thư mục chứa SDK `$SDK_BASE\include\eagle_soc.h`. Ngoài ra, bạn có thể tham khảo việc cấu hình GPIO16 tại `$SDK_BASE\driver_lib\gpio16.c` 


## Cảnh báo

Chân `GPIO16` của ESP8266 là chân khá đặc biệt, sử dụng chung với RTC OUTPUT, dùng ở chế độ DEEPSLEEP, khi RTC tới hạn và khởi động Chip bằng cách hạ mức thấp chân này. Nếu bạn thiết kế ứng dụng cần sử dụng chế độ ngủ DEEPSLEEP thì đừng sử dụng chân GPIO16 cho mục đích khác, ngoại trừ việc nối thẳng vào chân nRST (chân **32** của ESP8266)

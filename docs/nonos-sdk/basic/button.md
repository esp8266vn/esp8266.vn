# Nút nhấn

Tổ chức file căn cứ theo bài [Biên dịch dự án đầu tiên](./compile-first-time.md), bao gồm các file `Makefile`, `main.c`, `rf_init.c`, `user_config.h`. Tuy nhiên chỉ thay đổi nội dung file `main.c`

!!! note "Nội dung"
    Nhấn nút thì chớp tắt đèn LED


## Lấy dự án về từ Github: 

```
git clone https://github.com/esp8266vn/eps-iot-button
cd eps-iot-button
make
```

## Sơ đồ file

```
esp-iot-button
    |-- Makefile
    |-- main.c
    |-- rf_init.c
    `-- user_config.h
```

## Mã nguồn

```c
//esp-button/main.c
#include "osapi.h"
#include "user_interface.h"
#include "gpio.h"
#define BTN_PIN 0 //GPIO0 
static int led_value = 0;
void key_intr_handler(void *args); //Khai báo `prototype` 
void app_init()
{
    //Cấu hình chân GPIO16 là ngõ ra, điều khiển đèn LED
  WRITE_PERI_REG(PAD_XPD_DCDC_CONF, (READ_PERI_REG(PAD_XPD_DCDC_CONF) & 0xffffffbc) | (uint32_t)0x1);

  //Cấu hình chân GPIO16 là ngõ ra, điều khiển đèn LED
  WRITE_PERI_REG(RTC_GPIO_CONF, (READ_PERI_REG(RTC_GPIO_CONF) & (uint32_t)0xfffffffe) | (uint32_t)0x0);
  WRITE_PERI_REG(RTC_GPIO_ENABLE,(READ_PERI_REG(RTC_GPIO_ENABLE) & (uint32_t)0xfffffffe) | (uint32_t)0x1);
  
  //Cấu hình `key_intr_handler` là hàm xử lý ngắt GPIO
  ETS_GPIO_INTR_ATTACH(key_intr_handler, NULL);

  //Vô hiệu hóa ngắt GPIO để việc cấu hình không ảnh hưởng
  ETS_GPIO_INTR_DISABLE();

  //Lựa chọn chức năng cho GPIO0 sử dụng In/Out Logic
  PIN_FUNC_SELECT(PERIPHS_IO_MUX_GPIO0_U, FUNC_GPIO0);

  //Cấu hình GPIO0 hoạt động như ngõ vào (Input)
  gpio_output_set(0, 0, 0, GPIO_ID_PIN(BTN_PIN));
  gpio_register_set(GPIO_PIN_ADDR(BTN_PIN), GPIO_PIN_INT_TYPE_SET(GPIO_PIN_INTR_DISABLE)
                      | GPIO_PIN_PAD_DRIVER_SET(GPIO_PAD_DRIVER_DISABLE)
                      | GPIO_PIN_SOURCE_SET(GPIO_AS_PIN_SOURCE));

  //Xóa cờ ngắt GPIO
  GPIO_REG_WRITE(GPIO_STATUS_W1TC_ADDRESS, BIT(BTN_PIN));

  //Cấu hình ngắt GPIO0 cạnh xuống
  gpio_pin_intr_state_set(GPIO_ID_PIN(BTN_PIN), GPIO_PIN_INTR_NEGEDGE);

  //Cho phép ngắt GPIO
  ETS_GPIO_INTR_ENABLE();
}
void user_init(void)
{
  system_init_done_cb(app_init);
}
void key_intr_handler(void *args)
{
  //Đọc trạng thái ngắt GPIO hiện tại
  uint32 gpio_status = GPIO_REG_READ(GPIO_STATUS_ADDRESS);
  if (gpio_status & BIT(BTN_PIN)) { //Chắc chắn rằng ngắt xuất phát từ GPIO0
    //Ghi giá trị đảo để hiển thị LED
    led_value ^= 0x01;
    led_value ^= 0x01;
    WRITE_PERI_REG(RTC_GPIO_OUT, (READ_PERI_REG(RTC_GPIO_OUT) & (uint32_t)0xfffffffe) | (uint32_t)(led_value & 1));
  }
  GPIO_REG_WRITE(GPIO_STATUS_W1TC_ADDRESS, BIT(BTN_PIN));  //Xóa ngắt GPIO
}
```

Nút nhấn sẽ giúp việc ESP8266 khởi động một hành động nào đó khi cần thiết. Trong nhiều ứng dụng chúng ta hầu như đều cần những kích hoạt từ bên ngoài. Xuyên suốt cuốn sách này, sẽ dùng nút nhấn để kích hoạt chạy các ứng dụng mẫu cũng như đèn LED để thông báo các trạng thái. Trong phần này, nhấn nút đèn LED sẽ chuyển trạng thái (từ sáng -> tắt và ngược lại). 

Đây là ví dụ đơn giản, trong thực tế việc xử lý nút nhấn khá phiền phức. Bởi vì nút nhấn vật lý khi được nhấn sẽ tạo ra hàng loạt các xung lên xuống (nhiễu, bouncing...). Thường thì chỉ cần đảm bảo mức Logic của chân đo được đã được giữ ổn định trong khoảng 100 mili giây là được xem đã ổn định. 

Ngoài cách dùng ngắt để xác định nút nhấn có được nhấn hay không - cách này sẽ tiết kiệm tài nguyên tính toán của CPU, nó chỉ được gọi khi có sự kiện sảy ra, thì còn một cách nữa là hỏi vòng: Cách này đỏi hỏi CPU liên tục kiểm tra xem mức Logic của nút nhấn. Đồng thời việc đáp ứng cũng không nhanh bằng sử dụng ngắt. 

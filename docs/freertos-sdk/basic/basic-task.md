TOC

# Luồng (Thread) / Tác vụ (Task) trong FreeRTOS
// Đang xây dựng...

# Mã nguồn ví dụ
``` bash
git clone https://github.com/esp8266vn/esp-rtos-basic-task.git
```

# Makefile
Cấu trúc của Makefile trong ví dụ này cũng tương tự [Makefile cho dự án phức tạp sử dụng NONOS-SDK](https://esp8266.vn/nonos-sdk/basic/complex-makefile/).
Tuy nhiên, để sử dụng cho RTOS SDK thì một số biến trong Makefile cần thay đổi như sau:

```Makefile
# Đường dẫn tới RTOS-SDK
SDK_BASE    ?= C:/Espressif/ESP8266_RTOS_SDK
...
# Thư viện sử dụng 
SDK_LIBS = gcc hal phy pp net80211 wpa crypto main freertos lwip minic smartconfig
...
# Thư mục đưa vào include
SDK_INC = extra_include include include/espressif include/json include/udhcp include/lwip include/lwip/lwip include/lwip/ipv4 include/lwip/ipv6
...
# Cờ khi biên dịch C
CFLAGS = -g -save-temps -std=gnu90 -Os -Wpointer-arith -Wundef -Werror \
         -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals \
         -mno-serialize-volatile -D__ets__ -DICACHE_FLASH -DBUID_TIME=\"$(DATETIME)\" 
...
# Comment-out dòng này:
# ifeq ("$(USE_OPENSDK)","yes")
# CFLAGS        += -DUSE_OPENSDK
# else
# CFLAGS        += -D_STDINT_H
# endif
```

# Cấu trúc chương trình `user_main.c`

Chương trình có nhiệm vụ tạo ra 2 task riêng biệt, một dùng để nháy LED có chu kỳ 200 `ticks`, task còn lại để in thông tin ra UART0 với chu kỳ 1000 `ticks`.

Muốn vậy, trước hết phải tạo ra 2 hàm con, tuân theo tiền khai báo có dạng `void tên_hàm(void *tham_số)` cho 2 task LED và UART:

```C
void task_led(void *pvParameters)
{
    for(;;){
        vTaskDelay(100);
        GPIO_OUTPUT_SET(LED_GPIO, led_state);
        led_state ^=1;
    }
}

void task_printf(void *pvParameters)
{
    for(;;){
        printf("task_printf\n");
        vTaskDelay(500);
    }
}
```

!!! note "Lưu ý"
    Bên trong hàm con phải thực hiện vòng lặp vô tận, không được return. Vì mục đích là tạo task chạy liên tục mãi mãi.

Sau đó, trong hàm `user_init` của ESP8266, sau khi khởi tạo các giá trị cần thiết cho UART và chân GPIO để nháy LED, sử dụng hàm xTaskCreate trong FreeRTOS để tạo task thực thi 2 hàm con này, cú pháp xTaskCreate:

```C
BaseType_t xTaskCreate(    TaskFunction_t pvTaskCode,
                            const char * const pcName,
                            unsigned short usStackDepth,
                            void *pvParameters,
                            UBaseType_t uxPriority,
                            TaskHandle_t *pxCreatedTask
                          );
```

Trong đó:

- `pvTaskCode`: trỏ đến hàm con cần thực hiện khi tạo task
- `pcName`: chuỗi biểu thị tên mô tả task này
- `usStackDepth`: độ lớn của con trỏ ngăn xếp, chọn sao cho lớn hơn độ lớn của con trỏ ngăn xếp khi thực hiện hàm con, ví dụ như khi hàm con gọi càng nhiều hàm khác bên trong lồng nhau, khi đó độ lớn này càng tăng.
- `pvParameters`: con trỏ đến tham số truyền cần truyền vào hàm con khi task khởi tạo.
- `uxPriority`: mức độ ưu tiên của task.
- `pxCreatedTask`: con trỏ đến biến kiểu `TaskHandle_t`, dùng để sau khi gọi `xTaskCreate`, biến này sẽ được gán để sử dụng cho mục đích sau, ví dụ như xóa task này.
Sử dụng `xTaskCreate` để tạo task LED và UART như sau:

```C
xTaskCreate(task_led, "task_led", 256, NULL, 2, NULL);
xTaskCreate(task_printf, "task_printf", 256, NULL, 2, NULL);
```

# Biên dịch và chạy chương trình

```bash
make clean
make
```

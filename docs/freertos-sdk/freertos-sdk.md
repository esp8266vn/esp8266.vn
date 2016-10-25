# Giới thiệu RTOS SDK của ESP8266

Đây là bản SDK sử dụng hệ điều hành thời gian thực (Real Time Operation System) _port_ từ FreeRTOS cho ESP8266.

FreeRTOS là RTOS miễn phí vốn được _port_ cho rất nhiều MCU khác nhau (ARM7, Cortex M...)

[Tham khảo chi tiết về FreeRTOS](http://www.freertos.org/)

[Download FreeRTOS source code](http://www.freertos.org/a00104.html)

[Tham khảo FreeRTOS API](http://www.freertos.org/a00106.html)


# Lưu ý

Khi sử dụng ESP8266_RTOS_SDK cần lưu ý:

- Bản **ESP8266_RTOS_SDK** và **ESP8266_NONOS_SDK** sử dụng chung API.
- Sử dụng freeRTOS timer hay `os_timer` không được dùng `while(1)` hoặc các hàm có tác dụng tương tự vì nó sẽ **block** luồng thực thi lệnh (task/thread)
- Việc thực thi lệnh trong hàm callback của timer không được kéo dài quá **15ms**
- Không được định nghĩa biến kiểu `os_timer_t` là cục bộ (local) mà phải định nghĩa là biến toàn cục (global), biến tĩnh (static) hoặc biến trong vùng nhớ cấp phát bằng `os_malloc`
- Kể từ phiên bản ESP8266_RTOS_SDK_v1.2.0, hàm mặc định được lưu trong vùng _CACHE_ nên không cần phải khai báo hàm với `_ICACHE_FLASH_ATTR_` nữa. Kể cả hàm thực thi ngắt cũng vậy. Nếu cần phân bổ hàm trong RAM (để gọi nhiều lần) thì khai báo hàm với `IRAM_ATTR`
- _Network programming use socket, please do not bind to the same port_ ???
- Task ưu tiên cao nhất của RTOS SDK là 14. `xTaskCreate` là hàm dùng tạo task trong FreeRTOS, tham khảo [API của FreeRTOS](http://www.freertos.org/a00106.html)
    + Kích thước stack (ngăn xếp) cho task cho phép trong khoảng từ 176 -> 512 bytes
    + Nếu trong task có biến mảng local nào đó vượt quá 60 bytes thì khuyến cáo nên dùng `os_malloc` và `os_free`, vì kích thước biến cục bộ quá lớn có thể gây rò rỉ đến stack của task,
    + Một số mức ưu tiên trong RTOS SDK: của pp task là 13, của precise timer (ms) là 12, của TCP/IP task là 10, của freeRTOS timer là 2 và task idle (rỗi) là 0. 
    + Người dùng có thể dùng mức ưu tiên từ 1 -> 9
    + Điều quan trọng cuối cùng: là không được định nghĩa/thay đổi file `FreeRTOSConfig.h` vì nó sẽ ảnh hưởng đến thư viện RTOS bên trong SDK (chỉ được nhà sản xuất có quyền thay đổi)





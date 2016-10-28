[TOC]

## Digital IO

Tên chân trong Arduino (Pin number) giống với thứ tự chân của ESP8266. `pinMode`, `digitalRead`, và `digitalWrite` đều sử dụng Pin Number như nhau, ví dụ như đọc GPIO2, gọi hàm `digitalRead(2)`.

Chân GPIO0..15 có thể là `INPUT`, `OUTPUT`, hay `INPUT_PULLUP`.
Chân GPIO16 có thể là `INPUT`, `OUTPUT` hay `INPUT_PULLDOWN_16`. Khi khởi động, tất cả các chân sẽ được cấu hình là `INPUT`.

Mỗi chân có thể phục vụ cho một tính năng nào đó, ví dụ `Serial`, `I2C`, `SPI`. Và tính năng đó sẽ được cấu hình đúng khi sử dụng thư viện. Hình bên dưới thẻ hiện sơ đồ chân đối với module ESP-12 phổ biến.

![Pin Functions](../images/esp12.png)

GPIO6 và GPIO11 không được thể hiện bởi vì nó được sử dụng cho việc kết nối với Flash. Việc sử dụng 2 chân này có thể gây lỗi chương trình.

!!! note "Lưu ý"
    Một số board và module khác (ví dụ ESP-12ED, NodeMCU 1.0) không có GPIO9 và GPIO11, họ sử dụng với chế độ `DIO` cho Flash, trong khi ESP12 chúng ta nói bên trên sử dụng chế độ `QIO`

Ngắt GPIO hỗ trợ thông qua các hàm  `attachInterrupt`, `detachInterrupt` 
Ngắt GPIO có thể gán cho bất kỳ GPIO nào, ngoại trừ `GPIO16`. Đều hỗ trợ các ngắt tiêu chuẩn của Arduino như: `CHANGE`, `RISING`, `FALLING`.



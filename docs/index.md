:imagesdir: images

## ESP8266

ESP8266 là dòng chip tích hợp Wi-Fi 2.4Ghz có thể lập trình được, rẻ tiền được sản xuất bởi một công ty bán dẫn Trung Quốc: Espressif Systems.

Được phát hành đầu tiên vào tháng 8 năm 2014, đóng gói đưa ra thị trường dạng Mô dun ESP-01, được sản xuất bởi bên thứ 3: AI-Thinker. Có khả năng kết nối Internet qua mạng Wi-Fi một cách nhanh chóng và sử dụng rất ít linh kiện đi kèm. Với giá cả có thể nói là rất rẻ so với tính năng và khả năng ESP8266 có thể làm được.

ESP8266 có một cộng đồng các nhà phát triển trên thế giới rất lớn, cung cấp nhiều Module lập trình mã mở giúp nhiều người có thể tiếp cận và xây dựng ứng dụng rất nhanh.

Hiện nay tất cả các dòng chip ESP8266 trên thị trường đều mang nhãn ESP8266EX, là phiên bản nâng cấp của ESP8266

### Sơ đồ chân & Sơ đồ khối


.Sơ đồ chân & sơ đồ khối ESP8266EX
![](images/ESP8266_SOC2.svg)

### Thông số phần cứng
* 32-bit RISC CPU : Tensilica Xtensa LX106 running at 80 MHz
* Hổ trợ Flash ngoài từ 512KiB đến 4MiB
* 64KBytes RAM thực thi lệnh
* 96KBytes RAM dữ liệu
* 64KBytes boot ROM
* Chuẩn wifi EEE 802.11 b/g/n, Wi-Fi 2.4 GHz
** Tích hợp TR switch, balun, LNA, khuếch đại công suất và matching network
** Hổ trợ WEP, WPA/WPA2, Open network
* Tích hợp giao thức TCP/IP
* Hổ trợ nhiều loại anten
* 16 chân GPIO
* Hổ trợ SDIO 2.0, UART, SPI, I²C, PWM,I²S với DMA
* 1 ADC 10-bit
* Dải nhiệt độ hoạt động rộng : -40C ~ 125C

### SDK hỗ trợ chính thức từ hãng

Tại thời điểm xuất bản sách này, Espressif đã hỗ trợ 2 nền tảng SDK (Software Development Kit - Gói phát triển phần mềm) độc lập, là: **NONOS SDK** và **RTOS SDK**. Cả 2 đều có những ưu điểm riêng phù hợp với từng ứng dụng nhất định, và sử dụng chung nhiều các hàm điều khiển phần cứng. Tuy nhiên **NONOS SDK** được hỗ trợ cập nhật sớm nhất, nhiều tính năng nhất và đơn giản, dễ sử dụng hơn. Chính vì vậy **NONOS SDK** sẽ là SDK được sử dụng chính thức ở tất cả các hướng dẫn của cuốn sách này.

#### ESP8266 NONOS SDK

Hiện nay, **NONOS SDK** phiên bản từ **2.0.0** trở lên đã ổn định và cung cấp gần như là đầy đủ tất cả các tính năng mà ESP8266 có thể thực hiện:

* Các API cho Timer, System, Wifi, đọc ghi SPI Flash, Sleep và các Module phần cứng: GPIO, SPI, I²C, PWM, I²S với DMA.
* `Smartconfig`: Hỗ trợ cấu hình thông số Wi-Fi cho ESP8266 nhanh chóng.
* `Sniffer` API: Bắt các gói tin trong mạng không dây 2.4Ghz.
* `SNTP` API: Đồng bộ thời gian với Máy chủ thời gian.
* `WPA2 Enterprise` API: Cung cấp việc quản lý kết nối Wi-Fi bằng tài khoản sử dụng các máy chủ RADIUS.
* `TCP/UDP` API: Cho kết nối internet, và hỗ trợ các Module dựa trên, như: HTTP, MQTT, CoAP.
* `mDNS` API: Giúp tìm ra **IP** của thiết bị trong mạng nội bộ bằng tên (hostname).
* `MESH` API: Liên kết các module ESP8266 với cấu trúc mạng MESH
* `FOTA` API: Firmware Over The Air - cập nhật firmware từ xa cho thiết bị .
* `ESP-Now` API: Sử dụng các gói tin Wireless 2.4GHz trao đổi trực tiếp với ESP8266 khác mà không cần kết nối tới Access Point.
* `Simple Pair` API: Thiết lập kết nối bảo mật giữa 2 thiết bị tự động.


#### ESP8266 RTOS SDK

**RTOS SDK** sử dụng **FreeRTOS** làm nền tảng, đồng thời hầu hết các API của **NON OS** SDK đều có thể sử dụng với **RTOS SDK**.

### ESP8285

ESP8285 là một phiên bản khác sau này của ESP8266EX, giống hoàn toàn ESP8266EX ngoại trừ việc thay vì dùng SPI FLASH bên ngoài thì ESP8285 tích hợp 1MiB Flash bên trong giúp giảm diện tích phần cứng và đơn giản hóa quá trình sản xuất.

### Sơ đồ chân

### Thông số phần cứng

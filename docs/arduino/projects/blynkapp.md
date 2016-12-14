# Sử dụng ứng dụng Blynk trong Iot
#Giới thiệu về Blynk

<img src="../images/blynk/blynk1.jpg" width="200" height="200" border="0" alt="blynk icon">

Phần mềm Blynk là một phần mềm được thiết kế trên nền tảng Android và iOS cho phép
 tự tạo ứng dụng kết nối với các board Arduino, Raspberry và các bo mạch khác để điểu khiển chúng.

Blynk giúp bạn điều khiển thiết bị từ xa qua internet, thu thập dữ liệu của cảm biến, ảo hóa việc giao tiếp và thực hiện nhiều việc khác
#Nguyên lý hoạt động

<img src="../images/blynk/blynk2.png" width="500" height="400" border="0" alt="blynk">

Nguyên lý làm việc là khi bạn nhấn nút điều khiển, lệnh sẽ được truyền về server của Blynk, sau đó Blynk gửi lệnh về module điều khiển, module sau khi chạy lệnh sẽ gửi lại kết quả theo quy trình ngược lại nghĩa là từ thiết bị gửi về server rồi từ server gửi về điện thoại của bạn.

# Ví dụ sử dụng Blynk để bật tắt Led sử dụng board iot-wifi-uno

##Chuẩn bị:

Board ESP8266 NodeMCU


Arduino IDE 1.6.8, tải từ [Arduino website](https://www.arduino.cc/en/Main/OldSoftwareReleases#previous).

Smart phone androi hoặc ios

##Hướng dẫn
###1.Tải ứng dụng Blynk
Tải ứng dụng tại trang chủ ứng dụng [http://www.blynk.cc/](http://www.blynk.cc/). Hoặc tìm và cài Blynk trên Google Play hoặc App Store.
###2.Tải thư viện Blynk cho Arduino IDE
Tải thư viện tại địa chỉ:[https://github.com/blynkkk/blynk-library](https://github.com/blynkkk/blynk-library)
Sau khi tải mở Arduino Ide ->Sketch->Include Library -> Add .zip library và tìm đến file.zip bạn mới tải về ->OK.
###3.Kết nối mạch điện:




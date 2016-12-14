# Sử dụng ứng dụng Blynk trong Iot
#Giới thiệu về Blynk

<img src="../images/blynk/blynk1.jpg" width="200" height="200" border="0" alt="blynk icon">

Phần mềm Blynk là một phần mềm được thiết kế trên nền tảng Android và iOS cho phép
 tự tạo ứng dụng kết nối với các board Arduino, Raspberry và các bo mạch khác để điểu khiển chúng.

Blynk giúp bạn điều khiển thiết bị từ xa qua internet, thu thập dữ liệu của cảm biến, ảo hóa việc giao tiếp và thực hiện nhiều việc khác
#Nguyên lý hoạt động

<img src="../images/blynk/blynk2.png" width="500" height="400" border="0" alt="blynk">

Nguyên lý làm việc là khi nhấn nút điều khiển, lệnh sẽ được truyền về server của Blynk, sau đó Blynk gửi lệnh về module điều khiển, module sau khi chạy lệnh sẽ gửi lại kết quả theo quy trình ngược lại nghĩa là từ thiết bị gửi về server rồi từ server gửi về điện thoại.

# Ví dụ sử dụng Blynk để bật tắt Led và đo nhiệt độ,độ ẩm.

##Chuẩn bị:

Board ESP8266 NodeMCU


Arduino IDE 1.6.8, tải từ [Arduino website](https://www.arduino.cc/en/Main/OldSoftwareReleases#previous).

Smart phone androi hoặc ios

##Hướng dẫn
###1.Tải ứng dụng Blynk
Tải ứng dụng tại trang chủ ứng dụng [http://www.blynk.cc/](http://www.blynk.cc/). Hoặc tìm và cài đặt Blynk trên Google Play hoặc App Store.
###2.Tải thư viện Blynk cho Arduino IDE
Tải thư viện tại địa chỉ:[https://github.com/blynkkk/blynk-library](https://github.com/blynkkk/blynk-library)
Sau khi tải mở Arduino Ide ->Sketch->Include Library -> Add .zip library và tìm đến file.zip bạn mới tải về ->OK.
###3.Kết nối mạch điện:

Nối mạch định theo sơ đồ sau:

<img src="../images/blynk/blynkled.png" width="700" height="500" border="0" alt="blynk">
###4.Tạo dự án trên Blynk:

###Làm theo hướng dẫn sau:

Nhập địa chỉ E-mail và mật khẩu để tạo tài khoản Blynk

<img src="../images/blynk/led1.jpg" width="400" height="600" border="0" alt="blynk">

Tạo 1 Project mới

<img src="../images/blynk/led2.jpg" width="400" height="600" border="0" alt="blynk">

Thiết lập như trong hình

<img src="../images/blynk/led2_1.png" width="400" height="600" border="0" alt="blynk">

Tạo một nút nhấn

<img src="../images/blynk/led3.jpg" width="400" height="600" border="0" alt="blynk">

<img src="../images/blynk/led4.jpg" width="400" height="600" border="0" alt="blynk">

<img src="../images/blynk/led5.jpg" width="400" height="600" border="0" alt="blynk">

Trong đó:

5  Tên button.

6  Chân truyền nhận giữ liệu của Board.

7  Chọn kiểu nút nhấn có nhớ hoặc không nhớ.

Xác định Auth Token của Project

<img src="../images/blynk/led6.jpg" width="400" height="600" border="0" alt="blynk">

<img src="../images/blynk/led7.jpg" width="400" height="600" border="0" alt="blynk">

<img src="../images/blynk/led8.jpg" width="400" height="600" border="0" alt="blynk">

<img src="../images/blynk/led9.jpg" width="400" height="600" border="0" alt="blynk">

Nhấn vào E-mail để Blynk gửi Auth Token của Project vào E-mail đăng kí tài khoản hoặc copy Auth Token.

###5.Nạp code cho Arduino 

Sau khi tải thư viện và cài đặt.Mở Arduino IDE và upload chương trình sau:
```cpp
#define BLYNK_PRINT Serial    
#include <ESP8266WiFi.h>
#include <BlynkSimpleEsp8266.h>

char auth[] = "YourAuthToken";    //AuthToken vừa copy bên Blynk Project
char ssid[] = "YourNetworkName";    //Tên wifi muốn truy cập
char pass[] = "YourPassword";        //Mật khẩu(Nếu wifi không có mật khẩu thì để "" )

void setup()
{
  Serial.begin(9600);
  Blynk.begin(auth, ssid, pass);
}

void loop()
{
  Blynk.run();
}
```




###6.Điểu khiển bật tắt led bằng Blynk:
Mở Project led trong Blynk.Bấm Play và bật tắt nút nhấn để điều khiển led.

<img src="../images/blynk/led10.jpg" width="500" height="400" border="0" alt="blynk">













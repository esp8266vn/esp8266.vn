#Thư viện WiFiManager

Thư viện WiFiManager hỗ trợ ESP8266 mở 1 Webserver + 1 Access Point(AP), để user có thể kết nối vào và cấu hình wifi password.

Access Point là một điểm truy cập mạng không dây có khả năng truyền và nhận dữ liệu thông qua kết nối wifi.

#Nguyên lý làm việc của thư viên WiFiManager

Khi khởi động ,ESP sẽ ở chế độ Station(điểm thu sóng) và thử kết nối với các Access Point(điểm phát sóng) đã lưu trước đó.

Nếu không thể kết nối,ESP sẽ chuyển qua chế độ AP và tạo một Webserver .Có thể kết nối vào AP vừa được tạo và cấu hình wifi cho ESP.

##Ví dụ ứng dụng thư viện WiFiManager sử dụng board iot-wifi-uno

##Chuẩn bị

Board iot-wifi-uno. [https://github.com/iotmakervn/iot-wifi-uno-hw](https://github.com/iotmakervn/iot-wifi-uno-hw).


Arduino IDE 1.6.8, tải từ [Arduino website](https://www.arduino.cc/en/Main/OldSoftwareReleases#previous).

##Hướng dẫn


###1.Tải thư viện WiFiManager:

Mở  Arduino vào Sketch -> Include Library -> Manager Libraries.
Tìm kiếm thư viện WiFiManager và bấm Install.

![Managerwifi](../images/manager4.png)

###2.Cài đặt board Generic ESP8266 Module:

Vào File->Preferences.

Trong ô Additional Boards Manager URLS dán đường dẫn sau:
```cpp
http://arduino.esp8266.com/stable/package_esp8266com_index.json
```
![Managerwifi](../images/manager2.png)

Vào Tool->Board->Board Manager . Tìm và cài đặt như hình.Tiếp theo trong Tool -> Board,tìm và chọn Board Generic ESP8266 Module.

![Managerwifi](../images/manager3.png)

###3.Nạp chương trình cho iot-wifi-uno:

Sau khi cài đặt thư viện và board,tiến hành nạp chương trình sau vào board iot-wifi-uno bằng Arduino IDE
```cpp
#include <ESP8266WiFi.h>  
#include <DNSServer.h>
#include <ESP8266WebServer.h>
#include <WiFiManager.h>         


void setup() {
    Serial.begin(115200);
    WiFiManager wifiManager;
    wifiManager.autoConnect("AutoConnectAP");
    Serial.println("connected...");
}

void loop() {
    // put your main code here, to run repeatedly:
    
}
```
###4.Kết nối với AP và cấu hình wifi:

Sau khi reset board,trong Networks sẽ xuất hiện 1 AP mới . Hãy chọn và kết nối như trong hình.

![Managerwifi](../images/manager6.png)

AP này là mạng wifi mở,
có thể cài đặt password cho AP bằng cách thay lệnh:

``` cpp wifiManager.autoConnect("AutoConnectAP")```

Bằng lệnh

``` cpp wifiManager.autoConnect("AutoConnectAP", "password")```

(password là mật khẩu đặt cho AP)


Sử dụng thiết bị có thể kết nối wifi kết nối vào AP vừa được tạo.Bằng cách trên cửa sổ trình duyệt gõ địa chỉ ```192.168.4.1```.Sẽ hiện ra một cửa sổ cấu hình.

![Managerwifi](../images/manager7.png)

Chọn Configure WIFI,chọn tên wifi muốn kết nối,nhập mật khẩu vào bấm SAVE.

![Managerwifi](../images/manager8.jpeg)

Nếu nhập mật khẩu đúng ESP sẽ tự động kết nối vào mạng wifi vừa được chọn.

Như vậy ESP đã được kết nối với wifi.
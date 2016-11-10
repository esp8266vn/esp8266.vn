# Tổng quan
ESP Touch là protocol được dùng trong Smart Config để người dùng có thể kết nối tới các phiên bản modul ESP8266 thông qua cấu hình đơn giản trên Smartphone.
Ban đầu không thể kết nối với ESP8266, nhưng thông qua giao thức ESP-TOUCH thì Smartphone sẽ gửi gói UDP tới Access Point(AP) ở đây là ESP8266, mã hóa SSID và mật khẩu thành trường Length trong gói UDP, để ESP8266 có thể hiểu và giải mã được thông tin.

Cấu trúc gói tin sẽ có dạng

| 6  | 6  | 2      | 3   | 5    | Variable | 4   |
|----|----|--------|-----|------|----------|-----|
| DA | SA | Length | LLC | SNAP | DATA     | FCS |

Length bao gồm SSID và thông tin key cho ESP8266

# Phần mềm cho android và iOS
Có thể tải file apk dành cho android tại 
[ESP-Touch Android](https://espressif.com/sites/default/files/apks/esptouchandroid-apk_v0.3.4.3_0.rar)

Hoặc tải trực tiếp từ Playstore
[ESP8266 SmartConfig](https://play.google.com/store/apps/details?id=com.cmmakerclub.iot.esptouch&hl=vi)

Và file cho iOS
[ESP-Touch iOS](https://espressif.com/sites/default/files/apks/esptouchios-ipa_v0.3.4.3_0.rar)

# Hoạt động
- Kích hoạt chức năng Smart Config bằng cách lập trình và nạp firmware cho ESP
- Kết nối smartphone với router 
- Mở ESP-TOUCH App đã cài đặt trên smartphone
- Kiểm tra SSID (tương ứng với tên Wifi) và mật khẩu (ở đây là mật khẩu wifi của bạn) để kết nối tới thiết bị.

# Kết quả
- Nếu thành công sẽ có thông báo trên smartphone về địa chỉ IP của ESP8266 như sau
```
Esptouch success, bssid = xxxx, InnetAddress = 192.168.xx.xx
```

- Ngược lại sẽ có thông báo Esptouch fail.
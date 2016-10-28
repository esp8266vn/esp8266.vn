# Thư viện ESP8266WiFi
Thư viện ESP8266WiFi có khung giống như các thư viện wifi khác. Những điểm khác biệt gồm :

- **WiFi.mode(m)**: thiết lập chế độ **WIFI_AP**, **WIFI_STA**, **WIFI_AP_STA** hoặc **WIFI_OFF**.
- Gọi **WiFi.softAP(ssid)** để thiết lập một open network
- Gọi **WiFi.softAP(ssid, password)** để thiết lập **WPA2-PSK** ( mật khấu ít nhất 8 ký tự )
- **WiFi.macAddress(mac)** cho **STA**, **WiFi.softAPmacAddress(mac)** cho **AP**.
- **WiFi.localIP()** cho **STA**, **WiFi.softAPIP()** cho **AP**.
- **WiFi.printDiag(Serial)** sẽ hiển thị những thông tin dự đoán
- **WiFiUDP** lớp hổ trợ gữi và nhận các gói tin multicast trên giao diện STA. Khi gữi một gói tin multicast, thay thế **udp.beginPacket(addr, port)** bằng **udp.beginPacketMulticast(addr, port, WiFi.localIP())**. Khi đang lắng nghe những gói tin multicast, thay thế **udp.begin(port)** bằng **udp.beginMulticast(WiFi.localIP()**, **multicast_ip_addr, port)**. Bạn có thể sử dụng **udp.destinationIP()** để phân biệt gói tin nhận được đến multicast hoặc địa chỉ unicast.

**WiFiServer**, **WiFiClient**, và **WiFiUDP** thực hiện theo cùng một cách như khung thư viện WiFi. Có bốn ví dụ được làm mẫu cho thư viện này. Bạn có thể xem chi tiết các lệnh ở đây : [http://www.arduino.cc/en/Reference/WiFi](https://www.arduino.cc/en/Reference/WiFi)
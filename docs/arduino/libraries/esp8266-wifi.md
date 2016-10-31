[TOC]

# Thư viện ESP8266WiFi
Thư viện ESP8266WiFi có khung giống như các thư viện wifi khác. Bên cạnh đó cũng có những điểm khác biệt, gồm :

- `WiFi.mode(m)`: thiết lập chế độ `WIFI_AP`, `WIFI_STA`, `WIFI_AP_STA` hoặc `WIFI_OFF`.
- Gọi `WiFi.softAP(ssid)` để thiết lập một open network
- Gọi `WiFi.softAP(ssid, password)` để thiết lập `WPA2-PSK` ( mật khấu ít nhất 8 ký tự )
- `WiFi.macAddress(mac)` cho `STA`, `WiFi.softAPmacAddress(mac)` cho `AP`.
- `WiFi.localIP()` cho `STA`, `WiFi.softAPIP()` cho `AP`.
- `WiFi.printDiag(Serial)` sẽ hiển thị những thông tin dự đoán
- `WiFiUDP` lớp hổ trợ gữi và nhận các gói tin multicast trên giao diện STA. Khi gữi một gói tin multicast, thay thế `udp.beginPacket(addr, port)` bằng `udp.beginPacketMulticast(addr, port, WiFi.localIP())`. Khi đang lắng nghe những gói tin multicast, thay thế `udp.begin(port)` bằng `udp.beginMulticast(WiFi.localIP()`, `multicast_ip_addr, port)`. Bạn có thể sử dụng `udp.destinationIP()` để phân biệt gói tin nhận được đến multicast hoặc địa chỉ unicast.

`WiFiServer`, `WiFiClient`, và `WiFiUDP` thực hiện theo cùng một cách như khung thư viện WiFi. Có bốn ví dụ được làm mẫu cho thư viện này. Bạn có thể xem chi tiết các lệnh ở đây : [http://www.arduino.cc/en/Reference/WiFi](https://www.arduino.cc/en/Reference/WiFi)

# Ticker
Thư viện cho phép gọi lại hàm với một chu kỳ nhất định. Gồm có hai ví dụ.

Ở thời điểm hiện tại nó không được phép ngăn chặn các hoạt động của IO (network, serial, file) từ hàm gọi lại Ticker. Thay vào đó, thiết lập một cờ bên trong hàm gọi lại Ticker và kiểm tra cờ đó bên trong hàm lặp.

Đường dẫn sau là thư viện thường dùng `simplificate` Ticker và tránh reset WDT : [TickerScheduler](https://github.com/Toshik/TickerScheduler)

# EEPROM

EEPROM của ESP8266 có sự khác biệt nhỏ so với EEPROM chuẩn. Để sử dụng, cần gọi `EEPROM.begin(size)` trước khi bắt đầu đọc hoặc ghi, `size` là số bytes muốn sử dụng. Số bytes đó có thể ở bất cứ đâu trong khoảng 4 và 4096 bytes.

`EEPROM.write()` không viết trực tiếp lên flash, mà cần phải gọi `EEPROM.commit()` trước khi muốn thay đổi, lưu trữ lên flash. `EEPROM.end()` cũng sẽ ghi nhận và sẽ cho phép RAM sao chép nội dung chứa trong EEPROM.

Thư viện EEPROM sử dụng một vùng của flash, ngay sau SPIFFS.

Gồm có ba ví dụ.

# I2C (Wire library)

Thư viện `Wire` hiện tại chỉ hổ trợ chế độ master lên đến 450KHz. Trước khi sử dụng I2C, chân SDA và SCL cần phải đước thiết lập bằng cách gọi `Wire.begin(int sda, int scl)`, i.e. `Wire.begin(0, 2)` đối với module ESP-01, các module ESP khác mặc định chân 4 (SDA) và 5 (SCL).

# SPI 

Thư viện SPI hổ trợ hoàn toàn Arduino SPI, API gồm trao đổi dữ liệu, thiết lập phase (CPHA). Việc thiết lập `Clock polarity (CPOL ) không được hổ trợ ( `SPI_MODE2` và `SPI_MODE3` không làm việc.

# SoftwareSerial

Một thư viện SoftwareSerial cho ESP8266 được viết bởi Peter Lerup (@plerup) hổ trợ tốc độ baud lên đến 115200 và nhiểu SoftwareSerial khác. Xem [https://github.com/plerup/espsoftwareserial](https://github.com/plerup/espoftwareserial ) nếu bạn muốn đề gữi bản cải tiến hoặc mở một vấn đề liên quan đến SoftwareSerial.

#  ESP-specific APIs 

APIs đề cập đến `deep sleep` và `watchdog timer` có tác dụng với các ESP phiên bản Alpha.

`ESP.deepSleep(microseconds, mode)` sẽ đưa chip vào chế độ `deep sleep`, với `mode` là một trong cách thông số `WAKE_RF_DEFAULT`, `WAKE_RFCAL`, `WAKE_NO_RFCAL`, `WAKE_RF_DISABLED`. ( GPIO16 cần được nối tới RST để đưa chip ra khỏi `deepSleep` )

`ESP.rtcUserMemoryWrite(offset, &data, sizeof(data))` và `ESP.rtcUserMemoryRead(offset, &data, sizeof(data))` cho phép dữ liệu được lưu trữ vào bộ nhớ và lấy dữ liệu từ `RTC user memory` của chip tương ứng. Tổng kích thước của `RTC user memory` là 512 bytes, do đó `offser + sizeof(data) không được vượt quá 512 bytes. Dữ liệu được xếp thành từng phần 4-bytes. Dữ liệu đã được lưu trữ có thể được dùng giữ các chu kỳ `deep sleep`. Tuy nhiên, dữ liệu có thể bị mất sau `power cycling` của chip.

`ESP.restart()` khởi động lại CPU.

`ESP.getResetReason()` trả về chuỗi chứa nguyên do thiết lập lại ở định dạng mà con người hiểu được.

`ESP.getFreeHeap()` trả về kích thước heap trống.

`ESP.getChipId()` trả về ID chip ESP8266 như một số nguyển 32-bit.

Một số API có thể được sử dụng để biết thông tin về flash :

`ESP.getFlashChipId()` trả về ID chip flash theo số nguyên 32-bit. 

`ESP.getFlashChipSize()` trả về dung lượng của chip flash theo bytes, như được thấy trong SDK ( dung lượng flash có thể nhỏ hơn dung lượng thực tế ).

`ESP.getFlashChipSpeed(void)` trả về tần số của flash theo `Hz`.

`ESP.getCycleCount()` trả về số chu kỳ mà CPU đã thực hiện kể từ khi bắt đầu bằng số nguyên 32-bit. Điều này rất hưu ích để biết chính xác thời gian thực hiện những công việc được thực hiện rất nhanh, giống như bit banging.

`ESP.getVcc()` có thể được sử dụng để đo điện áp cung cấp. ESP cẩn phải cấu hình lại ADC lúc khởi động để tính năng có sẳn. Thêm dòng lệnh sau ở đầu chương trình thức việc việc này để sử dụng `getVcc` :
	ADC_MODE(ADC_VCC);

Chân TOUT phải ngắt kết nối ở chế độ này.

**Chú ý** mặc định ADC được cấu hình để đọc từ chân TOUT, việc sử dụng `analogRead(A0)`, và `ESP.getVCC()` không có hiệu lực.

# mDNS và trả lời DNS-SD (Thư viện ESP8266mDNS)

Cho phép **the sketch** để đáp lại các truy vấn multicast DNS để các tên miền giống **"foo.local"**, và DNS-SD (nhận biết dịch vụ) truy vấn. Xem ví dụ đính kèm để biết chi tiết.

# Trả lời SSDP (ESP8266SSDP) 

SSDP là giao thức nhận biết dịch vụ, hổ trở trên windowns **out of the box - bên ngoài của hợp**. Xem ví dụ đính kèm để tham khảo.

# DNS server (DNSServer library) 

Thực hiện một DNS server đơn giản mà có thể sử dụng cả STA và AP. Các DNS server chỉ hổ trợ một domain ( để tất cả các domain khác nó sẽ trả lới với NXDOMAIN hoặc mã trạng thái khách hàng ). Với Client có thể mở một web server chạy trên ESP8266 sử dụng một tên domain, không cần địa chỉ IP. Xem ví dụ đính kèm để biết thêm chi tiết.

# Servo 

Thư viện trình bày khả năng điều khiển động cơ servo RC. Thư viện hổ trợ tối đa 24 servo trên bất kỳ chân output có sẳn. Theo mặc định 12 servo đầu tiên sẽ sử dụng Timer0 và hiện tại sẽ không dùng cho bất kỳ hộ trợ nào khác. Đến 12 Servo tiếp theo sử dụng Timer1 và tính năng sử dụng nó sẽ được thực hiện. Trong khi nhiều động cơ Servo RC sẽ chấp nhận mức điện áp ở các chân IO là 3.3V từ ESP8266. Phần lớn sẽ không thể chạy với điện áp 3.3V, sẽ cần một nguồn điện phù hợp với các thông số của Servo. Cần kết nối mass chung giữa ESP8266 và nguồn của động cơ Servo.

# Other libraries (not included with the IDE) 
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

Thư viện SPI hổ trợ hoàn toàn Arduino SPI, API gồm trao đổi dữ liệu, thiết lập phase (CPHA). Việc thiết lập `Clock polarity` (CPOL ) không được hổ trợ ( `SPI_MODE2` và `SPI_MODE3` không làm việc.

# SoftwareSerial

Một thư viện SoftwareSerial cho ESP8266 được viết bởi Peter Lerup (@plerup) hổ trợ tốc độ baud lên đến 115200 và nhiểu SoftwareSerial khác. Xem [https://github.com/plerup/espsoftwareserial](https://github.com/plerup/espoftwareserial ) nếu bạn muốn đề gữi bản cải tiến hoặc mở một vấn đề liên quan đến SoftwareSerial.

#  ESP-specific APIs 

APIs đề cập đến deep sleep và watchdog timer có tác dụng với các ESP phiên bản Alpha.

`ESP.deepSleep(microseconds, mode)` sẽ đưa chip vào chế độ deep sleep, với `mode` là một trong cách thông số `WAKE_RF_DEFAULT`, `WAKE_RFCAL`, `WAKE_NO_RFCAL`, `WAKE_RF_DISABLED`. ( GPIO16 cần được nối tới RST để đưa chip ra khỏi deepSleep )

`ESP.rtcUserMemoryWrite(offset, &data, sizeof(data))` và `ESP.rtcUserMemoryRead(offset, &data, sizeof(data))` cho phép dữ liệu được lưu trữ vào bộ nhớ và lấy dữ liệu từ `RTC user memory` của chip tương ứng. Tổng kích thước của `RTC user memory` là 512 bytes, do đó `offser + sizeof(data)` không được vượt quá 512 bytes. Dữ liệu được xếp thành từng phần 4-bytes. Dữ liệu đã được lưu trữ có thể được dùng giữ các chu kỳ `deep sleep`. Tuy nhiên, dữ liệu có thể bị mất sau `power cycling` của chip.

`ESP.restart()` khởi động lại CPU.

`ESP.getResetReason()` trả về chuỗi chứa nguyên do thiết lập lại ở định dạng mà con người hiểu được.

`ESP.getFreeHeap()` trả về kích thước heap trống.

`ESP.getChipId()` trả về ID chip ESP8266 như một số nguyển 32-bit.

- Một số API có thể được sử dụng để biết thông tin về flash :

`ESP.getFlashChipId()` trả về ID chip flash theo số nguyên 32-bit. 

`ESP.getFlashChipSize()` trả về dung lượng của chip flash theo bytes, như được thấy trong SDK ( dung lượng flash có thể nhỏ hơn dung lượng thực tế ).

`ESP.getFlashChipSpeed(void)` trả về tần số của flash theo `Hz`.

`ESP.getCycleCount()` trả về số chu kỳ mà CPU đã thực hiện kể từ khi bắt đầu bằng số nguyên 32-bit. Điều này rất hưu ích để biết chính xác thời gian thực hiện những công việc được thực hiện rất nhanh, giống như bit banging.

`ESP.getVcc()` có thể được sử dụng để đo điện áp cung cấp. ESP cẩn phải cấu hình lại ADC lúc khởi động để tính năng có sẳn. Thêm dòng lệnh sau ở đầu chương trình thức việc việc này để sử dụng `getVcc` :

`ADC_MODE(ADC_VCC);`

Chân TOUT phải ngắt kết nối ở chế độ này.

**Chú ý** mặc định ADC được cấu hình để đọc từ chân TOUT, việc sử dụng `analogRead(A0)`, và `ESP.getVCC()` không có hiệu lực.

# mDNS và trả lời DNS-SD (Thư viện ESP8266mDNS)

Cho phép **sketch** để đáp lại các truy vấn multicast DNS để các tên miền giống **"foo.local"**, và DNS-SD (nhận biết dịch vụ) truy vấn. Xem ví dụ đính kèm để biết chi tiết.

# Trả lời SSDP (ESP8266SSDP) 

SSDP là giao thức nhận biết dịch vụ, hổ trở trên windowns **out of the box - bên ngoài của hợp**. Xem ví dụ đính kèm để tham khảo.

# DNS server (DNSServer library) 

Thực hiện một DNS server đơn giản mà có thể sử dụng cả STA và AP. Các DNS server chỉ hổ trợ một domain ( để tất cả các domain khác nó sẽ trả lới với NXDOMAIN hoặc mã trạng thái khách hàng ). Với Client có thể mở một web server chạy trên ESP8266 sử dụng một tên domain, không cần địa chỉ IP. Xem ví dụ đính kèm để biết thêm chi tiết.

# Servo 

Thư viện trình bày khả năng điều khiển động cơ servo RC. Thư viện hổ trợ tối đa 24 servo trên bất kỳ chân output có sẳn. Theo mặc định 12 servo đầu tiên sẽ sử dụng Timer0 và hiện tại sẽ không dùng cho bất kỳ hộ trợ nào khác. Đến 12 Servo tiếp theo sử dụng Timer1 và tính năng sử dụng nó sẽ được thực hiện. Trong khi nhiều động cơ Servo RC sẽ chấp nhận mức điện áp ở các chân IO là 3.3V từ ESP8266. Phần lớn sẽ không thể chạy với điện áp 3.3V, sẽ cần một nguồn điện phù hợp với các thông số của Servo. Cần kết nối mass chung giữa ESP8266 và nguồn của động cơ Servo.

# Các thư viện khác (Không bao gồm IDE) 

Những thư viện không dựa vào quyền truy cập cấp thấp đến những thanh ghi AVR nên làm việc ổn định. Dưới đây là một vài thư viện được xác minnh để làm việc:

[Adafruit_ILI9341](https://github.com/Links2004/Adafruit_ILI9341) - luồng của Adafruit ILI9341 cho ESP8266

[arduinoVNC](https://github.com/Links2004/arduinoVNC) - VNC Client cho Arduino

[arduinoWebSockets](https://github.com/Links2004/arduinoWebSockets) - WebSocket Server và Client tương thích với ESP8266 (RFC6455)

[aREST](https://github.com/marcoschwartz/aREST) - thư viện REST API handler

[Blynk](https://github.com/blynkkk/blynk-library) - IoT framework cho các Maker ( kiểm trả ở trang [Kickstarter page](http://tiny.cc/blynk-kick)

[DallasTemperature](https://github.com/milesburton/Arduino-Temperature-Control-Library.git)

[DHT-sensor-library ](https://github.com/adafruit/DHT-sensor-library) - thư viện Arduino cho cảm biến nhiệt độ, độ ẩm DHT11/DHT22. Tải phiên bản thư viện mới nhất v1.1.1 và không thay đổi nếu không cần thiết. Một phiên bản cũ hơn cũng có thể cho phép DHT nhu **DHT dht(DHTPIN, DHTTYPE, 15)**

[DimSwitch](https://github.com/krzychb/DimSwitch) - điều khiển chấn lưu điện từ cho ống đèn huỳnh quang từ xa như là sử dụng công tắt trên tường.

[Encoder](https://github.com/PaulStoffregen/Encoder) - thư viện Arduino cho rotary encoders. Phiên bản 1.4 hổ trợ ESP8266.

[esp8266_mdns](https://github.com/mrdunk/esp8266_mdns) - truy vấn và trả lời mDNS trên ESP8266. Hoặc để mô tả nó theo các khác : một Client mDNS hoặc thư viện Bonjour Client cho ESP8266.

[ESPAsyncTCP](https://github.com/me-no-dev/ESPAsyncTCP) - thư viện TCP không đồng bộ cho ESP8266 và ESP32/31B

[ESPAsyncWebServer](https://github.com/me-no-dev/ESPAsyncWebServer) - thư viện không đồng bộ Web Server cho ESP82666 và ESP32/31B

[Homie for ESP8266](https://github.com/marvinroger/homie-esp8266) - khung Arduino cho ESP8266 thực hiện Homie, một hiệp ước MQTT cho IoT.

[NeoPixel](https://github.com/adafruit/Adafruit_NeoPixel) - thư viện NeoPixel của Adafruit, hiện nay hổ trợ cho các ESP8266 ( phiên bản 1.0.2 hoặc cao hơn từ thư viện quản lý của Arduino)

[NeoPixelBus](https://github.com/Makuna/NeoPixelBus) - thư viện Arduino NeoPixel tương thích với ESP8266. Dùng nhánh "DmaDriven" hoặc "UartDriven" cho ESP8266. Bao gồm hổ trợ màu HSL và nhiều hơn nửa.

[PubSubClient ](https://github.com/Imroy/pubsubclient) - thư viện MQTT của @Imroy

[RTC](https://github.com/Makuna/Rtc) - thư viện Arduino cho DS1307 và DS3231 tương thích với ESP8266.

[Souliss, Smart Home ](https://github.com/souliss/souliss) - khung cho Smart Home dựa trên Arduino, Arduino và OpenHAB.

[ST7735](https://github.com/nzmichaelh/Adafruit-ST7735-Library) - sửa đổi thư viện ST7735 của Adafruit để tương thích với ESP8266. Chỉ cần chắc chắn là sửa đổi các chân trong ví dụ mẫu như cách họ làm trong AVR.

[Task](https://github.com/Makuna/Task) - thư viện đa nhiệm Arduino Nonpreemptive. Tương tự như các thư viện mã nguồn bao gồm chức năng cung cấp, tức thư viện này có khả năng tương thích chéo.

[TickerScheduler](https://github.com/Toshik/TickerScheduler) - thư viện cũng cấp lịch trình đơn giản cho Ticker để tránh reset WDT.

[Teleinfo](https://github.com/hallard/LibTeleinfo) - thư viện Generic French Power Mểt để đọc Teleinfo dữ liệu giám sát năng lượng như sự tiêu thụ, kết nối, công suất, thời gian, ... Thư viện này là cross platform giữa ESP8266, Arduino, Particle, và C++ căn bản. French đã công cố [đề tặng](https://hallard.me/libteleinfo/) trên blog của tác giả và tất cả thông tin liên quan về [Teleinfo](https://hallard.me/category/tinfo/) cũng có ích.

[UTFT-ESP8266](https://github.com/gnulabis/UTFT-ESP8266) - thư viện hiển thị UTFT với sự hổ trợ cho ESP8266. Chỉ có hiện thị qua SPI được hổ trợ tới thời điểm hiện tại ( không có chế độ 8-bit song song,...). Cũng bao gồm các hổ trợ cho SPI vi điều khiển về phần cứng của ESP8266.

[WiFiManager](https://github.com/tzapu/WiFiManager) - quản lý kết nối wifi với web captive portal. Nếu không thể kết nối, nó bắt đầu khởi động chê độ AP và một cổng thông tin cấu hình để bạn có thể lựa chọn và nhập thông tin Wifi.

[OneWire](https://github.com/PaulStoffregen/OneWire) - thư viện cho chip Dallas/Maxim 1-Wire.

[Adafruit-PCD8544-Nokia-5110-LCD-Library](https://github.com/WereCatf/Adafruit-PCD8544-Nokia-5110-LCD-library)- luồng của Adafruit PCD8544 - thư viện cho ESP8266.

[PCF8574_ESP](https://github.com/WereCatf/PCF8574_ESP) - một thư viện rất đơn giản để sử dụng PCF8574/PCF8574A I2C 8-pin GPIO-expander.

[Dot Matrix Display Library 2](https://github.com/freetronics/DMD2) - Freetronics DMD & Generic 16 x 32 P10 thư viện hiển thị Dot Matrix.

[SdFat-beta](https://github.com/greiman/SdFat-beta) - thư viện SD-card với sự hổ trợ tên tập tin dài, phần mềm và phần cứng dựa trên SPI và nhiều thứ khác.

[FastLED](https://github.com/FastLED/FastLED) - một thư viện cho phép điều khiển dễ dàng và hiệu quả một loạt các LED chipset, giống như Neopixel (WS2812B), DotStar, LPD8806 và nhiều thứ khác. Bao gồm fading, gradient, chức năng chuyển đổi màu.

[OLED](https://github.com/klarsys/esp8266-OLED) - một thư viện để kiểm soát màn hình OLED qua kết nối I2C. Đã thử nghiệm với màn hình hiện thị đồ họa OLED 0.96 inch.

[MFRC522](https://github.com/miguelbalboa/rfid) - một thư viện để sử dụng Mifare RC522 RFID - thẻ đọc/ghi.

[Ping](https://github.com/dancol90/ESP8266Ping) - cho phép các ESP8266 ping một máy tính từ xa.
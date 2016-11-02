#Các thư viện khác (Không bao gồm IDE) 

Những thư viện không dựa vào quyền truy cập cấp thấp đến những thanh ghi AVR nên làm việc ổn định. Dưới đây là một vài thư viện được xác minnh để làm việc:

- [Adafruit_ILI9341](https://github.com/Links2004/Adafruit_ILI9341) - luồng của Adafruit ILI9341 cho ESP8266
- [arduinoVNC](https://github.com/Links2004/arduinoVNC) - VNC Client cho Arduino
- [arduinoWebSockets](https://github.com/Links2004/arduinoWebSockets) - WebSocket Server và Client tương thích với ESP8266 (RFC6455)
- [aREST](https://github.com/marcoschwartz/aREST) - thư viện REST API handler
- [Blynk](https://github.com/blynkkk/blynk-library) - IoT framework cho các Maker ( kiểm trả ở trang [Kickstarter page](http://tiny.cc/blynk-kick)
- [DallasTemperature](https://github.com/milesburton/Arduino-Temperature-Control-Library.git)
- [DHT-sensor-library ](https://github.com/adafruit/DHT-sensor-library) - thư viện Arduino cho cảm biến nhiệt độ, độ ẩm DHT11/DHT22. Tải phiên bản thư viện mới nhất v1.1.1 và không thay đổi nếu không cần thiết. Một phiên bản cũ hơn cũng có thể cho phép DHT nhu **DHT dht(DHTPIN, DHTTYPE, 15)**
- [DimSwitch](https://github.com/krzychb/DimSwitch) - điều khiển chấn lưu điện từ cho ống đèn huỳnh quang từ xa như là sử dụng công tắt trên tường.
- [Encoder](https://github.com/PaulStoffregen/Encoder) - thư viện Arduino cho rotary encoders. Phiên bản 1.4 hổ trợ ESP8266.
- [esp8266_mdns](https://github.com/mrdunk/esp8266_mdns) - truy vấn và trả lời mDNS trên ESP8266. Hoặc để mô tả nó theo các khác : một Client mDNS hoặc thư viện Bonjour Client cho ESP8266.
- [ESPAsyncTCP](https://github.com/me-no-dev/ESPAsyncTCP) - thư viện TCP không đồng bộ cho ESP8266 và ESP32/31B
- [ESPAsyncWebServer](https://github.com/me-no-dev/ESPAsyncWebServer) - thư viện không đồng bộ Web Server cho ESP82666 và ESP32/31B
- [Homie for ESP8266](https://github.com/marvinroger/homie-esp8266) - khung Arduino cho ESP8266 thực hiện Homie, một hiệp ước MQTT cho IoT.
- [NeoPixel](https://github.com/adafruit/Adafruit_NeoPixel) - thư viện NeoPixel của Adafruit, hiện nay hổ trợ cho các ESP8266 ( phiên bản 1.0.2 hoặc cao hơn từ thư viện quản lý của Arduino)
- [NeoPixelBus](https://github.com/Makuna/NeoPixelBus) - thư viện Arduino NeoPixel tương thích với ESP8266. Dùng nhánh "DmaDriven" hoặc "UartDriven" cho ESP8266. Bao gồm hổ trợ màu HSL và nhiều hơn nửa.
- [PubSubClient ](https://github.com/Imroy/pubsubclient) - thư viện MQTT của @Imroy
- [RTC](https://github.com/Makuna/Rtc) - thư viện Arduino cho DS1307 và DS3231 tương thích với ESP8266.
- [Souliss, Smart Home ](https://github.com/souliss/souliss) - khung cho Smart Home dựa trên Arduino, Arduino và OpenHAB.
- [ST7735](https://github.com/nzmichaelh/Adafruit-ST7735-Library) - sửa đổi thư viện ST7735 của Adafruit để tương thích với ESP8266. Chỉ cần chắc chắn là sửa đổi các chân trong ví dụ mẫu như cách họ làm trong AVR.
- [Task](https://github.com/Makuna/Task) - thư viện đa nhiệm Arduino Nonpreemptive. Tương tự như các thư viện mã nguồn bao gồm chức năng cung cấp, tức thư viện này có khả năng tương thích chéo.
- [TickerScheduler](https://github.com/Toshik/TickerScheduler) - thư viện cũng cấp lịch trình đơn giản cho Ticker để tránh reset WDT.
- [Teleinfo](https://github.com/hallard/LibTeleinfo) - thư viện Generic French Power Mểt để đọc Teleinfo dữ liệu giám sát năng lượng như sự tiêu thụ, kết nối, công suất, thời gian, ... Thư viện này là cross platform giữa ESP8266, Arduino, Particle, và C++ căn bản. French đã công cố [đề tặng](https://hallard.me/libteleinfo/) trên blog của tác giả và tất cả thông tin liên quan về [Teleinfo](https://hallard.me/category/tinfo/) cũng có ích.
- [UTFT-ESP8266](https://github.com/gnulabis/UTFT-ESP8266) - thư viện hiển thị UTFT với sự hổ trợ cho ESP8266. Chỉ có hiện thị qua SPI được hổ trợ tới thời điểm hiện tại ( không có chế độ 8-bit song song,...). Cũng bao gồm các hổ trợ cho SPI vi điều khiển về phần cứng của ESP8266.
- [WiFiManager](https://github.com/tzapu/WiFiManager) - quản lý kết nối wifi với web captive portal. Nếu không thể kết nối, nó bắt đầu khởi động chê độ AP và một cổng thông tin cấu hình để bạn có thể lựa chọn và nhập thông tin Wifi.
- [OneWire](https://github.com/PaulStoffregen/OneWire) - thư viện cho chip Dallas/Maxim 1-Wire.
- [Adafruit-PCD8544-Nokia-5110-LCD-Library](https://github.com/WereCatf/Adafruit-PCD8544-Nokia-5110-LCD-library)- luồng của Adafruit PCD8544 - thư viện cho ESP8266.
- [PCF8574_ESP](https://github.com/WereCatf/PCF8574_ESP) - một thư viện rất đơn giản để sử dụng PCF8574/PCF8574A I2C 8-pin GPIO-expander.
- [Dot Matrix Display Library 2](https://github.com/freetronics/DMD2) - Freetronics DMD & Generic 16 x 32 P10 thư viện hiển thị Dot Matrix.
- [SdFat-beta](https://github.com/greiman/SdFat-beta) - thư viện SD-card với sự hổ trợ tên tập tin dài, phần mềm và phần cứng dựa trên SPI và nhiều thứ khác.
- [FastLED](https://github.com/FastLED/FastLED) - một thư viện cho phép điều khiển dễ dàng và hiệu quả một loạt các LED chipset, giống như Neopixel (WS2812B), DotStar, LPD8806 và nhiều thứ khác. Bao gồm fading, gradient, chức năng chuyển đổi màu.
- [OLED](https://github.com/klarsys/esp8266-OLED) - một thư viện để kiểm soát màn hình OLED qua kết nối I2C. Đã thử nghiệm với màn hình hiện thị đồ họa OLED 0.96 inch.
- [MFRC522](https://github.com/miguelbalboa/rfid) - một thư viện để sử dụng Mifare RC522 RFID - thẻ đọc/ghi.
- [Ping](https://github.com/dancol90/ESP8266Ping) - cho phép các ESP8266 ping một máy tính từ xa.

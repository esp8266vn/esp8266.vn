# Đo nhiệt độ độ ẩm hiển thị lên ThingSpeak với HTTP

Đặt vấn đề: Trong thời đại kỷ nguyên kết nối như hiện nay thì việc đọc dữ liệu từ các thiết bị (cảm biến,...) gửi lên các serve là điều tối cơ bản mà một nhà phát triền cần có. Bài viết này sẽ đề cập tới vấn đề nói trên, đó là đọc và gửi các dữ liệu từ cảm biến DHT22 bằng board WiFi Uno lên Thingspeak với HTTP.

### Chuẩn bị các phần cứng cần thiết
- Board WiFi Uno.
- LCD OLED.
- DHT22 sensor.

<img src="../images-thingspeak/connect-part.png" alt="" height="500" width="500">

!!! note "Lưu ý"
 	Chân chân số 3 của cảm biến có thể nối xuống mass hoặc để vậy không kết nối nó.
 	Nếu cần thiết, có thể mắc thêm một điện trở 10k vào chân 1 (VCC) và chân 2 (OUTPUT).

### Cài một số thư viện cần thiết.

- Thư viện cho DHT 22 :
[https://github.com/ngoc-emg/DHT-sensor-library](https://github.com/ngoc-emg/DHT-sensor-library).

- Thư viện cho OLED SSD 1306, tham khảo một bài viết ở:
[https://github.com/esp8266vn/esp8266.vn/blob/master/docs/arduino/libraries/i2c.md](https://github.com/esp8266vn/esp8266.vn/blob/master/docs/arduino/libraries/i2c.md). Bài viết này có trình bày cách thêm các thư viện cần thiết cũng như các kết nối khá rõ.

- Về phần WiFi, sử dụng thư viện ESP8266WiFi, bạn có thể tải trực tiếp trên web hoặc vào libraries manager để cập nhật nó.

### Tạo một tài khoản trên ThingSpeak.
Có khá nhiều địa chỉ web cho phép theo dõi dữ liệu các cảm biến thông qua Internet như Google, Thingspeak... Tùy vào mục đích, yêu cầu mà chọn một địa chỉ thích hợp đối với từng người.
Bạn tạo một tài khoản Thingspeak, chọn một Channel, đặt tên và cài đặt cho nó như sau:

<img src="../images-thingspeak/thingspeak.png" alt="-" height="600" width="600">

<img src="../images-thingspeak/thingspeak1.png" alt="-" height="600" width="600">

!!! warning " Chú ý "
	 Tiếp theo là một phần khá quan trọng. Cần phải lấy được một API key, tốt nhất nên ghi lại nó để sau này dùng cho việc gửi dữ liệu lên Thingspeak.

<img src="../images-thingspeak/thingspeak2.png" alt="-" height="600" width="600"> 


### Code chương trình.

Trong code bên dưới, cần chú ý thay đổi SSID với password là tên, password một mạng không dây (WiFi) nơi bạn sử dụng. API key là mã đã được đề cập trong phần trước. Điền nó vào trong code!

```
// Declare DHT
#include "DHT.h"
#define DHTPIN D2
#define DHTTYPE DHT22
DHT dht(DHTPIN, DHTTYPE);
float t;
float h;
float f;
// Declare Oled LCD
#include <Wire.h>
#include "SSD1306.h"
SSD1306  display(0x3c, D3, D5);
#define DEMO_DURATION 3000
typedef void (*Demo)(void);
int demoMode = 0;
int counter = 1;
// Declare WiFi
#include <ESP8266WiFi.h>
const char* ssid     = "ZoKa";
const char* password = "Dinhmenh@24";
const char* host = "api.thingspeak.com";
const char* writeAPIKey = "VXYYDIYKV4G5IRY7";
/////////////////////////////////////////////////////////////
void setup() {
  	//Setup DHT
  	Serial.begin(115200);
  	Serial.println("DHTxx test!");
  	dht.begin();
  	// Setup Oled LCD
  	display.init();
  	display.flipScreenVertically();
  	// Setup WiFi
  	WiFi.begin(ssid, password);
  	while (WiFi.status() != WL_CONNECTED) {
   		delay(500);
  	}	
}
///////////////////////////////////////////////////////////
void readsensor() {
  	delay(2000);
  	h = dht.readHumidity();
  	t = dht.readTemperature();
  	f = dht.readTemperature(true);	
}
/////////////////////////////////////////////////////////////
void display_temp() {
  	display.setTextAlignment(TEXT_ALIGN_CENTER);
  	display.setFont(ArialMT_Plain_16);
  	display.drawString(64, 16, "Temperature");
  	display.drawString(64, 32, String(t));
  	display.drawString(95, 32, "*C");
}
////////////////////////////////////////////////////////////
void display_humi() {
  	display.setTextAlignment(TEXT_ALIGN_CENTER);
  	display.setFont(ArialMT_Plain_16);
  	display.drawString(64, 16, "Humidity");
  	display.drawString(64, 32, String(h));
  	display.drawString(95, 32, "%");
}
////////////////////////////////////////////////////////////
void Thingspeak() {
  	WiFiClient client;
  	const int httpPort = 80;
  	if (!client.connect(host, httpPort)) {
    		return;
  	}
	String url = "/update?key=";
	url += writeAPIKey;
	url += "&field1=";
  	url += String(t);
  	url += "&field2=";
  	url += String(h);
  	url += "\r\n";
 // Request to the server
  	client.print(String("GET ") + url + " HTTP/1.1\r\n" +
               "Host: " + host + "\r\n" +
               "Connection: close\r\n\r\n");
  	delay(1000);
}
////////////////////////////////////////////////////////////
Demo demos[] = {display_temp, display_humi};
int demoLength = (sizeof(demos) / sizeof(Demo));
long timeSinceLastModeSwitch = 0;
/////////////////////////////////////////////////////////////
void loop() {
  	readsensor();
  	display.clear();
  	demos[demoMode]();
  	display.setTextAlignment(TEXT_ALIGN_RIGHT);
  	display.drawString(10, 128, String(millis()));
  	display.display();
  	if (millis() - timeSinceLastModeSwitch > DEMO_DURATION) {
    	demoMode = (demoMode + 1)  % demoLength;
    	imeSinceLastModeSwitch = millis();
  	}
  	counter++;
  	delay(10);
  	Thingspeak();
}
```

### Mục đích của bài hướng dẫn này.

Sau khi code xong thì hệ hệ thống này sẽ có khả năng:

- Đọc được các giá trị của cảm biến.

- Hiển thị các thông số nhiệt độ lên LCD OLED.

- Cập nhật các dữ liệu cảm biến lên Thingspeak.

Bên dưới là các hình ảnh hoạt động hệ thống !

<img src="../images-thingspeak/demo.jpg" alt="-" height="600" width="600"> 

<img src="../images-thingspeak/demo1.jpg" alt="-" height="600" width="600"> 

<img src="../images-thingspeak/thingspeak3.png" alt="-" height="600" width="600"> 

### Một số link hữu ích:

- Bài viết tham khảo
[http://www.instructables.com/id/Send-sensor-data-DHT11-BMP180-to-ThingSpeak-with-a/step4/Using-just-the-ESP8266/](http://www.instructables.com/id/Send-sensor-data-DHT11-BMP180-to-ThingSpeak-with-a/step4/Using-just-the-ESP8266/)

- Cám ơn tác giả 
[http://file.ebook777.com/002/Home%20Automation%20With%20the%20ESP8266%20-%20Marco%20Schwartz.pdf](http://file.ebook777.com/002/Home%20Automation%20With%20the%20ESP8266%20-%20Marco%20Schwartz.pdf)

- Mua hàng tại IoT Maker Việt Nam [https://iotmaker.vn](https://iotmaker.vn)
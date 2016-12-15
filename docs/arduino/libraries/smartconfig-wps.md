# Smartconfig

# WPS

# Demo một ví dụ ứng dụng smartconfig trong cấu hình thông tin thiết bị.
Ta sẽ viết một chương trình cho phép cấu hình thông tin (username, password) cho module Esp8266 sau khi nhấn nút Flash thông qua phần mềm Esp8266 Smartconfig trên Smartphone Android.

-- Việc cần làm đầu tiên là bạn kiểm tra xem trong thư viện Arduino IDE đã có thư viện WiFi Manager và ESP8266WiFi chưa. Nếu chưa có thì bạn có thể include nó một cách dễ dàng từ Sketch-> include library -> manager library, gõ tên các thư viện này và tiến hành cài đặt. 

-- Cài đặt phần mềm Esp8266: Nếu bạn có điện thoại Android bạn có thể vào CH Play để tải.

-- Viết code chương trình cho phép smartconfig sau khi nhấn nút flash.

```
	
	#include <ESP8266WiFi.h>;
	const int buttonPin = D3;
	const int pinled = D0;
	int buttonState = 0;

	void setup() {
  		pinMode(buttonPin, INPUT);
  		pinmode(pinled, OUTPUT)
  		WiFi.mode(WIFI_AP_STA);
  		delay(500);
	}

	void loop() {
  		buttonState = digitalRead(buttonPin);
  		if (buttonState == LOW) {
  		digitalWrite(pinled,HIGH)
    	WiFi.beginSmartConfig();
  		}
	}

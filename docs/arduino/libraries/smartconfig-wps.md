# Smartconfig

- ### Khái niệm Smartconfig:

-- Khái niệm Smartconfig chắc có lẽ không quá xa lạ đối với dân làm IoT, ở đây mình sẽ trình bày một cách ngắn gọn, dể hiểu để cho các bạn mới tìm hiểu về Smartconfig có thể tiếp cận nó một cách nhanh chóng.

-- Smartconfig là một công nghệ cho phép chúng ta cấu hình thông tin thiết bị WiFi đang kết nối trong một mạng không dây bằng điện thoại hay qua một trang web. Ví dụ như ta muốn cấu hình thông tin cho một module ESP8266 đang kết nối trong mạng WiFi nhà bạn bằng một Smartphone Android. 

# WPS

- ### Khái niệm WPS: (WiFi Protected Setup)

-- WPS là một tính năng có trong các module router wireless. Tính năng này cho phép một thiết bị có thể kết nối đến một mạng không dây thông qua việc nhập mã PIN mà không cần phải nhớ mật khẩu của mạng đó.

# Demo một ví dụ ứng dụng smartconfig trong cấu hình thông tin thiết bị.
Ta sẽ viết một chương trình cho phép cấu hình thông tin (username, password) cho module Esp8266 sau khi nhấn nút Flash thông qua phần mềm Esp8266 Smartconfig trên Smartphone Android.

-- Việc cần làm đầu tiên là bạn kiểm tra xem trong thư viện Arduino IDE đã có thư viện WiFi Manager và ESP8266WiFi chưa. Nếu chưa có thì bạn có thể include nó một cách dễ dàng từ Sketch-> include library -> manager library, gõ tên các thư viện này và tiến hành cài đặt. 

-- Cài đặt phần mềm Esp8266: Nếu bạn có điện thoại Android bạn có thể vào CH Play để tải.

-- Viết code chương trình cho phép smartconfig sau khi nhấn nút flash.

```
	
	#include <ESP8266WiFi.h>;
	const int buttonPin = D3;
	int buttonState = 0;

	void setup() {
  		pinMode(buttonPin, INPUT);
  		WiFi.mode(WIFI_AP_STA);
  		delay(500);
	}

	void loop() {
  		buttonState = digitalRead(buttonPin);
  		if (buttonState == HIGH) {
    	WiFi.beginSmartConfig();
  		}
	}
còn tiếp ...
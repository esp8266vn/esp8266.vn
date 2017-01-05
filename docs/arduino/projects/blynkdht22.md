#Sử dụng ứng dụng Blynk đo nhiệt độ và độ ẩm 

##Chuẩn bị:

- Board NodeMCU v2

- Cảm biến DHT22

- Trở 10k

- Arduino IDE 1.6.8, tải từ [Arduino website](https://www.arduino.cc/en/Main/OldSoftwareReleases#previous).

- Smartphone Androi hoặc iOS

##Hướng dẫn

###1.Tải ứng dụng Blynk và thư viện Blynk:

Tham khảo [Ứng dụng Blynk điều khiển Led](https://esp8266.vn/arduino/projects/blynkled/)

###2.Tải thư viện DHT cho Arduino IDE:

Tải thư viện tại địa chỉ:[https://github.com/adafruit/DHT-sensor-library](https://github.com/adafruit/DHT-sensor-library).

Sau khi tải mở Arduino IDE ->Sketch->Include Library -> Add .zip library và tìm đến file.zip mới tải về ->OK.
###3.Kết nối mạch điện:

Nối mạch điện theo sơ đồ sau:

<img src="../images/blynk/blynkdht22.png" width="500" height="500" border="0" alt="blynk">


###4.Tạo Project trên Blynk

- ###Làm theo hướng dẫn sau

Chọn Create new project,đặt tên project,chọn Board sử dụng và kiểu kết nối->Create.

<img src="../images/blynk/dht1.jpg" width="500" height="400" border="0" alt="blynk">

Tạo Gauge

Bấm vào nút + tại góc trên bên phải và chọn Gauge

<img src="../images/blynk/dht2.jpg" width="500" height="400" border="0" alt="blynk">

Đặt tên và thiết lập thông số cho Gauge

<img src="../images/blynk/dht3.jpg" width="500" height="400" border="0" alt="blynk">

Tương tự ,tạo thêm 1 Gauge và thiết lập thông số

<img src="../images/blynk/dht4.png" width="500" height="400" border="0" alt="blynk">

Hình ảnh 2 Gauge sau khi tạo

<img src="../images/blynk/dht6.jpg" width="500" height="400" border="0" alt="blynk">

Xác định `AuthToken` của project:Tham khảo [Ứng dụng Blynk điều khiển Led](https://esp8266.vn/arduino/projects/blynkled/)

###5 Nạp chương trình 
 Mở Arduino IDE và Upload chương trình

```cpp
#define BLYNK_PRINT Serial    // Comment this out to disable prints and save space
#include <SPI.h>
#include <ESP8266WiFi.h>
#include <BlynkSimpleEsp8266.h>
#include <SimpleTimer.h>
#include <DHT.h>

// You should get Auth Token in the Blynk App.
// Go to the Project Settings (nut icon).
char auth[] = "AuthToken";     

// Your WiFi credentials.
// Set password to "" for open networks.
char ssid[] = "YourWifiname";
char pass[] = "YourWifipassword";

#define DHTPIN 2          // What digital pin we're connected to

// Uncomment whatever type you're using!
//#define DHTTYPE DHT11     // DHT 11
#define DHTTYPE DHT22   // DHT 22, AM2302, AM2321
//#define DHTTYPE DHT21   // DHT 21, AM2301

DHT dht(DHTPIN, DHTTYPE);
SimpleTimer timer;

// This function sends Arduino's up time every second to Virtual Pin (5).
// In the app, Widget's reading frequency should be set to PUSH. This means
// that you define how often to send data to Blynk App.
void sendSensor()
{
  float h = dht.readHumidity();
  float t = dht.readTemperature(); // or dht.readTemperature(true) for Fahrenheit

  if (isnan(h) || isnan(t)) {
    Serial.println("Failed to read from DHT sensor!");
    return;
  }
  // You can send any value at any time.
  // Please don't send more that 10 values per second.
  Blynk.virtualWrite(V5, h);
  Blynk.virtualWrite(V6, t);
}

void setup()
{
  Serial.begin(9600); // See the connection status in Serial Monitor
  Blynk.begin(auth, ssid, pass);

  dht.begin();

  // Setup a function to be called every second
  timer.setInterval(1000L, sendSensor);
}

void loop()
{
  Blynk.run(); // Initiates Blynk
  timer.run(); // Initiates SimpleTimer
}
```
###6.Đo nhiệt độ,độ ẩm bằng ứng dụng Blynk
Mở Project dht22 trong Blynk.Bấm Play.Nhiệt độ và độ ẩm sẽ  hiển thì trên 2 Gauge như hình.

<img src="../images/blynk/dht5.jpg" width="500" height="400" border="0" alt="blynk">
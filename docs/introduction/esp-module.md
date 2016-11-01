# Các loại Module ESP8266

ESP8266 cần ít nhất thêm 7 linh kiện nữa mới có thể hoạt động, trong đó phần khó nhất là Antena. Đòi hỏi phải được sản xuất, kiểm tra với các thiết bị hiện đại. Do đó, trên thị trường xuất hiện nhiều Module và Board mạch phát triển đảm đương hết để người dùng đơn giản nhất trong việc phát triển ứng dụng. Một số Module và Board phát triển phổ biến:

## Bảng so sánh các thông số

| Phiên bản| Số chân   | pitch  | form factor | LEDs |Antenna|Ant.Socket| Shielded |dài mm | 
|------------|--------|--------|-------------|------|---------------|------------|----------|---------------| 
| ESP-01     | 8      | .1“    | 2×4 DIL     | Yes  | Etched-on PCB | No         | No       | 14.3 x 24.8   | 
| ESP-02     | 8      | .1”    | 2×4 notch   | No?  | None          | Yes        | No       | 14.2 x 14.2   | 
| ESP-03     | 14     | 2mm    | 2×7 notch   | No   | Ceramic       | No         | No       | 17.3 x 12.1   | 
| ESP-04     | 14     | 2mm    | 2×4 notch   | No?  | None          | No         | No       | 14.7 x 12.1   | 
| ESP-05     | 5      | .1“    | 1×5 SIL     | No   | None          | Yes        | No       | 14.2 x 14.2   | 
| ESP-06     | 12+GND | misc   | 4×3 dice    | No   | None          | No         | Yes      | 16.3 x 13.1   | 
| ESP-07     | 16     | 2mm    | 2×8 pinhole | Yes  | Ceramic       | Yes        | Yes      | 20.0 x 16.0   | 
| ESP-08     | 14     | 2mm    | 2×7 notch   | No   | None          | No         | Yes      | 17.0 x 16.0   | 
| ESP-08 New | 16     | 2mm    | 2×8 notch   | No   | None          | No         | Yes      | 18.0 x 16.0   | 
| ESP-09     | 12+GND | misc   | 4×3 dice    | No   | None          | No         | No       | 10.0 x 10.0   | 
| ESP-10     | 5      | 2mmm?  | 1×5 notch   | No   | None          | No         | No       | 14.2 x 10.0   | 
| ESP-11     | 8      | 1.27mm | 1×8 pinhole | No?  | Ceramic       | No         | No       | 17.3 x 12.1   | 
| ESP-12     | 16     | 2mm    | 2×8 notch   | Yes  | Etched-on PCB | No         | Yes      | 24.0 x 16.0   | 
| ESP-12-E   | 22     | 2mm    | 2×8 notch   | Yes  | Etched-on PCB | No         | Yes      | 24.0 x 16.0   | 
| ESP-13     | 18     | 1.5mm  | 2×9         | ?    | Etched-on PCB | No         | Yes      | ? x ?         | 
| ESP-14     | 22     | 2mm    | 2×8 + 6     | 1    | Etched-on PCB | No         | Yes      | 24.3 x 16.2   | 
| WROOM-02   | 18     | 1.5mm  | 2×9         | No   | Etched on PCB | No         | Yes      | 20.0 x 18.0   | 
| WT8266-S1  | 18     | 1.5mm  | 3×6         | 1    | Etched on PCB | No         | Yes      | 15.0 x 18.6   | 


## Một số module ESP8266 trên thị trường


### ESP-WROOM-02

![](images/modules/ESP-WROOM-02.jpg)

#### Tính năng
- ESP-WROOM-02 là một module MCU Wifi 32-bit tiết kiệm năng lượng dựa trên chip ESP8266.
- Hổ trợ các chuẩn mạng không dây 802.11 b/g/n
- Tích hợp sẳn giao thức TCP/IP, 10-bit ADC, TR switch, balun, LNA, và các chuẩn giao tiếp HSPI/UART/PWM/I2C/I2S.
- Hổ trợ Wi-Fi Alliance, SRRC, FCC, CE, TELEC, IC & KCC Certified, RoHS, Halogen Free, REACH & CFSI Compliant, HTOL, ESD-HM, MSL, μHAST, HTSL
- Hổ trợ Cloud Server Development
- Custom firmware development qua SDK
- Cấu hình người dùng qua AT Instruction Set, Cloud Server và ứng dụng Afdroid/iOS
- Khoảng cách giữa các chân 2.54mm

#### Sơ đồ chân 
[![](images/modules/ESP-WROOM-02-pin.png)](https://qiita-image-store.s3.amazonaws.com/0/55103/56eec04e-f231-8f4f-d792-840d36d791d7.png)

---

### ESP-01

![](images/modules/ESP-01.jpg)

#### Tính năng
- Mạch nhỏ, gọn (24.75mm x 14.5mm)
- Điện áp làm việc 3.3v
- Tích hợp sẳn anten PCB trace trên module 
- Có hai led báo hiệu : led nguồn, led TXD
- Có các chế độ: AP, STA, AT + STA
- Lệnh AT rất đơn giản, dễ dàng sử dụng
- Khoảng cách giữa các chân 2.54mm

#### Sơ đồ chân
[![](images/modules/ESP-01-pin.png)](https://github.com/acrobotic/Ai_Docs/blob/master/pinouts/esp8266_esp01/esp8266_esp01.pdf)

---

### ESP-02 

![](images/modules/ESP-02.png)

#### Tính năng

- Sử dụng nguồn 3.3v
- Sử dụng anten ngoài - U.FL
- Wireless network mode : station, softAP, softAP + station
- Tần số wifi hoạt động 2.4GHz, và hổ trợ bảo mật WPA/WPA2
- Dễ dàng phát triển các dự án với lệnh AT
- Khoảng cách giữa các chân 2.54mm

#### Sơ đồ chân

![](images/modules/ESP-02-pinout.jpg)

---

### ESP-03

![](images/modules/ESP-03.jpg)

#### Tính năng

- Sử dụng nguồn 3.3v
- Tích hợp sẳn anten ceramic trên module và 1 pin
- Tiêu chuẩn wifi : 802.11b/g/n, 2.4GHz
- Wireless network mode : station, softAP, softAP + station
- Hổ trợ bảo mật WPA/WPA2
- Dễ dáng sử dụng với lệnh AT
- Khoảng cách giữa các chân 2mm

#### Sơ đồ chân

[![](images/modules/ESP-03-pinout.png)](http://tech.scargill.net/wp-content/uploads/2014/12/esp03.jpg)

---

### ESP-04

![](images/modules/ESP-04.jpg)

#### Tính năng

- Sử dụng nguồn 3.3v
- Wireless network mode : station, softAP, softAP + station
- Tiêu chuẩn wifi : 802.11b/g/n, với tần số 2.4GHz,và hổ trợ bảo mật WPA/WPA2
- Dễ dáng sử dụng với lệnh AT
- Khoảng cách giữa các chân 2mm

#### Sơ đồ chân

![](images/modules/ESP-04-pinout.jpg)

---

### ESP-05

![](images/modules/ESP-05.jpg)

#### Tính năng

- Sử dụng nguồn 3.3v
- Sử dụng anten ngoài - U.FL
- Wireless network mode : station, softAP, softAP + station
- Tiêu chuẩn wifi : 802.11b/g/n, với tần số 2.4GHz và hổ trợ bảo mật WPA/WPA2
- Dễ dáng sử dụng với lệnh AT
- Khoảng cách giữa các chân 2.54mm

#### Sơ đồ chân

![](images/modules/ESP-05-pinout.jpg)

---

### ESP-06

![](images/modules/ESP-06.jpg)

#### Tính năng

- Sử dụng nguồn 3.3v
- Wireless network mode : station, softAP, softAP + station
- Tiêu chuẩn wifi : 802.11b/g/n, với tần số 2.4GHz và hổ trợ bảo mật WPA/WPA2
- Hổ trợ TCP/UDP
- Dễ dáng sử dụng với lệnh AT

#### Sơ đồ chân

![](images/modules/ESP-06-pinout.png)

---

### ESP-07

![](images/modules/ESP-07.jpg)

#### Tính năng

- Sử dụng nguồn 3.3v
- Tích hợp sẳn anten ceramic và anten ngoài U.FL
- Tiêu chuẩn wifi : 802.11b/g/n, với tần số 2.4GHz và hổ trợ bảo mật WPA/WPA2
- Hổ trợ TCP/UDP
- Dễ dáng sử dụng với lệnh AT
- Khoảng cách giữa các chân 2mm

#### Sơ đồ chân

[![](images/modules/ESP-07-pinout.png)](images/modules/ESP-07-pinout.png)

---

### ESP-08

![](images/modules/ESP-08.jpg)

#### Tính năng

- Sử dụng nguồn 3.3v
- Tiêu chuẩn wifi : 802.11b/g/n, với tần số 2.4GHz và hổ trợ bảo mật WPA/WPA2
- Hổ trợ TCP/UDP
- Có các chế độ: AP, STA, AT + STA
- Khoảng cách giữa các chân 2mm

#### Sơ đồ chân

![](images/modules/ESP-08-pinout.png)

---

### ESP-09

![](images/modules/ESP-09.jpg)

#### Tính năng

- Sử dụng nguồn 3.3v
- Kích thước mạch nhỏ (10mmx10mm)
- Hổ trợ LWIP
- Tiêu chuẩn wifi : 802.11b/g/n, với tần số 2.4GHz

#### Sơ đồ chân

![](images/modules/ESP-09-pinout.png)

---

### ESP-10

![](images/modules/ESP-10.jpg)

#### Tính năng

- Sử dụng nguồn 3.3v
- Tiêu chuẩn wifi : 802.11b/g/n, với tần số 2.4GHz và hổ trợ bảo mật WPA/WPA2
- Hổ trợ TCP/UDP
- Có các chế độ: AP, STA, AT + STA
- Khoảng cách giữa các chân 2mm

#### Sơ đồ chân

![](images/modules/ESP-10-pinout.png)

---

### ESP-11

![](images/modules/ESP-11.jpg)

#### Tính năng

- Sử dụng nguồn 3.3v
- Tích hợp sẳn anten ceramic trên module
- Tiêu chuẩn wifi : 802.11b/g/n, với tần số 2.4GHz và hổ trợ bảo mật WPA/WPA2
- Dễ dáng sử dụng với lệnh AT
- Khoảng cách giữa các chân 1.27mm

#### Sơ đồ chân

![](images/modules/ESP-11-pinout.jpg)

---

### ESP-12

![](images/modules/ESP-12.jpeg)

#### Tính năng

- Sử dụng nguồn 3.3v
- Tích hợp anten PCB trace trên module
- Tiêu chuẩn wifi : 802.11b/g/n, với tần số 2.4GHz và hổ trợ bảo mật WPA/WPA2
- Khoảng cách giữa các chân 2mm

#### Sơ đồ chân

![](images/modules/ESP-12-pinout.jpeg)

---

### ESP-12E

![](images/modules/ESP-12E.jpg)

#### Tính năng

- Sử dụng nguồn 3.3v
- Tích hợp anten PCB trace trên module
- 4MB flash
- Tiêu chuẩn wifi : 802.11b/g/n, với tần số 2.4GHz và hổ trợ bảo mật WPA/WPA2
- Khoảng cách giữa các chân 2mm

#### Sơ đồ chân

[![](images/modules/ESP-12E-pinout.png)](images/modules/esp8266_esp12e.pdf)

---

### ESP-13

![](images/modules/ESP-13.jpg)

#### Tính năng

- Sử dụng nguồn 3.3v
- Tích hợp anten PCB trace trên module
- Tiêu chuẩn wifi : 802.11b/g/n, với tần số 2.4GHz và hổ trợ bảo mật WPA/WPA2
- Khoảng cách giữa các chân 1.5mm

#### Sơ đồ chân

![](images/modules/ESP-13-pinout.png)

---

### ESP-14

![](images/modules/ESP-14.jpg)

#### Tính năng

- Sử dụng nguồn 3.3v
- Tích hợp anten PCB trace trên module
- Tích hợp thêm STM8S003F3P6, STM8S có thể điều khiển ESP8266 bằng lệnh AT
- Tiêu chuẩn wifi : 802.11b/g/n, với tần số 2.4GHz và hổ trợ bảo mật WPA/WPA2
- Khoảng cách giữa các chân 2mm

#### Sơ đồ chân

![](images/modules/ESP-14-pinout.png)

---

### WT8266-S1

![](images/modules/WT8266-S1.jpg)

#### Tính năng

- Sử dụng nguồn 3.3v
- Nhiệt độ hoạt động  : -20°C - 70°C
- Chip Tensilica L106
    + RAM 36KB
    + Flash 16Mbit
- Hệ thống 
    + Hổ trợ các chuẩn wifi 802.11 b/g/n 
    + Tần số hoạt động hổ trợ từ 80MHz đến 160 MHz, hổ trợ RTOS
    + WIFI 2.4 GHz, hổ trợ WPA/WPA2 
    + Tích hợp 10-bit ADC độ chính xác cao
    + Hổ trợ TCP/IP stack
    + Tích hợp TR Switch/balun/LNA/bộ khuếch đại công suất và matching network
    + Tích hợp anten PCB trace trên module
    + Hổ trợ nâng cấp AT từ xa và cloud OTA
    
#### Sơ đồ chân

![](images/modules/WT8266-S1-pinout.jpg)


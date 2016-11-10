[TOC]

# Đọc Analog

ESP8266 có duy nhất 1 chân ADC, chúng ta có thể dùng để đọc điện áp bên ngoài, hay đọc điện áp VCC.

Để đọc điện áp bên ngoài bằng chân ADC, sử dụng hàm `analogRead(A0)`. Điện áp chấp nhận ở mức `0 — 1.0V`.

Để đọc điện áp cấp (VCC) cho module, sử dụng `ESP.getVcc()` và chân ADC bên ngoài phải để hở. Đồng thời phải cấu hình dòng lệnh sau trong sketch:

```c++
ADC_MODE(ADC_VCC);
```

Dòng lệnh này có thể bất kỳ đâu, ở phía ngoài một hàm - có thể coi như ngang ngửa với dòng `#include` trong sketch.

# Ngõ ra Analog

`analogWrite(pin, value)` cho phép sử dụng Software PWM trên bất kỳ GPIO nào từ `0..16`.

Gọi `analogWrite(pin, 0)` sẽ ngừng cho phép PWM trên chân đó. `value` có thể giới hạn từ 0 đến  `PWMRANGE`, mặc định là 1023. và có thể thay đổi bởi hàm `analogWriteRange(new_range)`.

Tần số PWM mặc định là 1kHz. Gọi `analogWriteFreq(new_frequency)` để thay đổi tần số.

# Ví dụ 

## Đọc giá trị analog ghi ra PWM 

```cpp
int ledPin = 16;      // LED connected to digital pin 9
int val = 0;         // variable to store the read value

void setup()
{
  pinMode(ledPin, OUTPUT);   // sets the pin as output
}

void loop()
{
  val = analogRead(A0);   // read the input pin
  analogWrite(ledPin, val / 4);  // analogRead values go from 0 to 1023, analogWrite values from 0 to 255
}
```

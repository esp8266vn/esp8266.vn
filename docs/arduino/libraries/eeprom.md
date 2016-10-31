# EEPROM

EEPROM của ESP8266 có sự khác biệt nhỏ so với EEPROM chuẩn. Để sử dụng, cần gọi `EEPROM.begin(size)` trước khi bắt đầu đọc hoặc ghi, `size` là số bytes muốn sử dụng. Số bytes đó có thể ở bất cứ đâu trong khoảng 4 và 4096 bytes.

`EEPROM.write()` không viết trực tiếp lên flash, mà cần phải gọi `EEPROM.commit()` trước khi muốn thay đổi, lưu trữ lên flash. `EEPROM.end()` cũng sẽ ghi nhận và sẽ cho phép RAM sao chép nội dung chứa trong EEPROM.

Thư viện EEPROM sử dụng một vùng của flash, ngay sau SPIFFS.

Gồm có ba ví dụ.

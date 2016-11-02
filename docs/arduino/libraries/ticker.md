# Ticker
Thư viện cho phép gọi lại hàm với một chu kỳ nhất định. Gồm có hai ví dụ.

Ở thời điểm hiện tại nó không được phép ngăn chặn các hoạt động của IO (network, serial, file) từ hàm gọi lại Ticker. Thay vào đó, thiết lập một cờ bên trong hàm gọi lại Ticker và kiểm tra cờ đó bên trong hàm lặp.

Đường dẫn sau là thư viện thường dùng `simplificate` Ticker và tránh reset WDT : [TickerScheduler](https://github.com/Toshik/TickerScheduler)

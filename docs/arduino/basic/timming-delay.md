## Thời gian và Delay
`millis()` và `micros()` trả về mili giây và micro giây tính từ thời điểm reset.

`delay(ms)` sẽ dừng sketch cho `ms` micro giây, vẫn cho phép WiFi và TCP/IP hoạt động.
Tương tự với `delayMicroseconds(us)` sẽ dừng chương trình với `us` micro giây.

Hãy ghi nhớ rằng có rất nhiều thứ đang cần hoạt động bên dưới sketch của bạn. Khi WiFi đã kết nối, thư viện WiFi và TCP/IP sẽ cần thời gian để thực hiện bất kỳ sự kiện nào. Việc gọi gọi hàm `loop()`, hay thực thi `delay` sẽ thực hiện điều đó.
Cho nên, nếu bạn có bất kỳ vòng lặp nào chiếm nhiều thời gian (>50ms) mà không gọi hàm `delay`, bạn nên đặt hàm `delay` vào trong hàm đó, để đảm bảo WiFi stack hoạt động trơn tru.

Chúng ta cũng có hàm `yield()` tương đương với `delay(0)`. Hàm `delayMicroseconds` thì lại không thực hiện việc chuyển task, đơn giản nó chỉ dùng để delay và nếu nhiều hơn 20 mili giây thì không được khuyến khích.

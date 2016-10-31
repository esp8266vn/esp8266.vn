
# Servo 

Thư viện trình bày khả năng điều khiển động cơ servo RC. Thư viện hổ trợ tối đa 24 servo trên bất kỳ chân output có sẳn. Theo mặc định 12 servo đầu tiên sẽ sử dụng Timer0 và hiện tại sẽ không dùng cho bất kỳ hộ trợ nào khác. Đến 12 Servo tiếp theo sử dụng Timer1 và tính năng sử dụng nó sẽ được thực hiện. Trong khi nhiều động cơ Servo RC sẽ chấp nhận mức điện áp ở các chân IO là 3.3V từ ESP8266. Phần lớn sẽ không thể chạy với điện áp 3.3V, sẽ cần một nguồn điện phù hợp với các thông số của Servo. Cần kết nối mass chung giữa ESP8266 và nguồn của động cơ Servo.

# ESP8266 Micropython

![Micropython](./images/upy.jpg)

`micropython` là trình thông dịch Python3 được thiết kế cho các dòng chip có bộ nhớ ít ỏi và có khả năng hoạt động ổn định.

Lợi thế của `micropython` là sử dụng ngôn ngữ bậc cao, dễ dàng sử dụng cho người mới bắt đầu. Có thể thực thi các lệnh trực tiếp ngay trên Terminal thông qua REPL hoặc qua Web REPL. Một khi đã flash firmware hỗ trợ `micropython` thì việc viết firmware bằng python sẽ do trình thông dịch bên dưới chip đảm nhiệm. Bạn có thể thay đổi chương trình mà không phải nạp lại firmware nữa.

Nhưng một khó khăn là khi muốn bổ sung những tính năng mới, module mới không sẵn có, thì cần phải am hiểu về `micropython` để có thể viết được module bổ sung.

Website: [http://www.micropython.org/](http://www.micropython.org/)
Github: [https://github.com/micropython/micropython](https://github.com/micropython/micropython)

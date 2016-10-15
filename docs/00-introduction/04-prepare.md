
## Phần cứng và kiến thức cần chuẩn bị

Giống như tất cả các Vi điều khiển khác, việc lập trình cho ESP8266 cần những kiến thức về lập trình **C** cũng như phần cứng để thực hành. Trong sách này chúng ta sẽ sử dụng mạch phát triển NodeMCU để thử nghiệm tất cả các ví dụ mẫu.


## Mạch phát triển NodeMCU

Mạch này có bán rộng rãi trên thị trường, tiện lợi khi phát triển, và được cung cấp đầy đủ mạch nguyên lý, mở về phần cứng. Chip USB-TTL hỗ trợ DTR và RTS cho phép phần mềm nạp `esptool.py` có thể điều khiển ESP8266 vào chế độ nạp luôn mà không cần thao tác phần cứng nào.

### Chú ý

Tới thời điểm hiện nay, công cụ nạp cho ESP8266 có thể đạt tốc độ 921600 baud. Tuy nhiên, các mạch NodeMCU hiện trên thị trường sử dụng nhiều loại chip USB-TTL khác nhau, nên cần kiểm tra tốc độ hỗ trợ trước khi mua. Nếu tốc độ thấp, thì việc nạp ứng dụng cho ESP8266 khá lâu cho những ứng dụng lớn.

https://github.com/nodemcu/nodemcu-devkit-v1.0


Sơ đồ chân & sơ đồ khối ESP8266EX
![Sơ đồ chân ESP8266EX](images/esp8266_devkit.svg)



### Mạch nguyên lý
// Sơ đồ nguyên lý -> SVG
//image::nodemcu_devkit_1.0.svg[NodeMCU schematic]

## Những lựa chọn khác

// Các mạch phát triển khác..

## Cài đặt trình soạn thảo & cài đặt ban đầu

### Sublime Text

### Eclipse

### Notepad++


## Ngôn ngữ lập trình C 

Tất nhiên việc phát triển ứng dụng cho những Vi điều khiển ít tài nguyên, dung lượng bộ nhớ còn vài chục KiB thì hiếm có sự lựa chọn nào khác ngoài ngôn ngữ lập trình **C/C++**. Những ngôn ngữ khác như: **Lua**, **Python** cũng được phát triển cho ESP8266, nhưng để hoàn thành công việc càng dễ dàng, thì đòi hỏi tài nguyên càng nhiều. Và sự ổn định của ứng dụng sẽ phụ thuộc rất nhiều vào việc dư giả tài nguyên. Chip ESP8266 không được thiết kế để đủ tài nguyên chạy ổn định cho các trình thông dịch (Interpreter) này.


## Makefile 

Để biên dịch được chúng ta cần hoàn thành việc cài đặt trình biên dịch bên trên, và tìm hiểu một chút về kịch bản **Makefile**. Các kiến thức này thông thường các bạn đều phải biết khi học về ngôn ngữ **C**. Nội dung phần này chỉ nói ngắn gọn, xúc tích những gì cần thiết nhất.

`Makefile` là công cụ kịch bản hóa quá trình biên dịch thường được sử dụng trong hệ điều hành Unix, Linux, tất nhiên có cả trên Windows nhưng không phổ biến. Nó đơn giản quá hóa trình thực hiện biên dịch bằng cách sử dụng các module có sẵn trong hệ điều hành.

Việc sử dụng Makefile trong các dự án **C** ít thường xuyên và thường được thiết kế sẵn bởi người tạo nên dự án đó. Do vậy, bạn chỉ cần hiểu sơ về `Makefile` để có thể dễ dàng sửa chữa theo ý mình, nếu không muốn chuyên sâu. Một số từ khóa google để dễ dàng tìm hiểu về `Makefile`: "Makefile basics", "Makefile tutorial".

Để biên dịch, bạn gõ `make` từ cửa sổ terminal, chương trình `make` sẽ tìm và đọc file mặc định có tên `Makefile` ở thư mục hiện hành và thực thi nó.


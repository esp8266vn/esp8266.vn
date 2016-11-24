[TOC]
# Node MCU điều khiển bởi Slack

Dự án này sẽ thực hiện việc lập trình sử dụng NodeMCU đăng các thông báo lên facebook hỗ trợ những tính năng sau:

- Kết nối tới Server IFTTT
- Có cấu hình để gửi tin thông báo lên facebook
- Có thể cấu hình nội dung tin gửi

Video demo mô phỏng ứng dụng: 


## Cần chuẩn bị
- [NodeMCU](http://www.nodemcu.com) - bạn có thể mua ở Việt Nam tại: [!!btn btn-lg btn-outline|iotmaker.vn!!](https://iotmaker.vn)
- Cài đặt Arduino IDE và gói hỗ trợ ESP8266 [Hướng dẫn cài đặt](../basic/install.md)

## Mục đích của bài hướng dẫn này:

Sau khi lập trình lại cho thiết bị, thì thiết bị cần có những tính năng sau:

- Khi nhấn nút nhấn trên kit - đèn LED trạng thái sẽ chớp báo đang trong quá trình gửi dữ liệu lên facebook.
- Đèn LED sẽ tắt khi quá trình gửi dữ liệu hoàn thành.

Căn cứ trên yêu cầu và mạch nguyên lý bên dưới, chung ta cần những thông tin sau: 

| Chân   | Tính năng               |
|--------|-------------------------|
| GPIO16 | Điều khiển LED          |
| GPIO0  | Nút nhấn                |



![node mcu](images/nodemcu.jpg)

![node mcu pinout](images/nodemcu_pinout.png)


## Đăng ký tài khoản IFTTT

### Đăng ký tài khoản Slack

- Vào trang [https://ifttt.com/](hhttps://ifttt.com/), điền Email vào tạo 1 tài khoản mới
![IFTTT sign up](images/IFTTT_reg.png)

### Khởi tạo New Applet

- Sau khi hoàn thành các bước đăng ký, chọn My Applets để tạo liên kết ứng dụng

![IFTTT sign up](images/IFTTT_newapplet.png)

- Applet hoạt động theo cấu trúc `if this then that` nghĩa là nếu có cái này thì thực hiện cái kia, ở đây là nếu NodeMCU/ESP8266 gửi request thì post status lên facebook.
![IFTTT this](images/IFTTT_this.png)

- Click chọn Maker để nhận được tín hiệu từ NodeMCU/ESP8266
![IFTTT this](images/IFTTT_maker.png)

- Maker chỉ có 1 tùy chọn là Receive a web request nên ta chọn vào đó và điền tên tại Event Name, ở đây ta đặt tên là button_press, nghĩa là nếu ESP gửi sự kiện có tên là button_press lên thì sẽ post 1 bài lên facebook, sau đó chọn Create trigger
![IFTTT this](images/IFTTT_make.png)

- Tiếp tục thêm facebook tại that, ở đây ta chọn facebook để đăng bài lên facebook cá nhân hoặc facebook page nếu bạn muốn post bài lên page
![IFTTT that](images/IFTTT_that.png)

- Chọn Create a status mesage
![IFTTT facebook message](images/IFTTT_facebook_mess.png)

- Chỉnh sửa nội dung tin bạn muốn đăng lên facebook tại Status mesage sau đó Create action
![IFTTT Message Content](images/IFTTT_message_content.png)

- Hoàn thành quá trình khởi tạo trên IFTTT
![IFTTT Finish](images/IFTTT_finish.png)

- Bạn sẽ cần `API Token` sau khi tạo xong My Applets bằng cách vào biểu tượng Maker hoặc link [https://ifttt.com/maker](https://ifttt.com/maker), mục Settings
![IFTTT API Setting](images/IFTTT_maker_setting.png)

- Key để access vào IFTTT nằm tại URL sau /use/xxxxx
![IFTTT API Setting](images/IFTTT_key.png)



## Chương trình 
```
git clone https://github.com/esp8266vn/facebook-post.git
```

!!! warning "Quan trọng"
    Phải thay đúng tên wifi, mật khẩu wifi và key IFTTT của bạn tại
    
    ```
    /****** Ket noi wifi **********/

    const char ssid[] = “ten_wifi”;

    const char password[] = “password”;

    // IFTTT setup

    const char *host = “maker.ifttt.com”;

    const char *Maker_Event = “button_press”; //Ten ban dat trong IFTT

    const char *Your_Key = “xxxxxxxxxxxxxx”; //API key cua app
    ```


## Kết quả
- Sau khi ấn nút chờ LED sáng lên và tắt thì ta có thể F5 lại facebook để thấy được post do NodeMCU đăng lên trên tường.

![IFTTT API Setting](images/IFTTT_face_result.png)

Lưu ý: Bạn có thể theo dõi log quá trình hoạt động của NodeMCU thông qua terminal của Arduino

## Link hữu ích  
- Mua hàng tại [IoT Maker Việt Nam](https://iotmaker.vn/nodemcu.html)
- [NodeMCU](http://www.nodemcu.com)

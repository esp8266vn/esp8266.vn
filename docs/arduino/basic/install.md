[TOC]

# Arduino cơ bản

 Có thể tìm thấy hướng dẫn cài đặt Tiếng Anh và được cập nhật tại [https://github.com/esp8266/Arduino](https://github.com/esp8266/Arduino)

## Cài đặt với Boards Manager

Phương án khuyên dùng cho người dùng không chuyên 

### Chuẩn bị

- Arduino 1.6.8, tải từ [Arduino website](https://www.arduino.cc/en/Main/OldSoftwareReleases#previous).
- Kết nối Internet

### Hướng dẫn
- Mở chương trình Arduino và cửa sổ Preferences.
- Enter ```http://arduino.esp8266.com/stable/package_esp8266com_index.json``` vào *Additional Board Manager URLs*. Bạn có thể thêm nhiều URL, cách nhau bằng dấu phẩy.
- Mở Boards Manager từ Tools > Board menu và tìm *esp8266* platform.
- Chọn phiên bản bạn cần từ cửa sổ Drop-down.
- Click nút *install*.
- Đừng quên chọn loại ESP8266 board từ Tools > Board menu sau khi cài đặt.

Bạn có 1 lựa chọn khác cài đặt bản *staging* boards manager từ link:
`http://arduino.esp8266.com/staging/package_esp8266com_index.json`. Phiên bản này có những tính năng mới hơn, tuy nhiên chưa thật sự được kiểm tra kỹ.

## Sử dụng git version

Phương án cài đặt này khuyên dùng cho những người có thể đóng góp vào dự án Arduino cho ESP8266 và developers.


### Chuẩn bị

- Arduino 1.6.8 (hay mới hơn, nếu bạn biết bạn đang làm gì)
- git
- python 2.7
- terminal, console, or command prompt (phụ thuộc hệ điều hành của bạn)
- Kết nối Internet

### Hướng dẫn

- Mở `console` và cd đến thư mục Arduino. Nó có thể là thư mục *sketchbook* (thường là `<Documents>/Arduino`), hay thư mục của Ứng dụng Arduino, tùy bạn chọn.
- Clone repository này đến thư mục `hardware/esp8266com/esp8266`. Hoặc bạn có thể clone vào nơi nào đó và tạo symlink bằng `ln -s`, nếu Hệ điều hành hỗ trợ.

```bash
cd hardware
mkdir esp8266com
cd esp8266com
git clone https://github.com/esp8266/Arduino.git esp8266
```

Cấu trúc dự án sau khi bạn thực hiện xong:

```bash
Arduino
    |- hardware
    |- esp8266com
        |- esp8266
            |- bootloaders
            |- cores
            |- doc
            |- libraries
            |- package
            |- tests
            |- tools
            |- variants
            |- platform.txt
            |- programmers.txt
            |- README.md
            |- boards.txt
            `- LICENSE
```

- Tải binary tools

```bash
cd esp8266/tools
python get.py
```

- Khởi động lại Arduino

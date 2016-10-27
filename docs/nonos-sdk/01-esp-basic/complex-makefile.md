# Sử dụng sự án có Makefile phức tạp

Để biên dịch sự án có nhiều file hơn nữa thì việc sử dụng Makefile như các ví dụ trên khá phiền phức, phải thay đổi nhiều chỗ. Mục đích của Makefile đơn giản là giúp chúng ta hiểu được nguyên lý hoạt động của compiler và cách thức biên dịch ứng dụng với Nonos-sdk. 
Để tiện lợi, kể từ mục này trở đi, chúng ta sử dụng Makefile trong dự án mẫu và phân bổ dự án theo cấu trúc như bên dưới. Dự án đã viết sẵn Makefile tự động tìm và biên dịch các file `.c` 

## Dự án mẫu: 

- [https://github.com/esp8266vn/esp8266-nonos-sdk-boilerplate](https://github.com/esp8266vn/esp8266-nonos-sdk-boilerplate)

## Cấu trúc dự án: 

```
esp8266-nonos-sdk-boilerplate
    |--- Makefile
    |--- modules
    |   |--- moduleA
    |   |   |-- Makefile
    |   |   |-- include
    |   |   |   `-- modulea.h 
    |   |   `-- modulea.c
    |--- include
    |   `-- user_config.h
    |--- user
        |-- Makefile
        |-- user_main.c 
        `-- rfinit.c

```

Trong đó: 

- Thư mục `modules` chứa các module liên quan, mỗi module có định nghĩa prototype đặt trong thư mục `include`

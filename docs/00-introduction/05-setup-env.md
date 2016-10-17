
# Cài đặt công cụ cần thiết

* Trình soạn thảo trên máy tính, để viết mã nguồn **C**
* Trình biên dịch, nhằm mục địch biên dịch mã nguồn **C** sang mã máy
* Trình nạp, nạp mã máy đã biên dịch xuống Flash của ESP8266
* SDK

## Cài đặt Git

## Cài đặt trình biên dịch & các thư viện cơ bản

### MacOS/OSX

Bạn có ít nhất 2 cách để có trình biên dịch, đơn giản nhất là tải về từ 1 trong các link sau:

- https://esp8266.vn/esp8266-compiler-osx.zip
- http://esp8266vn.github.io/esp8266.vn/esp8266-compiler-osx.zip

và giải nén vào thư mục: `/tools/esp8266/compiler/`


**Cách 2** phức tạp hơn, nhưng sẽ phù hợp với tất cả phiên bản hệ điều hành của bạn. Biên dịch Trình biên dịch từ mã nguồn:

```bash

sudo port install git gsed gawk binutils gperf grep gettext py-serial wget libtool autoconf automake 

hdiutil create -size 5g -fs "Case-sensitive HFS+" -volname ESPTools ESPTools.sparsebundle 
hdiutil attach ESPTools.sparsebundle <3>
sudo ln -s /Volumes/ESPTools/ /tools <3>
mkdir /tools/esp8266 <4>
mkdir /tools/esp8266/sdk <4>
mkdir /tools/esp8266/compiler <4>
cd /tools/esp8266/compiler

git clone -b lx106 git://github.com/jcmvbkbc/crosstool-NG.git <5>
cd crosstool-NG
sed -i.bak '1s/^/gettext=\'$'\n/' crosstool-NG/kconfig/Makefile
./bootstrap && ./configure --prefix=`pwd` && make && make install
./ct-ng xtensa-lx106-elf
./ct-ng build
```

- Các thư viện cần thiết để biên dịch crosstool-NG, sử dụng MacPorts để cài đặt. Nếu chưa cài đặt MacPorts có thẻ tải tại đây: https://www.macports.org/
- Biên dịch `crosstool-NG` cần định dạng ổ cứng hỗ trợ phân biệt đường dẫn chữ Hoa và chữ thường, nên cần tạo một ổ đĩa ảo như vậy.
- Mount ổ đĩa `ESPTools ESPTools.sparsebundle` tới thư mục `/tools/`
- Tạo các thư mục cho để chứa SDK, trình biên dịch và công cụ nạp
- Clone dự án crosstool-NG, nhánh `lx106` về, tiến hành các thao tác biên dịch

#### Lưu ý

Lưu ý rằng, quá trình biên dịch cần khoảng 1 giờ (tùy cấu hình máy) và 1.5GiB dung lượng ổ cứng trống

Tiếp theo, cần phải thêm đường dẫn của compiler vào biến môi trường `PATH` của hệ điều hành


```bash
echo "export PATH=$PATH:/tools/esp8266/compiler/crosstool-NG/builds/xtensa-lx106-elf/bin" >>  ~/.bash_profile <1>
source ~/.bash_profile 
```

- Thêm dòng `export` vào cuối file `~/.bash_profile` bằng `echo`
- `source` để tải lại biến môi trường

Kiểm tra việc cài đặt, Có dòng này hiển thị ở cuối cùng thì việc cài đặt dã thành công

```bash
xtensa-lx106-elf-gcc -v
gcc version 4.8.2 (crosstool-NG 1.20.0) 
```


### Windows

Cài đặt Git
- https://desktop.github.com/

Tải về tại một trong các địa chỉ sau:

- http://*.ru
- https://esp8266.vn/esp8266-compiler-windows.zip
- http://esp8266vn.github.io/esp8266.vn/esp8266-compiler-windows.zip

### Linux
Cài đặt Git
```
sudo apt-get update
sudo apt-get install git
```

## Tải công cụ nạp esptool.py, SDK và cài đặt ENV

## Công cụ COM Terminal

## Tải tài liệu từ Espressif

//https://espressif.com/sites/default/files/documentation/esp8266-technical_reference_en.pdf

## Cấu hình chân nạp
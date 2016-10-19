# ESP8266 cơ bản

Trong chương này chúng ta sẽ lập trình cơ bản về ESP8266, biên dịch 1 dự án mẫu, làm sao để kết nối đến mạng Wi-Fi hiện tại. Sử dụng các module phần cứng của ESP8266 như GPIO (LED, nút nhấn), cổng dữ liệu UART (TX & RX), I2C, SPI, ADC ...

# Cài đặt công cụ cần thiết

* Trình soạn thảo trên máy tính, để viết mã nguồn **C**
* Trình biên dịch, nhằm mục địch biên dịch mã nguồn **C** sang mã máy
* Trình nạp, nạp mã máy đã biên dịch xuống Flash của ESP8266
* SDK


## Cài đặt trình biên dịch & các thư viện cơ bản

### MacOS/OSX

Bạn có ít nhất 2 cách để có trình biên dịch, đơn giản nhất là tải về từ 1 trong các link sau:

- [xtensa-lx106-elf.zip](https://www.dropbox.com/s/wavfbh7v7k3lh15/xtensa-lx106-elf.zip?dl=0)


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

- [http://programs74.ru/udkew-en.html](http://programs74.ru/udkew-en.html)
- [Link Dropbox](https://www.dropbox.com/s/x0v25603pnf8sny/Espressif-ESP8266-DevKit-v2.1.0-x86.exe?dl=0)


### Linux
Cài đặt Git
```
sudo apt-get update
sudo apt-get install git
```

Cài đặt complier
```
git clone https://github.com/pfalcon/esp-open-sdk.git

sudo apt-get install make unrar autoconf automake libtool gcc g++ gperf \
    flex bison texinfo gawk ncurses-dev libexpat-dev python sed

cd esp-open-sdk
unset LD_LIBRARY_PATH
make
```

Trường hợp gặp lỗi help2man update bằng lệnh sau
```
sudo apt-get update
sudo apt-get install help2man
```

Trường hợp lỗi configure: error: could not find GNU libtool >= 1.5.26 fix bằng lệnh
```
apt-get install libtool-bin
```

Sau khi chạy `make` xong (mất khoảng hơn 30ph) thì sẽ có thông báo như sau
```
Xtensa toolchain is built, to use it:
 
export PATH=/home/hocarm/esp-open-sdk/xtensa-lx106-elf/bin:$PATH
```

Chạy lệnh export để sử dụng eXtnsa

Kiểm tra việc cài đặt bằng lệnh

`xtensa-lx106-elf-gcc -v`

Có dòng này hiển thị ở cuối cùng thì việc cài đặt dã thành công

```
Thread model: single
gcc version 4.8.5 (crosstool-NG crosstool-ng-1.22.0-55-gecfc19a) 
```

Có thể xem thêm [log](http://pastebin.com/3SEJTNqT) cài đặt tham khảo
Nếu tải gói trên Ubuntu thì có đầy đủ SDK, esptool. Thư mục sẽ hơi khác một chút so với MAC OS (Ví dụ như esp-open-sdk)

## Tải SDK

Tải ESP8266-NONOS-SDK 2.0 từ một trong các nguồn sau: 

- [http://bbs.espressif.com/viewtopic.php?f=46&t=2451](http://bbs.espressif.com/viewtopic.php?f=46&t=2451)
- [Dropbox ESP8266-NONOS-SDK](https://www.dropbox.com/s/vgq9pvy3333am24/ESP8266_NONOS_SDK_V2.0.0_16_08_10.zip?dl=0)

Giải nén ra (ví dụ tại thư mục: `/tools/esp8266/sdk/ESP8266_NONOS_SDK`)

## Tải **esptool.py**

`git clone https://github.com/themadinventor/esptool.git` tại thư mục `/tools/esp8266/`

Hoặc Download từ [Dropbox](https://www.dropbox.com/s/u3sihwbmjmx7xl3/esptool.zip?dl=0) và giải nén vào thư mục `/tools/esp8266/`



## Công cụ COM Terminal

- [Minicom](https://help.ubuntu.com/community/Minicom)
- [CoolTerm](http://freeware.the-meiers.org/) (Window, MAC, không support Ubuntu)
- Gtkterm
    + Cài đặt
    ```
    apt-get install gtkterm 
    ```
    + Tìm kiếm COM kết nối dùng lệnh `lsusb` trong terminal
    + Chạy gtkterm
    ```
    sudo gtkterm
    ```
    + Cấu hình Port và baud trong Configuration>Port

## Tải tài liệu từ Espressif

[http://espressif.com](http://espressif.com/en/support/download/documents?keys=&field_type_tid%5B%5D=14)

## Cấu hình chân nạp

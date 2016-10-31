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

#### Cài đặt Git, Python

- [Git](https://desktop.github.com/)
- [Python](https://www.python.org/ftp/python/2.7.12/python-2.7.12.msi)
    + Mặc định python được cài đặt tại `C:\Python27`, thêm đường dẫn này vào biến môi trường `PATH` (xem hướng dẫn các bước bên dưới)

#### Cài đặt MINGW make

- Tải và cài đặt [Mingw setup](http://sourceforge.net/projects/mingw/files/Installer/) 
- Tải và chạy tập tin `install-mingw-package.bat` (Run as Administractor) từ [MinGW packages install script](http://programs74.ru/get.php?file=EspressifESP8266DevKitAddon)

Mặc định MINGW được cài đặt tại `C:\MinGW`, Thêm đường dẫn `C:\MinGW\msys\1.0\bin\` vào biến môi trường `PATH` (xem hướng dẫn các bước bên dưới). 

Vào 1 thư mục trống bất kỳ (không có chứa `Makefile`), chạy `make` mà hiện dòng này là cài đặt thành công:
```bat
cd C:\
make
make: *** No targets specified and no makefile found.  Stop.
```

#### Tải SDK về tại một trong các địa chỉ sau & cài đặt:

- [http://programs74.ru/udkew-en.html](http://programs74.ru/udkew-en.html)
- [Link Dropbox](https://www.dropbox.com/s/x0v25603pnf8sny/Espressif-ESP8266-DevKit-v2.1.0-x86.exe?dl=0)

Đây là bộ KIT đã bao gồm tất cả các công cụ, SDK và mã nguồn chương trình cần thiết để phát triển ứng dụng ESP8266. Tuy không phải là chính thức của hãng (unofficial) nhưng thuộc dạng tất-cả-trong-một, rất tiện lợi & dễ sử dụng.
Vị trí mặc định của bộ KIT sau khi cài đặt là `C:\Espressif`, bao gồm:

- `C:\Espressif\xtensa-lx106-elf\bin`: trình biên dịch xtensa-lx106-elf
- `C:\Espressif\utils\ESP8266`: các chương trình tiện ích, ví dụ `esptool.exe` để nạp ESP8266
- `C:\Espressif\docs\ESP8266`: tài liệu liên quan.
- `C:\Espressif\ESP8266_SDK`: tương ứng với bản **ESP8266_NONOS_SDK v2.0.0**
- `C:\Espressif\ESP8266_RTOS_SDK`: tương ứng với bản **ESP8266 RTOS SDK v1.4.0**
- `C:\Espressif\examples\ESP8266`: mã nguồn ví dụ các dự án.

Cài đặt đường dẫn `C:\Espressif\xtensa-lx106-elf\bin` và `C:\Espressif\utils\ESP8266` vào biến môi trường `PATH` của windows, có 2 cách:

- Cài đặt cứng trong `My Computer` -> (Chuột phải) -> `Properties` -> `Advanced system settings` -> `Environment Variables...` -> `System variables`, chọn giá trị `PATH` -> chọn `Edit...` -> di chuyển đến cuối chuỗi, thêm `;C:\Espressif\xtensa-lx106-elf\bin;C:\Espressif\utils\ESP8266;`
- Cài đặt khi chạy: trong cửa sổ console, nhập `set PATH=%PATH%;C:\Espressif\xtensa-lx106-elf\bin;C:\Espressif\utils\ESP8266;`

Kiểm tra việc cài đặt `xtensa-lx106-elf` và `esptool`, có dòng này hiển thị ở cuối cùng thì việc cài đặt đã thành công:
```bat
xtensa-lx106-elf-gcc --version
xtensa-lx106-elf-gcc (GCC) 5.2.0
```

```bat
esptool.py
usage: esptool [-h] [--port PORT] [--baud BAUD]
```

### Linux
Cài đặt Git
```
sudo apt-get update
sudo apt-get install make unrar-free autoconf automake libtool gcc g++ gperf \
    flex bison texinfo gawk ncurses-dev libexpat-dev python-dev python python-serial \
    sed git unzip bash help2man wget bzip2
sudo apt-get install libtool-bin
```

Cài đặt complier
```
mkdir /tools /tools/esp8266 /tools/esp8266/sdk /tools/esp8266/compiler
cd /tools/esp8266/compiler
git clone -b lx106 git://github.com/jcmvbkbc/crosstool-NG.git 
cd crosstool-NG
./bootstrap && ./configure --prefix=`pwd` && make && make install
./ct-ng xtensa-lx106-elf
unset LD_LIBRARY_PATH
./ct-ng build
PATH=$PWD/builds/xtensa-lx106-elf/bin:$PATH
```


Kiểm tra việc cài đặt bằng lệnh

`xtensa-lx106-elf-gcc -v`

Có dòng này hiển thị ở cuối cùng thì việc cài đặt dã thành công

```
Thread model: single
gcc version 4.8.5 (crosstool-NG crosstool-ng-1.22.0-55-gecfc19a) 
```

## Tải ESP8266_NONOS_SDK

Tải ESP8266-NONOS-SDK 2.0 từ một trong các nguồn sau: 

- [http://bbs.espressif.com/viewtopic.php?f=46&t=2451](http://bbs.espressif.com/viewtopic.php?f=46&t=2451)
- [Dropbox ESP8266-NONOS-SDK](https://www.dropbox.com/s/vgq9pvy3333am24/ESP8266_NONOS_SDK_V2.0.0_16_08_10.zip?dl=0)

Giải nén ra (ví dụ tại thư mục: `/tools/esp8266/sdk/ESP8266_NONOS_SDK`)

## Tải **esptool.py**

```
cd /tools/esp8266/
git clone https://github.com/themadinventor/esptool.git

```


Hoặc Download từ [Dropbox](https://www.dropbox.com/s/u3sihwbmjmx7xl3/esptool.zip?dl=0) và giải nén vào thư mục `/tools/esp8266/`

## Tải libc,libhal, file include (với ubuntu thêm lệnh sudo trước wget)
```
cd tools/esp8266/complier/crosstool-NG/builds/xtensa-lx106-elf/xtensa-lx106-elf/sysroot/usr
wget -O lib/libc.a https://github.com/esp8266/esp8266-wiki/raw/master/libs/libc.a
wget -O lib/libhal.a https://github.com/esp8266/esp8266-wiki/raw/master/libs/libhal.a
wget -O include.tgz https://github.com/esp8266/esp8266-wiki/raw/master/include.tgz
tar -xvzf include.tgz
```


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

## Tài liệu từ Espressif

[http://espressif.com](http://espressif.com/en/support/download/documents?keys=&field_type_tid%5B%5D=14)



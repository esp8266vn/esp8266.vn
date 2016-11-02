[TOC]
# Kết nối ESP8266 với router Wifi

Tổ chức file căn cứ theo bài [Biên dịch dự án đầu tiên](./compile-first-time.md), toàn bộ cấu trúc file, **Makefile, user_config.h, rf_init.c** giữ nguyên, chỉ thay đổi nội dung file `main.c`.

## Lấy dự án về từ Github:

```bash
git clone https://github.com/esp8266vn/esp-iot-basic.git
```

## Sơ đồ file

```
esp-iot-led-blink
    |-- Makefile
    |-- main.c
    |-- rf_init.c
    `-- user_config.h
```

## Mã nguồn

```c

#include "osapi.h"
#include "user_interface.h"
#define PASSWORD    "yourpassword"
#define SSID        "yourssid"
LOCAL os_timer_t test_timer;

/******************************************************************************
    * FunctionName : user_esp_platform_check_ip
    * Description    : check whether get ip addr or not
    * Parameters         : none
    * Returns        : none
*******************************************************************************/
void ICACHE_FLASH_ATTR
user_esp_platform_check_ip(void)
{
    struct ip_info ipconfig;

    //disarm timer first
    os_timer_disarm(&test_timer);

    //get ip info of ESP8266 station
    wifi_get_ip_info(STATION_IF, &ipconfig);

    if (wifi_station_get_connect_status() == STATION_GOT_IP && ipconfig.ip.addr != 0) {

            os_printf("got ip !!! \r\n");

    } else {

        if ((wifi_station_get_connect_status() == STATION_WRONG_PASSWORD ||
                wifi_station_get_connect_status() == STATION_NO_AP_FOUND ||
                wifi_station_get_connect_status() == STATION_CONNECT_FAIL)) {

            os_printf("connect fail !!! \r\n");

        } else {

            //re-arm timer to check ip
            os_timer_setfn(&test_timer, (os_timer_func_t *)user_esp_platform_check_ip, NULL);
            os_timer_arm(&test_timer, 100, 0);
        }
    }
}


/******************************************************************************
    * FunctionName : user_set_station_config
    * Description    : set the router info which ESP8266 station will connect to
    * Parameters         : none
    * Returns        : none
*******************************************************************************/
void ICACHE_FLASH_ATTR
user_set_station_config(void)
{
    // Wifi configuration
    char ssid[32] = SSID;
    char password[64] = PASSWORD;
    struct station_config stationConf;

    os_memset(stationConf.ssid, 0, 32);
    os_memset(stationConf.password, 0, 64);
    //need not mac address
    stationConf.bssid_set = 0;

    //Set ap settings
    os_memcpy(&stationConf.ssid, ssid, 32);
    os_memcpy(&stationConf.password, password, 64);
    wifi_station_set_config(&stationConf);

    //set a timer to check whether got ip from router succeed or not.
    os_timer_disarm(&test_timer);
    os_timer_setfn(&test_timer, (os_timer_func_t *)user_esp_platform_check_ip, NULL);
    os_timer_arm(&test_timer, 100, 0);
}

/******************************************************************************
    * FunctionName : user_init
    * Description    : entry of user application, init user function here
    * Parameters         : none
    * Returns        : none
*******************************************************************************/
void user_init(void)
{
    uart_div_modify(0, UART_CLK_FREQ / 115200);
    os_printf("SDK version:%s\n", system_get_sdk_version());
    //Set softAP + station mode
    wifi_set_opmode(STATION_MODE);
    // ESP8266 connect to router.
    user_set_station_config();
}

```

## Kết quả

Sau khi nạp chương trình thành công

Sử dụng Terminal quan sát sẽ thấy

```
connected with yourssid, channel 1
dhcp client start...
ip:192.168.1.46,mask:255.255.255.0,gw:192.168.1.1
got ip !!!
```

## Gợi ý

Để truy cập được vào router bạn cần phải sửa các define PASSWORD và SSID cho đúng với router mà bạn muốn truy cập

```c
#define PASSWORD    "yourpassword"
#define SSID        "yourssid"
```

Sau khi kết nối giá trị của SSID và PASSWORD sẽ được lưu vào flash và điều này có nghĩa là nếu lần sau  bạn không thay đổi giá trị thì những giá trị trong flash sẽ được sử dụng để truy cập vào router. Điều này được thực hiện bằng đoạn code sau.

```c
    // Wifi configuration
    char ssid[32] = SSID;
    char password[64] = PASSWORD;
    struct station_config stationConf;

    os_memset(stationConf.ssid, 0, 32);
    os_memset(stationConf.password, 0, 64);
    //need not mac address
    stationConf.bssid_set = 0;

    //Set ap settings
    os_memcpy(&stationConf.ssid, ssid, 32);
    os_memcpy(&stationConf.password, password, 64);
    wifi_station_set_config(&stationConf);
```

Nếu để ý thì có thể thấy trong code có 1 đoạn kiểm tra xem module đã kết nối với router thành công hay chưa

```c
    os_timer_disarm(&test_timer);
    os_timer_setfn(&test_timer, (os_timer_func_t *)user_esp_platform_check_ip, NULL);
    os_timer_arm(&test_timer, 100, 0);
```
Đoạn này có nghĩa là set cho software timer đợi sau 100 ms thì sẽ gọi hàm call back user_esp_platform_check_ip
để check xem esp8266 đã lấy được ip hay chưa.
Chú ý là hàm

```c
    os_timer_arm(&test_timer, 100, 0);
```

Có tham số thứ 3 là 0 có nghĩa là timer chỉ thực hiện đếm 100 ms 1 lần nếu tham số này được set thành 1 thì cứ sau 100 ms hàm user_esp_platform_check_ip() sẽ được gọi 1 lần.
Bạn có thể xem thêm về cách sử dụng timer trong tài liệu ESP8266 Non-OS SDK API Reference

!!! warning "Cẩn thận"
    Những hàm sau đây khi cấu hình sẽ ghi dữ liệu vào vùng nhớ lưu trữ Flash, việc ghi cấu hình như vậy quá thường xuyên sẽ gây hỏng bộ nhớ:   
    - `wifi_set_opmode`  
    - `wifi_station_set_config`  
    - `wifi_station_set_auto_connect`  
    SDK cung cấp cho ta các hàm tương để kiểm tra xem cấu hình đó đã tồn tại chưa và thực thi việc ghi nếu chưa:  
    - `wifi_get_opmode`  
    - `wifi_station_get_config`  
    - `wifi_station_get_auto_connect`  
    Và các hàm chỉ ghi dữ liệu lên RAM và thực thi 
    - `wifi_set_opmode_current`  
    - `wifi_station_set_config_current`  
    Có thể xem thêm tại `$SDK/include/user_interface.h`

##References:
1. [https://espressif.com/sites/default/files/documentation/2c-esp8266_non_os_sdk_api_reference_en.pdf](https://espressif.com/sites/default/files/documentation/2c-esp8266_non_os_sdk_api_reference_en.pdf)
2. [https://espressif.com/en/products/hardware/esp8266ex/resources](https://espressif.com/en/products/hardware/esp8266ex/resources)


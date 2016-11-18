# Tổng quan
ESP Touch là protocol được dùng trong Smart Config để người dùng có thể kết nối tới các phiên bản modul ESP8266 thông qua cấu hình đơn giản trên Smartphone.
Ban đầu không thể kết nối với ESP8266, nhưng thông qua giao thức ESP-TOUCH thì Smartphone sẽ gửi gói UDP tới Access Point(AP) ở đây là ESP8266, mã hóa SSID và mật khẩu thành trường Length trong gói UDP, để ESP8266 có thể hiểu và giải mã được thông tin.

Cấu trúc gói tin sẽ có dạng

| 6  | 6  | 2      | 3   | 5    | Variable | 4   |
|----|----|--------|-----|------|----------|-----|
| DA | SA | Length | LLC | SNAP | DATA     | FCS |

Length bao gồm SSID và thông tin key cho ESP8266

# Chương trình

Tổ chức file căn cứ theo bài [Makefile cho các dự án phức tạp](../basic/complex-makefile.md), toàn bộ cấu trúc file, **Makefile, user_config.h, rf_init.c** giữ nguyên, thay đổi nội dung file `main.c` và thêm một số thư mục cần thiết. 

!!! note "Nội dung"
    Smartconfig cho ESP8266 thông qua Smartphone

## Lấy dự án về từ Github 

```bash
https://github.com/esp8266vn/esp8266-nonos-smart-config-fota.git
cd sp8266-nonos-smart-config-fota && make
make flash
```

## Sơ đồ file

```
├── assets
│   └── fota-flow.png
├── build
│   ├── driver
│   │   ├── key.o
│   │   ├── led.o
│   │   └── uart.o
│   ├── esp8266-nonos-app.a
│   ├── esp8266-nonos-app.out
│   └── user
│       ├── fota.o
│       ├── rfinit.o
│       ├── sc.o
│       ├── user_json.o
│       ├── user_main.o
│       └── wps.o
├── driver
│   ├── key.c
│   ├── led.c
│   ├── Makefile
│   └── uart.c
├── firmware
│   ├── esp8266-nonos-app0x00000.bin
│   └── esp8266-nonos-app0x10000.bin
├── fota-flow.md
├── include
│   ├── driver
│   │   ├── key.h
│   │   ├── led.h
│   │   ├── uart.h
│   │   └── uart_register.h
│   └── user_config.h
├── ld
│   ├── eagle.rom.addr.v6.ld
│   ├── with-espboot-flash-at-0x2000-size-1M.ld
│   └── without-bootloader.ld
├── Makefile
├── README.md
├── SublimeAStyleFormatter.sublime-settings
└── user
    ├── fota.c
    ├── fota.h
    ├── Makefile
    ├── rfinit.c
    ├── sc.c
    ├── sc.h
    ├── user_json.c
    ├── user_json.h
    ├── user_main.c
    ├── wps.c
    └── wps.h

10 directories, 41 files

```

## Mã nguồn
Phần cấu hình cho Smartconfig được thực hiện tại 2 file là `sc.c` và `sc.h`

```
#include "ets_sys.h"
#include "osapi.h"
#include "ip_addr.h"
#include "espconn.h"
#include "mem.h"


#include "user_interface.h"
#include "smartconfig.h"
#include "airkiss.h"

#include "driver/led.h"


#define DEVICE_TYPE     "gh_9e2cff3dfa51" //wechat public number
#define DEVICE_ID       "122475" //model ID

#define DEFAULT_LAN_PORT  12476
uint32_t sc_run = 0;
LOCAL esp_udp ssdp_udp;
LOCAL struct espconn pssdpudpconn;
LOCAL os_timer_t ssdp_time_serv;

uint8_t  lan_buf[200];
uint16_t lan_buf_len;
uint8    udp_sent_cnt = 0;

const airkiss_config_t akconf =
{
  (airkiss_memset_fn)&memset,
  (airkiss_memcpy_fn)&memcpy,
  (airkiss_memcmp_fn)&memcmp,
  0,
};

LOCAL void ICACHE_FLASH_ATTR
airkiss_wifilan_time_callback(void)
{
  uint16 i;
  airkiss_lan_ret_t ret;

  if ((udp_sent_cnt++) > 30) {
    udp_sent_cnt = 0;
    os_timer_disarm(&ssdp_time_serv);//s
    //return;
  }

  ssdp_udp.remote_port = DEFAULT_LAN_PORT;
  ssdp_udp.remote_ip[0] = 255;
  ssdp_udp.remote_ip[1] = 255;
  ssdp_udp.remote_ip[2] = 255;
  ssdp_udp.remote_ip[3] = 255;
  lan_buf_len = sizeof(lan_buf);
  ret = airkiss_lan_pack(AIRKISS_LAN_SSDP_NOTIFY_CMD,
                         DEVICE_TYPE, DEVICE_ID, 0, 0, lan_buf, &lan_buf_len, &akconf);
  if (ret != AIRKISS_LAN_PAKE_READY) {
    INFO("[SC] Pack lan packet error!");
    return;
  }

  ret = espconn_sendto(&pssdpudpconn, lan_buf, lan_buf_len);
  if (ret != 0) {
    INFO("[SC] UDP send error!");
  }
  INFO("[SC] Finish send notify!\n");
}

LOCAL void ICACHE_FLASH_ATTR
airkiss_wifilan_recv_callbk(void *arg, char *pdata, unsigned short len)
{
  uint16 i;
  remot_info* pcon_info = NULL;

  airkiss_lan_ret_t ret = airkiss_lan_recv(pdata, len, &akconf);
  airkiss_lan_ret_t packret;

  switch (ret) {
  case AIRKISS_LAN_SSDP_REQ:
    espconn_get_connection_info(&pssdpudpconn, &pcon_info, 0);
    INFO("[SC] remote ip: %d.%d.%d.%d \r\n", pcon_info->remote_ip[0], pcon_info->remote_ip[1],
              pcon_info->remote_ip[2], pcon_info->remote_ip[3]);
    INFO("[SC] remote port: %d \r\n", pcon_info->remote_port);

    pssdpudpconn.proto.udp->remote_port = pcon_info->remote_port;
    os_memcpy(pssdpudpconn.proto.udp->remote_ip, pcon_info->remote_ip, 4);
    ssdp_udp.remote_port = DEFAULT_LAN_PORT;

    lan_buf_len = sizeof(lan_buf);
    packret = airkiss_lan_pack(AIRKISS_LAN_SSDP_RESP_CMD,
                               DEVICE_TYPE, DEVICE_ID, 0, 0, lan_buf, &lan_buf_len, &akconf);

    if (packret != AIRKISS_LAN_PAKE_READY) {
      INFO("[SC] Pack lan packet error!");
      return;
    }

    INFO("\r\n\r\n");
    for (i = 0; i < lan_buf_len; i++)
      INFO("%c", lan_buf[i]);
    INFO("\r\n\r\n");

    packret = espconn_sendto(&pssdpudpconn, lan_buf, lan_buf_len);
    if (packret != 0) {
      INFO("[SC] LAN UDP Send err!");
    }
    os_timer_disarm(&ssdp_time_serv);//s
    break;
  default:
    INFO("[SC] Pack is not ssdq req!%d\r\n", ret);
    break;
  }
}

void ICACHE_FLASH_ATTR
airkiss_start_discover(void)
{
  ssdp_udp.local_port = DEFAULT_LAN_PORT;
  pssdpudpconn.type = ESPCONN_UDP;
  pssdpudpconn.proto.udp = &(ssdp_udp);
  espconn_regist_recvcb(&pssdpudpconn, airkiss_wifilan_recv_callbk);
  espconn_create(&pssdpudpconn);

  os_timer_disarm(&ssdp_time_serv);
  os_timer_setfn(&ssdp_time_serv, (os_timer_func_t *)airkiss_wifilan_time_callback, NULL);
  os_timer_arm(&ssdp_time_serv, 1000, 1);//1s
}


void ICACHE_FLASH_ATTR
smartconfig_done(sc_status status, void *pdata)
{
  switch (status) {
  case SC_STATUS_WAIT:
    INFO("[SC] SC_STATUS_WAIT\n");
    break;
  case SC_STATUS_FIND_CHANNEL:
    INFO("[SC] SC_STATUS_FIND_CHANNEL\n");
    break;
  case SC_STATUS_GETTING_SSID_PSWD:
    INFO("[SC] SC_STATUS_GETTING_SSID_PSWD\n");
    sc_type *type = pdata;
    if (*type == SC_TYPE_ESPTOUCH) {
      INFO("[SC] SC_TYPE:SC_TYPE_ESPTOUCH\n");
    } else {
      INFO("[SC] SC_TYPE:SC_TYPE_AIRKISS\n");
    }
    break;
  case SC_STATUS_LINK:
    INFO("[SC] SC_STATUS_LINK\n");
    struct station_config *sta_conf = pdata;

    wifi_station_set_config(sta_conf);
    wifi_station_disconnect();
    wifi_station_connect();
    led_blink(1, 0);
    break;
  case SC_STATUS_LINK_OVER:
    INFO("[SC] SC_STATUS_LINK_OVER\n");
    if (pdata != NULL) {
      //SC_TYPE_ESPTOUCH
      uint8 phone_ip[4] = {0};

      os_memcpy(phone_ip, (uint8*)pdata, 4);
      INFO("[SC] Phone ip: %d.%d.%d.%d\n", phone_ip[0], phone_ip[1], phone_ip[2], phone_ip[3]);
    } else {
      //SC_TYPE_AIRKISS - support airkiss v2.0
      airkiss_start_discover();
    }
    smartconfig_stop();
    sc_run = 0;
    break;
  }

}



void ICACHE_FLASH_ATTR
sc_start(void)
{
  smartconfig_set_type(SC_TYPE_ESPTOUCH_AIRKISS); //SC_TYPE_ESPTOUCH,SC_TYPE_AIRKISS,SC_TYPE_ESPTOUCH_AIRKISS
  if(sc_run)
    smartconfig_stop();
  smartconfig_start(smartconfig_done);
  sc_run = 1;
  INFO("[SC] Started\r\n");
}

```

# Các hàm/ cấu trúc dùng trong SmartConfig

## Hàm smartconfig_start 
Hàm dùng để cấu hình thiết bị và kết nối nó tới AP

!!! note "Lưu ý"
    - Hàm chỉ được gọi trong mode Station
    - Gọi hàm `smartconfig_stop` để kết thúc quá trình SmartConfig trước khi gọi các hàm khác

Định nghĩa

```
bool smartconfig_start(sc_callback_t cb, uint8 log)
```

Thông số

Giá trị trả về

| TRUE  | Thành công |
|-------|------------|
| FALSE | Thất bại   |

## Hàm smartconfig_stop 
Hàm dùng để dừng quá trình Smart Config và giải phóng bộ nhớ được tạo ra bởi hàm  `smartconfig_start`

!!! note "Lưu ý"
    Sau khi kết nối được thiết lập thì người dùng có thể gọi hàm giải phóng bộ nhớ

Định nghĩa

```
bool smartconfig_set_type(sc_type type)
```

Thông số 
```
typedef enum {
 SC_TYPE_ESPTOUCH = 0,
 SC_TYPE_AIRKISS,
 SC_TYPE_ESPTOUCH_AIRKISS,
 } sc_type; 
```

Giá trị trả về

| TRUE  | Thành công |
|-------|------------|
| FALSE | Thất bại   |

## Hàm smartconfig_set_type
Hàm dùng để thiết lập kiểu protocol của `smartconfig_start`

!!! note "Lưu ý"
    Phải gọi hàm này trước hàm `smartconfig_start`

Định nghĩa

```
bool smartconfig_stop(void)
```

Thông số 
NULL

Giá trị trả về

| TRUE  | Thành công |
|-------|------------|
| FALSE | Thất bại   |

## Cấu trúc
Có 2 kiểu cấu trúc cho sc_status và sc_type

```
typedef enum {
SC_STATUS_WAIT = 0,
SC_STATUS_FIND_CHANNEL = 0,
SC_STATUS_GETTING_SSID_PSWD,
SC_STATUS_LINK,
SC_STATUS_LINK_OVER,
} sc_status; 
```

```
typedef enum {
SC_TYPE_ESPTOUCH = 0,
SC_TYPE_AIRKISS,
SC_TYPE_ESPTOUCH_AIRKISS,
} sc_type;
```

!!! note "Lưu ý"
    SC_STATUS_FIND_CHANNEL được dùng để hiển thị trạng thái khi tìm channel

# Phần mềm cho android và iOS
Có thể tải file apk dành cho android tại 
[ESP-Touch Android](https://espressif.com/sites/default/files/apks/esptouchandroid-apk_v0.3.4.3_0.rar)

Hoặc tải trực tiếp từ Playstore
[ESP8266 SmartConfig](https://play.google.com/store/apps/details?id=com.cmmakerclub.iot.esptouch&hl=vi)

Và file cho iOS
[ESP-Touch iOS](https://espressif.com/sites/default/files/apks/esptouchios-ipa_v0.3.4.3_0.rar)

# Hoạt động
- Kích hoạt chức năng Smart Config bằng cách lập trình và nạp firmware cho ESP
- Kết nối smartphone với router (kết nối smartphone với mạng wifi hiện có)
- Mở ESP-TOUCH App đã cài đặt trên smartphone
- Kiểm tra SSID (tương ứng với tên Wifi) và mật khẩu (ở đây là mật khẩu wifi của bạn) để kết nối tới thiết bị.
- Thực hiện ấn nút trong thời gian ngắn trên NodeMCU sau đó thả ra sẽ có thông báo

```
[INFO] BOOTUP...
[INFO] SDK: 2.0.0(656edbf)
[INFO] Chip ID: 000A8B7A
[INFO] Memory info:
data  : 0x3ffe8000 ~ 0x3ffe880c, len: 2060
rodata: 0x3ffe8810 ~ 0x3ffe9ff0, len: 6112
bss   : 0x3ffe9ff0 ~ 0x3fff0858, len: 26728
heap  : 0x3fff0858 ~ 0x3fffc000, len: 47016
[INFO] -------------------------------------------
[INFO] Build time: 2016-Th11-18_16:55:45_ICT
[INFO] -------------------------------------------
bcn 0
del if1
usl
mode : sta(60:01:94:0a:8b:7a)
add if0
```

- Tiếp tục ấn nút Flash trên NodeMCU sau đó ấn nút Confirm trên SmartPhone.

# Kết quả
- Nếu thành công sẽ có thông báo trên smartphone về địa chỉ IP của ESP8266 như sau
```
Esptouch success, bssid = xxxx, InnetAddress = 192.168.xx.xx
```

<<<<<<< HEAD
- Ngược lại sẽ có thông báo Esptouch fail.
- Kết quả logfile sẽ được ghi lại trên máy tính như sau

```
[INFO] BOOTUP...
[INFO] SDK: 2.0.0(656edbf)
[INFO] Chip ID: 000A8B7A
[INFO] Memory info:
data  : 0x3ffe8000 ~ 0x3ffe880c, len: 2060
rodata: 0x3ffe8810 ~ 0x3ffe9ff0, len: 6112
bss   : 0x3ffe9ff0 ~ 0x3fff0858, len: 26728
heap  : 0x3fff0858 ~ 0x3fffc000, len: 47016
[INFO] -------------------------------------------
[INFO] Build time: 2016-Th11-18_16:55:45_ICT
[INFO] -------------------------------------------
bcn 0
del if1
usl
mode : sta(60:01:94:0a:8b:7a)
add if0
[KEY] Short press, run smartconfig
SC version: V2.5.4
[SC] Started
scandone
scandone
[SC] SC_STATUS_FIND_CHANNEL
00:16:01:04:6d:d2: 599
00:16:01:04:6d:d2: 598
00:16:01:04:6d:d2: 597
00:16:01:04:6d:d2: 596
T|once 1 84
00:16:01:04:6d:d2: 599
00:16:01:04:6d:d2: 598
00:16:01:04:6d:d2: 597
00:16:01:04:6d:d2: 596
T|once 2 84
iBssid 00:16:01:04:6d:
buf 00:16:01:04:6d:
save, rssi:-81 00:16:01:04:6d:d2:
iCh lock
00:16:01:04:6d:d2: 598
00:16:01:04:6d:d2: 597
rigtt,rssi:-81 00:16:01:04:6d:d2:

TYPE: ESPTOUCH
T|sniffer on ch:2
T|AP MAC: 00 16 01 04 6d d2
T|Head Len : 84
[SC] SC_STATUS_GETTING_SSID_PSWD
[SC] SC_TYPE:SC_TYPE_ESPTOUCH
T|SYNC STATUS
T|64-4
T|192-5
T|168-6
T|1-7
T|0-9
T|9-10
T|0-11
T|5-12
T|2-13
T|6-14
T|3-15
T|3-16
T|8-17
T|9-18
T|@-19
T|29-0
T|243-2
T|201-3
T|64-4
T|192-5
T|168-6
T|0-9
T|9-10
T|0-11
T|5-12
T|2-13
T|6-14
T|3-15
T|3-16
T|8-17
T|9-18
T|@-19
T|29-0
T|11-1
T|SCAN SSID: ten_wifi
T|all lenth: 29,pswd lenth: 11
T|SCAN CRC SSID: 1
T|201-3
T|64-4
T|192-5
T|168-6
T|1-7
T|14-8
T|0-29-2
T|1-11-1
T|2-243-1
T|3-201-2
T|4-64-3
T|5-192-3
T|6-168-3
T|7-1-2
T|8-14-1
T|9-0-2
T|10-9-2
T|11-0-2
T|12-5-2
T|13-2-2
T|14-6-2
T|15-3-2
T|16-3-2
T|17-8-2
T|18-9-2
T|19-@-2
T|pswd: mat_khau_wifi
T|ssid: ten_wifi
T|bssid: 00 16 01 04 6d d2 
[SC] SC_STATUS_LINK
scandone
state: 0 -> 2 (b0)
state: 2 -> 3 (0)
state: 3 -> 5 (10)
add 0
aid 4
cnt 

connected with ten_wifi, channel 2
dhcp client start...
pm open,type:2 0
ip:192.168.1.xx,mask:255.255.255.0,gw:192.168.1.1
[SC] SC_STATUS_LINK_OVER
[SC] Phone ip: 192.168.1.xx
free heap:39984

```
=======
- Ngược lại sẽ có thông báo Esptouch fail.
>>>>>>> origin/master

# Cài đặt công cụ cần thiết
Tương tự phần cài đặt cho ESP8266 NONOS-SDK, tham khảo [tại đây](https://esp8266.vn/nonos-sdk/01-esp-basic/00-esp-basic/)

# Download RTOS SDK cho ESP8266

- Tải về máy & giải nén [từ đây](https://espressif.com/sites/default/files/sdks/esp8266_rtos_sdk_v1.4.0_16_02_26_0.zip)
- Hoặc git clone từ:
```bash
git clone https://github.com/espressif/ESP8266_RTOS_SDK.git
cd ESP8266_RTOS_SDK
# Nhánh 1.4.x đã bao gồm phần vá lỗi (patch) cho bản v1.4.0 (nhánh master)
git checkout 1.4.x
```

- Thay đổi `SDK_BASE` trong Makefile của mỗi dự án trỏ tới folder vừa giải nén/clone:
```makefile
# Ví dụ với người dùng windows và unofficial dev kit
SDK_BASE    ?= C:/Espressif/ESP8266_RTOS_SDK
```

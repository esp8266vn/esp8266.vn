[TOC]

# Sử dụng thư viện MQTT với ESP8266

Tổ chức file căn cứ theo bài [Biên dịch dự án đầu tiên](./compile-first-time.md), toàn bộ cấu trúc file, **Makefile, user_config.h, rf_init.c** giữ nguyên, chỉ thay đổi nội dung file `main.c`. 

!!! note "Nội dung"
    Sử dụng MQTT cho ESP8266

## Lấy dự án về từ Github 

```bash
git clone https://github.com/tuanpmt/esp_mqtt.git
```

## Sơ đồ file

```

```

## Mã nguồn

## Publish và subcribe tin nhắn
```
/* TRUE if success */
BOOL MQTT_Subscribe(MQTT_Client *client, char* topic, uint8_t qos);

BOOL MQTT_Publish(MQTT_Client *client, const char* topic, const char* data, int data_length, int qos, int retain);
```

## Kết quả

## Tham khảo
[MQTT LCD](https://github.com/eadf/esp_mqtt_lcd)
[MQTT Broker for test](https://github.com/mcollina/mosca)

[MQTT Client for test](https://chrome.google.com/webstore/detail/mqttlens/hemojaaeigabkbcookmlgmdigohjobjm?hl=en)
[TOC]

## Progmem

Bộ nhớ chỉ đọc lưu trong vùng nhớ Flash có cùng cách hoạt động với Arduino thông thường. Đặt chuỗi dữ liệu hay string vào vùng nhớ chỉ đọc giúp tiết kiệm bộ nhớ RAM của chương trình.

!!! note "Lưu ý"
    Điều khác biệt nhất là chuỗi dữ liệu định nghĩa sẵn này không được không được gộp chung. Nếu bạn đặt chuỗi trong `F("")` và/hoặc trong `PSTR("")` sẽ chiếm dụng bộ nhớ cho mỗi instance của mã. Cho nên bạn cần tự quản lý những chuỗi string trùng.

Một số macro hỗ trợ có thể dễ dàng sử dụng ```const PROGMEM``` để có thể gọi  từ ```__FlashStringHelper``` hàm ```FPSTR()```. 

```c++
String response1;
response1 += F("http:");
...
String response2;
response2 += F("http:");
```

using FPSTR would become...

```c++
const char HTTP[] PROGMEM = "http:";
...
{
    String response1;
    response1 += FPSTR(HTTP);
    ...
    String response2;
    response2 += FPSTR(HTTP);
}
```

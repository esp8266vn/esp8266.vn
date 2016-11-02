#ESP-specific APIs 

APIs đề cập đến deep sleep và watchdog timer có tác dụng với các ESP phiên bản Alpha.

- `ESP.deepSleep(microseconds, mode)` sẽ đưa chip vào chế độ deep sleep, với `mode` là một trong cách thông số `WAKE_RF_DEFAULT`, `WAKE_RFCAL`, `WAKE_NO_RFCAL`, `WAKE_RF_DISABLED`. ( GPIO16 cần được nối tới RST để đưa chip ra khỏi deepSleep )
- `ESP.rtcUserMemoryWrite(offset, &data, sizeof(data))` và `ESP.rtcUserMemoryRead(offset, &data, sizeof(data))` cho phép dữ liệu được lưu trữ vào bộ nhớ và lấy dữ liệu từ `RTC user memory` của chip tương ứng. Tổng kích thước của `RTC user memory` là 512 bytes, do đó `offser + sizeof(data)` không được vượt quá 512 bytes. Dữ liệu được xếp thành từng phần 4-bytes. Dữ liệu đã được lưu trữ có thể được dùng giữ các chu kỳ `deep sleep`. Tuy nhiên, dữ liệu có thể bị mất sau `power cycling` của chip.
- `ESP.restart()` khởi động lại CPU.
- `ESP.getResetReason()` trả về chuỗi chứa nguyên do thiết lập lại ở định dạng mà con người hiểu được.
- `ESP.getFreeHeap()` trả về kích thước heap trống.
- `ESP.getChipId()` trả về ID chip ESP8266 như một số nguyển 32-bit.

## Một số API có thể được sử dụng để biết thông tin về flash:

- `ESP.getFlashChipId()` trả về ID chip flash theo số nguyên 32-bit. 
- `ESP.getFlashChipSize()` trả về dung lượng của chip flash theo bytes, như được thấy trong SDK ( dung lượng flash có thể nhỏ hơn dung lượng thực tế ).
- `ESP.getFlashChipSpeed(void)` trả về tần số của flash theo `Hz`.
- `ESP.getCycleCount()` trả về số chu kỳ mà CPU đã thực hiện kể từ khi bắt đầu bằng số nguyên 32-bit. Điều này rất hưu ích để biết chính xác thời gian thực hiện những công việc được thực hiện rất nhanh, giống như bit banging.
- `ESP.getVcc()` có thể được sử dụng để đo điện áp cung cấp. ESP cẩn phải cấu hình lại ADC lúc khởi động để tính năng có sẳn. Thêm dòng lệnh sau ở đầu chương trình thức việc việc này để sử dụng `getVcc` :
- `ADC_MODE(ADC_VCC);`

Chân TOUT phải ngắt kết nối ở chế độ này.

!!! warning "Quan trọng"
    Mặc định ADC được cấu hình để đọc từ chân TOUT, việc sử dụng `analogRead(A0)`, và `ESP.getVCC()` không có hiệu lực.

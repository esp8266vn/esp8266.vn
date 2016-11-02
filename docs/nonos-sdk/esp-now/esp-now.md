# Giới thiệu
- ESP-NOW là một giao thức được phát triển bởi Espressif cho phép nhiều thiết bị có thể kết nối với nhau mà không cần dùng Wifi. Các thiết bị sau khi kết nối được với nhau sẽ là peer-to-peer, và không yêu cầu bắt tay.
- ESP-NOW có thể được xem là một công nghệ được sử dụng cho ESP8266 để truyền các gói dữ liệu với tốc độ cao, nó được ứng dụng trong các thiết bị chiếu sáng thông minh, điều khiển từ xa các cảm biến,...
- Trong ESP-NOW dùng chuẩn IEEE802.11 cùng các hàm IE và mã hóa CCMP đảm bảo được độ tin cậy.

# Các chức năng chính
- ESP-NOW có hỗ trợ các đặc điểm sau:
    + Mã hóa và giải mã gói tin unicast
    + Mã hóa trộn và giải mã với peer devices
    + Playload có thể lên tới 250 byte
    + Có hàm callback để xác định được việc truyền dữ liệu thành công hay thất bại
- Tuy nhiên cũng có một số hạn chế:
    + Không hỗ trợ broadcast
    + Giới hạn các peer được mã hóa. Khoảng 10 peer được mã hóa trong mode Station, 6 peer trong SoftAP hoặc SoftAP + mode Station. Peer không mã hóa có thể có số lượng nhiều hơn nhưng phải nhỏ hơn 20.
    + Playload bị giới hạn 250 byte.

# Mô tả
Thông tin sẽ bao gồm
- Trong local device
    + PMW
    + Role
- Trong peer
    + Key
    + Địa chỉ MAC
    + Role
    + Channel
- Bảng mô tả

| Device       | Thông tin  | Giá trị/ Độ dài             | Mô tả                                                                                                                               | Ghi chú                                                                                                                                                                                                                                                                 |
|--------------|------------|-----------------------------|-------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Local device | PMK        | Độ dài 16 byte              | Primary Master Key, ví dụ như KOK trongAPI, dùng để mã hóa Key của peer.                                                            | Hệ thống sẽ tạo PMK mặc định, không cần phải config                                                                                                                                                                                                                     |
|              | Role       | IDLE CONTROLLER SLAVE COMBO | Đây là vai trò(role) của device IDLE: chưa phân role CONTROLLER:controller SLAVE: slave COMBO: đảm nhiệm 2 role là controller slave | Role của local device được định nghĩa thông qua SoftAP hoặc Station của ESP-NOW IDLE:  việc truyền nhận sẽ không được cho phép CONTROLLER: ưu tiên cho Sation interface SLAVE: ưu tiên cho SoftAP interface COMBO: ưu tiên cho cả SoftAP interface và Station interface |
| Peer         | Key        | Độ dài 16 byte              | Sử dụng để mã hóa paload key trong quá trình giao tiếp với các peer                                                                 |                                                                                                                                                                                                                                                                         |
|              | MacAddress | Độ dài 6 byte               | Địa chỉ MAC của peer                                                                                                                | Địa chỉ MAC phải cùng với địa chỉ gửi. Ví dụ như nếu gói tin được gửi từ Station interface thì địa chỉ MAC phải giống với địa chỉ của Station                                                                                                                           |
|              | Role       | IDLE CONTROLLER SLAVE COMBO | Đây là vai trò(role) của device IDLE: chưa phân role CONTROLLER:controller SLAVE: slave COMBO: đảm nhiệm 2 role là controller slave |                                                                                                                                                                                                                                                                         |
|              | Channel    | Giá trị từ 0 - 255          | Kênh để local device và peer kết nối với nhau                                                                                       |                                                                                                                                                                                                                                                                         |

# Tham khảo
- Có thể xem thêm các tài liệu mô tả về [ESP-NOW](https://espressif.com/en/products/software/esp-now/resources) của Espressif
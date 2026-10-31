# GarageManager_Swift

GarageManager_Swift là ứng dụng iOS dành cho việc quản lý vận hành xưởng sửa chữa và gara ô tô. Ứng dụng được xây dựng bằng SwiftUI, kiến trúc MVVM với framework Observation (`@Observable`), kết nối trực tiếp với backend Supabase Cloud.

---

## Tính năng chính

- **Trang chủ & Quản lý cầu nâng (Dashboard)**:
  - Thống kê thời gian thực: doanh thu ngày, số lượng xe đang sửa, xe đã hoàn thành, lịch hẹn chờ duyệt.
  - Theo dõi trạng thái trực quan 4 khoang cầu nâng (xe đang sửa, thợ phụ trách, trạng thái khoang).
  - 8 ô lối tắt mở nhanh các module tác vụ.

- **Lịch hẹn tiếp nhận xe (Appointments)**:
  - Quản lý danh sách lịch hẹn của khách.
  - Bộ lọc trạng thái: Chờ xác nhận, Đã xác nhận, Đang xử lý, Hoàn thành, Đã hủy.
  - Phân công kỹ thuật viên và xếp khoang cầu nâng.

- **Lệnh sửa chữa & Hóa đơn (Work Orders & Invoices)**:
  - Quản lý lệnh sửa chữa theo mã (WO-xxxx).
  - Bóc tách chi phí minh bạch: tiền công thợ, tiền phụ tùng linh kiện, chiết khấu và tổng thanh toán.
  - Theo dõi quy trình từ tiếp nhận, chẩn đoán, chờ phụ tùng đến thanh toán.

- **Quản lý đồ nghề & thiết bị (Tool Management)**:
  - 4 chỉ số KPI: Tổng số, Sẵn sàng, Báo hỏng, Đang dùng.
  - Theo dõi vị trí lưu trữ trong xưởng.
  - Sheet báo hỏng trực tiếp để kỹ thuật viên ghi nhận sự cố thiết bị.

- **Kho phụ tùng & vật tư (Inventory)**:
  - Quản lý tồn kho linh kiện, dầu nhớt theo mã SKU và vị trí kệ.
  - Cảnh báo tự động các mặt hàng chạm ngưỡng tồn kho tối thiểu.

- **Đội ngũ thợ máy (Technicians)**:
  - Quản lý danh sách thợ, chuyên môn (Máy, Gầm, Điện, Điều hòa...), số điện thoại.
  - Trạng thái ca trực (Sẵn sàng, Đang bận, Nghỉ ca), đánh giá và số lượng xe đang phụ trách.

- **Chi phí & Sổ quỹ (Expenses)**:
  - Theo dõi chi phí vận hành hàng tháng.
  - Phân loại chi phí cố định (mặt bằng) và biến đổi (điện nước, vật tư tiêu hao).

- **Bảng giá dịch vụ (Services)**:
  - Bảng giá công sửa chữa tiêu chuẩn và các gói combo bảo dưỡng định kỳ.

---

## Kiến trúc & Công nghệ

| Thành phần | Công nghệ |
|------------|-----------|
| Nền tảng | iOS 17.0+ |
| Ngôn ngữ | Swift 5.9+ / Swift 6 |
| Giao diện | SwiftUI (chuẩn iOS Human Interface Guidelines) |
| Kiến trúc | MVVM (Model - View - ViewModel) |
| Quản lý trạng thái | Apple Observation framework (`@Observable`) |
| Backend & Database | Supabase (PostgreSQL, Swift SDK 2.x) |
| Đồng bộ dự án | PBXFileSystemSynchronizedRootGroup (Xcode 16) |

---

## Cấu trúc thư mục

```text
GarageManager_Swift/
├── App/
│   ├── GarageManager_SwiftApp.swift       // Khởi động ứng dụng (@main)
│   └── MainTabView.swift                  // Điều hướng 5 tab chuẩn iOS HIG
│
├── Models/                                // Model Codable khớp Supabase schema
│   ├── Tool.swift                         // Dụng cụ, đồ nghề (bảng tools)
│   ├── Appointment.swift                  // Lịch hẹn xe (bảng appointments)
│   ├── WorkOrder.swift                    // Lệnh sửa chữa & hóa đơn (bảng invoices)
│   ├── Product.swift                      // Phụ tùng, dầu nhớt (bảng products)
│   ├── Technician.swift                   // Kỹ thuật viên (bảng staff)
│   └── Expense.swift                      // Chi phí vận hành (bảng fixed_expenses)
│
├── ViewModels/                            // Tầng logic nghiệp vụ (@Observable)
│   ├── DashboardViewModel.swift           // Tính doanh thu, trạng thái khoang cầu nâng
│   ├── ToolViewModel.swift                // Kiểm kê, báo hỏng dụng cụ
│   ├── AppointmentViewModel.swift         // Quản lý lịch hẹn, xếp thợ
│   └── InvoiceViewModel.swift             // Tính tiền công, phụ tùng, hóa đơn
│
├── Views/                                 // Giao diện người dùng
│   ├── Dashboard/
│   │   ├── DashboardView.swift            // Màn hình trang chủ
│   │   ├── QuickActionGrid.swift          // Lối tắt 8 module
│   │   └── LiftBayStatusView.swift        // Trạng thái 4 khoang cầu nâng
│   │
│   ├── Appointments/
│   │   ├── AppointmentListView.swift      // Danh sách lịch hẹn
│   │   └── AppointmentCardView.swift      // Card thông tin xe
│   │
│   ├── Invoices/
│   │   ├── InvoiceListView.swift          // Danh sách hóa đơn & lệnh SC
│   │   └── InvoiceDetailView.swift        // Chi tiết chi phí
│   │
│   ├── Tools/
│   │   ├── ToolListView.swift             // Danh sách đồ nghề + 4 thẻ KPI
│   │   ├── ToolCardView.swift             // Thẻ chi tiết dụng cụ
│   │   └── DamageReportSheet.swift        // Sheet báo hỏng đồ nghề
│   │
│   ├── Inventory/
│   │   └── ProductListView.swift          // Kho phụ tùng & cảnh báo tồn
│   │
│   └── More/
│       ├── MoreHubView.swift              // Menu quản trị tổng hợp
│       ├── ServiceListView.swift          // Bảng giá dịch vụ & combo
│       ├── TechnicianListView.swift       // Danh sách thợ máy
│       └── ExpenseListView.swift          // Chi phí & sổ quỹ
│
├── Services/
│   └── SupabaseManager.swift              // Supabase Client Singleton
│
└── Components/                            // UI components dùng chung
    ├── MetricCard.swift                   // Thẻ KPI
    └── StatusBadge.swift                  // Badge trạng thái
```

---

## Hướng dẫn cài đặt & Chạy dự án

### Yêu cầu hệ thống
- macOS Sonoma 14.0 trở lên
- Xcode 15.0+ hoặc Xcode 16.0+
- iOS 17.0+ Simulator hoặc thiết bị thật

### Các bước cài đặt
1. Clone repository:
   ```bash
   git clone https://github.com/ThanhhDaoo/GarageManager_Swift.git
   cd GarageManager_Swift
   ```
2. Mở file dự án:
   ```bash
   open GarageManager_Swift.xcodeproj
   ```
3. Xcode sẽ tự động giải quyết các gói phụ thuộc qua Swift Package Manager (SPM):
   - `supabase-swift`
4. Cấu hình Supabase (nếu sử dụng project riêng):
   Cập nhật URL và anon key trong `GarageManager_Swift/Services/SupabaseManager.swift`:
   ```swift
   private let supabaseURL = URL(string: "https://<your-project-id>.supabase.co")!
   private let supabaseAnonKey = "<your-anon-key>"
   ```
5. Chọn thiết bị đích và bấm **Run** (`⌘ + R`).

---

## Bảng Database (Supabase)

| Bảng | Model Swift | Mô tả |
|------|-------------|-------|
| `tools` | `Tool.swift` | Dụng cụ, số lượng khả dụng, hỏng hóc |
| `appointments` | `Appointment.swift` | Lịch hẹn, thông tin xe, khách hàng |
| `invoices` | `WorkOrder.swift` | Lệnh sửa chữa, chi phí công thợ và phụ tùng |
| `products` | `Product.swift` | Phụ tùng, dầu nhớt, cảnh báo tồn kho |
| `staff` | `Technician.swift` | Kỹ thuật viên, chuyên môn, phân ca |
| `fixed_expenses` | `Expense.swift` | Chi phí vận hành gara |

---

## Tác giả

Trần Thanh Đạo (@ThanhhDaoo)

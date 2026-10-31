# 🚗 GarageManager_Swift

> **GarageManager_Swift** là ứng dụng iOS chuyên nghiệp dành cho việc quản lý vận hành xưởng sửa chữa & gara ô tô. Ứng dụng được xây dựng hoàn toàn bằng **SwiftUI**, áp dụng kiến trúc **MVVM** hiện đại cùng framework **Observation** (`@Observable`), kết nối trực tiếp với backend **Supabase Cloud**.

---

## 📌 Tính năng nổi bật

- 📊 **Trang chủ & Quản lý Cầu Nâng (Dashboard)**:
  - Thống kê thời gian thực: Doanh thu trong ngày, số lượng xe đang sửa chữa, xe đã hoàn thành, lịch hẹn chờ tiếp nhận.
  - Theo dõi trạng thái trực quan của 4 khoang cầu nâng (đang có xe/trống, thông tin xe, thợ phụ trách).
  - 8 ô lối tắt (Quick Actions) giúp điều hướng nhanh đến các module quan trọng.

- 📅 **Lịch Hẹn Tiếp Nhận Xe (Appointments)**:
  - Quản lý danh sách lịch hẹn đặt trước của khách hàng.
  - Bộ lọc thông minh theo trạng thái: *Chờ xác nhận, Đã xác nhận, Đang xử lý, Hoàn thành, Đã hủy*.
  - Gán thợ kỹ thuật và xếp khoang cầu nâng tương ứng.

- 🧾 **Lệnh Sửa Chữa & Hóa Đơn (Work Orders & Invoices)**:
  - Lập lệnh sửa chữa theo mã lệnh (`WO-xxxx`).
  - Phân tách minh bạch chi phí: **Tiền công thợ máy** + **Tiền phụ tùng, linh kiện** - **Chiết khấu**.
  - Theo dõi tiến độ sửa chữa từ tiếp nhận, chẩn đoán, chờ phụ tùng đến thanh toán.

- 🧰 **Quản Lý Đồ Nghề & Thiết Bị (Tool Management)**:
  - 4 thẻ KPI kiểm kê: *Tổng số, Sẵn sàng, Báo hỏng, Đang dùng*.
  - Tra cứu vị trí tủ/kệ đựng dụng cụ.
  - Tích hợp **DamageReportSheet** (Sheet vuốt lên) cho phép kỹ thuật viên báo hỏng đồ nghề tức thì.

- 📦 **Kho Phụ Tùng & Vật Tư (Inventory)**:
  - Quản lý danh mục dầu nhớt, linh kiện, phụ tùng theo mã SKU.
  - Cảnh báo tự động khi số lượng tồn kho giảm xuống dưới ngưỡng tối thiểu (`min_stock_alert`).

- 👥 **Đội Ngũ Kỹ Thuật Viên (Technicians)**:
  - Quản lý thông tin thợ, tay nghề/chuyên môn (Máy, Gầm, Điện, Điều hòa...).
  - Theo dõi trạng thái ca làm việc (*Sẵn sàng, Đang bận, Nghỉ ca*), đánh giá sao và số xe đang phụ trách.

- 💰 **Chi Phí Gara & Sổ Quỹ (Expenses)**:
  - Báo cáo chi phí vận hành hàng tháng.
  - Phân loại chi phí cố định (tiền thuê xưởng) và chi phí biến đổi (điện, nước, vật tư tiêu hao).

- 📋 **Bảng Giá Dịch Vụ (Service Price List)**:
  - Danh mục giá dịch vụ tiêu chuẩn và các gói Combo bảo dưỡng định kỳ tiết kiệm.

---

## 🏗️ Kiến trúc & Công nghệ

| Thành phần | Công nghệ sử dụng |
|------------|-------------------|
| **Nền tảng** | iOS 17.0+ |
| **Ngôn ngữ** | Swift 5.9+ / Swift 6 |
| **Giao diện** | SwiftUI (tuân thủ Apple Human Interface Guidelines - HIG) |
| **Kiến trúc** | MVVM (Model - View - ViewModel) |
| **Quản lý trạng thái** | Apple `Observation` Framework (`@Observable`) |
| **Backend & Database** | [Supabase](https://supabase.com) (PostgreSQL, Swift SDK 2.x) |
| **Cấu trúc dự án** | PBXFileSystemSynchronizedRootGroup (Xcode 16) |

---

## 📂 Cấu trúc thư mục dự án

```text
GarageManager_Swift/
├── App/
│   ├── GarageManager_SwiftApp.swift       // Điểm khởi động ứng dụng (@main)
│   └── MainTabView.swift                  // Điều hướng 5 Tab đáy chuẩn iOS HIG
│
├── Models/                                // Kiểu dữ liệu Codable khớp với Supabase Schema
│   ├── Tool.swift                         // Dụng cụ & đồ nghề (bảng tools)
│   ├── Appointment.swift                  // Lịch hẹn tiếp nhận xe (bảng appointments)
│   ├── WorkOrder.swift                    // Lệnh sửa chữa & hóa đơn (bảng invoices)
│   ├── Product.swift                      // Phụ tùng, dầu nhớt, tồn kho (bảng products)
│   ├── Technician.swift                   // Nhân sự kỹ thuật viên (bảng staff)
│   └── Expense.swift                      // Chi phí vận hành gara (bảng fixed_expenses)
│
├── ViewModels/                            // Tầng nghiệp vụ logic (@Observable)
│   ├── DashboardViewModel.swift           // Tính doanh thu ngày, quản lý 4 khoang cầu nâng
│   ├── ToolViewModel.swift                // Xử lý báo hỏng đồ nghề, đề xuất mua sắm
│   ├── AppointmentViewModel.swift         // Tiếp nhận đặt hẹn, lọc trạng thái, gán việc cho thợ
│   └── InvoiceViewModel.swift             // Tính tiền công + phụ tùng - chiết khấu
│
├── Views/                                 // Giao diện người dùng
│   ├── Dashboard/
│   │   ├── DashboardView.swift            // Màn hình Trang Chủ
│   │   ├── QuickActionGrid.swift          // 8 ô lối tắt mở nhanh module
│   │   └── LiftBayStatusView.swift        // Trực quan 4 khoang cầu nâng
│   │
│   ├── Appointments/
│   │   ├── AppointmentListView.swift      // Danh sách lịch hẹn xe
│   │   └── AppointmentCardView.swift      // Thẻ chi tiết từng xe hẹn
│   │
│   ├── Invoices/
│   │   ├── InvoiceListView.swift          // Danh sách Hóa đơn & Lệnh SC
│   │   └── InvoiceDetailView.swift        // Chi tiết thanh toán & chi phí
│   │
│   ├── Tools/
│   │   ├── ToolListView.swift             // Danh sách đồ nghề + 4 thẻ KPI
│   │   ├── ToolCardView.swift             // Thẻ hiển thị từng dụng cụ
│   │   └── DamageReportSheet.swift        // Sheet vuốt lên Báo hỏng đồ nghề
│   │
│   ├── Inventory/
│   │   └── ProductListView.swift          // Kho phụ tùng & Cảnh báo tồn
│   │
│   └── More/
│       ├── MoreHubView.swift              // Menu Tab 5 Quản Trị Tổng Hợp
│       ├── ServiceListView.swift          // Bảng giá dịch vụ & Gói combo
│       ├── TechnicianListView.swift       // Quản lý nhân sự thợ máy
│       └── ExpenseListView.swift          // Chi phí & Báo cáo tháng
│
├── Services/
│   └── SupabaseManager.swift              // Kết nối Supabase Client Singleton
│
└── Components/                            // Các thành phần UI tái sử dụng
    ├── MetricCard.swift                   // Thẻ KPI chỉ số
    └── StatusBadge.swift                  // Badge trạng thái tự động màu
```

---

## 🚀 Hướng dẫn Cài đặt & Chạy dự án

### 1. Yêu cầu hệ thống
- macOS Sonoma (14.0) trở lên
- Xcode 15.0+ hoặc Xcode 16.0+
- iOS 17.0+ Deployment Target

### 2. Cài đặt
1. Clone dự án về máy:
   ```bash
   git clone https://github.com/ThanhhDaoo/GarageManager_Swift.git
   cd GarageManager_Swift
   ```
2. Mở dự án trong Xcode:
   ```bash
   open GarageManager_Swift.xcodeproj
   ```
3. Xcode sẽ tự động giải quyết các gói phụ thuộc Swift Package Manager (SPM):
   - `supabase-swift`
   - `swift-clocks`
   - `swift-crypto`
   - `swift-http-types`
4. Cấu hình Supabase (nếu dùng project Supabase riêng):
   Mở tệp `GarageManager_Swift/Services/SupabaseManager.swift` và cập nhật thông tin:
   ```swift
   private let supabaseURL = URL(string: "https://<your-project-id>.supabase.co")!
   private let supabaseAnonKey = "<your-anon-key>"
   ```
5. Chọn Simulator (ví dụ: iPhone 16 / iPhone 17) và nhấn **Run** (`⌘ + R`).

---

## 🗄️ Bảng Database Tương Ứng (Supabase)

| Bảng trong Database | Model trong Swift | Mô tả |
|---------------------|-------------------|-------|
| `tools` | `Tool.swift` | Quản lý danh mục dụng cụ, số lượng hỏng/khả dụng |
| `appointments` | `Appointment.swift` | Quản lý thông tin xe, khách hàng và lịch tiếp nhận |
| `invoices` | `WorkOrder.swift` | Lệnh sửa chữa, công thợ, vật tư và hóa đơn |
| `products` | `Product.swift` | Danh mục phụ tùng, đơn giá, tồn kho tối thiểu |
| `staff` | `Technician.swift` | Nhân sự thợ máy, xếp ca, năng suất |
| `fixed_expenses` | `Expense.swift` | Chi phí cố định & biến đổi hàng tháng |

---

## 📄 Bản quyền & Tác giả

Phát triển bởi **Trần Thanh Đạo** (@ThanhhDaoo).
Dự án được phân phối dưới giấy phép nội bộ.

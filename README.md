# GarageManager_Swift

[![iOS](https://img.shields.io/badge/iOS-17.0%2B-blue.svg)](https://developer.apple.com/ios/)
[![Swift](https://img.shields.io/badge/Swift-5.9%20%7C%206.0-orange.svg)](https://swift.org/)
[![Xcode](https://img.shields.io/badge/Xcode-15%20%7C%2016-blue.svg)](https://developer.apple.com/xcode/)
[![Architecture](https://img.shields.io/badge/Architecture-MVVM%20%2B%20Observation-green.svg)](https://developer.apple.com/documentation/observation)
[![Backend](https://img.shields.io/badge/Backend-Supabase-3ECF8E.svg)](https://supabase.com/)

GarageManager_Swift là ứng dụng di động quản lý vận hành xưởng dịch vụ và gara ô tô, được phát triển theo chuẩn iOS Human Interface Guidelines (HIG). Ứng dụng ứng dụng kiến trúc MVVM kết hợp Apple Observation framework (`@Observable`), kết nối trực tiếp với cơ sở dữ liệu Supabase PostgreSQL.

---

## Mục lục

- [Tính năng hệ thống](#tính-năng-hệ-thống)
- [Kiến trúc & Công nghệ](#kiến-trúc--công-nghệ)
- [Cấu trúc mã nguồn](#cấu-trúc-mã-nguồn)
- [Quy chuẩn mã nguồn (Clean Code)](#quy-chuẩn-mã-nguồn-clean-code)
- [Mô hình dữ liệu (Database Schema)](#mô-hình-dữ-liệu-database-schema)
- [Hướng dẫn cài đặt & Chạy ứng dụng](#hướng-dẫn-cài-đặt--chạy-ứng-dụng)
- [Tác giả & Bản quyền](#tác-giả--bản-quyền)

---

## Tính năng hệ thống

### 1. Tổng quan & Trạng thái cầu nâng (Dashboard)
- **Chỉ số vận hành ngày**: Theo dõi doanh thu theo thời gian thực, số lượng xe đang sửa chữa, xe đã bàn giao và lịch hẹn chờ tiếp nhận.
- **Giám sát khoang cầu nâng**: Trực quan hóa 4 khoang nâng (cầu 2 trụ, 4 trụ, cắt kéo) kèm biển số xe, dòng xe, kỹ thuật viên phụ trách và công việc đang thực hiện.
- **Lối tắt nhanh (Quick Actions)**: Chuyển hướng trực tiếp tới các phân hệ nghiệp vụ.

### 2. Quản lý lịch hẹn & Tiếp nhận (Appointments)
- Tiếp nhận thông tin khách hàng, số điện thoại, biển số, dòng xe và nội dung yêu cầu.
- Lọc theo trạng thái: *Chờ xác nhận, Đã xác nhận, Đang xử lý, Hoàn thành, Đã hủy*.
- Điều phối khoang nâng và gán kỹ thuật viên phụ trách.

### 3. Lệnh sửa chữa & Hóa đơn (Work Orders & Invoices)
- Khởi tạo và quản lý lệnh sửa chữa theo mã định danh chuẩn (`WO-xxxx`).
- Phân tích chi phí minh bạch: Tiền công kỹ thuật viên + Tiền linh kiện/phụ tùng - Chiết khấu.
- Theo dõi vòng đời sửa chữa từ tiếp nhận, chẩn đoán, chờ vật tư đến hoàn tất thanh toán.

### 4. Quản lý thiết bị & Dụng cụ (Tool Management)
- Thống kê 4 nhóm KPI: Tổng số, Sẵn sàng, Báo hỏng, Đang sử dụng.
- Quản lý vị trí lưu trữ (tủ đồ nghề, kệ thiết bị) và đơn giá tài sản.
- Tích hợp phiếu báo hỏng thiết bị trực tiếp từ xưởng (`DamageReportSheet`).

### 5. Quản lý kho phụ tùng (Inventory)
- Quản lý vật tư tiêu hao, dầu nhớt, linh kiện thay thế theo mã SKU và vị trí kệ kho.
- Cảnh báo tự động khi số lượng tồn chạm ngưỡng an toàn (`minStockAlert`).

### 6. Quản trị nhân sự thợ máy (Technicians)
- Hồ sơ kỹ thuật viên: tay nghề, chuyên môn (Máy, Gầm, Điện động cơ, Điều hòa), thông tin liên hệ.
- Theo dõi trạng thái ca làm việc (*Sẵn sàng, Đang bận, Nghỉ ca*), đánh giá sao và số xe đang tiếp nhận.

### 7. Sổ quỹ & Chi phí vận hành (Expenses)
- Phân loại chi phí cố định (mặt bằng, bảo trì định kỳ) và chi phí biến đổi (điện 3 pha, nước xưởng, vật tư phụ).
- Tổng hợp chi phí theo chu kỳ tháng.

### 8. Bảng giá dịch vụ tiêu chuẩn (Service Price List)
- Danh mục công thợ cho từng hạng mục và các gói bảo dưỡng Combo theo cấp km (10.000km, 40.000km...).

---

## Kiến trúc & Công nghệ

| Lớp kiến trúc | Công nghệ / Thư viện | Mô tả |
|---------------|----------------------|-------|
| **UI Framework** | SwiftUI (iOS 17+) | Khai báo giao diện Declarative, thích ứng đa kích thước màn hình |
| **Architecture** | MVVM | Tách biệt rành mạch giữa Presentation, Business Logic và Data Layer |
| **State Management** | Apple `Observation` (`@Observable`) | Tối ưu hóa render SwiftUI, giảm thiểu redraw không cần thiết |
| **Navigation** | NavigationStack & AppNavigationState | Điều phối tab và luồng điều hướng tập trung |
| **Backend & DB** | Supabase (PostgreSQL 15+) | Client SDK chính thức (`supabase-swift`), hỗ trợ async/await |
| **Project Sync** | PBXFileSystemSynchronizedRootGroup | Tự động đồng bộ cấu trúc thư mục trên Xcode 16 |

---

## Cấu trúc mã nguồn

```text
GarageManager_Swift/
├── App/
│   ├── GarageManager_SwiftApp.swift       // Điểm khởi động ứng dụng (@main)
│   ├── MainTabView.swift                  // Điều hướng 5 tab chuẩn iOS HIG
│   └── AppNavigationState.swift           // Điều phối luồng điều hướng toàn cục
│
├── Models/                                // Entity Codable ánh xạ Supabase Schema
│   ├── Tool.swift                         // Dụng cụ, đồ nghề (bảng tools)
│   ├── Appointment.swift                  // Lịch hẹn tiếp nhận xe (bảng appointments)
│   ├── WorkOrder.swift                    // Lệnh sửa chữa & hóa đơn (bảng invoices)
│   ├── Product.swift                      // Vật tư, phụ tùng (bảng products)
│   ├── Technician.swift                   // Nhân sự kỹ thuật viên (bảng staff)
│   └── Expense.swift                      // Chi phí vận hành (bảng fixed_expenses)
│
├── ViewModels/                            // Tầng nghiệp vụ xử lý logic (@Observable)
│   ├── DashboardViewModel.swift           // Doanh thu ngày, trạng thái 4 khoang nâng
│   ├── ToolViewModel.swift                // Kiểm kê dụng cụ, báo hỏng, đề xuất mua
│   ├── AppointmentViewModel.swift         // Tiếp nhận đặt hẹn, lọc trạng thái, gán thợ
│   └── InvoiceViewModel.swift             // Tính tiền công, phụ tùng, hóa đơn
│
├── Views/                                 // Giao diện người dùng theo module
│   ├── Dashboard/
│   │   ├── DashboardView.swift            // Màn hình trang chủ tổng quan
│   │   ├── QuickActionGrid.swift          // Lưới lối tắt 8 module
│   │   └── LiftBayStatusView.swift        // Card trạng thái khoang cầu nâng
│   │
│   ├── Appointments/
│   │   ├── AppointmentListView.swift      // Danh sách lịch hẹn xe
│   │   └── AppointmentCardView.swift      // Card chi tiết lịch hẹn
│   │
│   ├── Invoices/
│   │   ├── InvoiceListView.swift          // Danh sách hóa đơn & lệnh SC
│   │   └── InvoiceDetailView.swift        // Chi tiết bóc tách chi phí
│   │
│   ├── Tools/
│   │   ├── ToolListView.swift             // Danh sách đồ nghề + 4 thẻ KPI
│   │   ├── ToolCardView.swift             // Card hiển thị từng dụng cụ
│   │   └── DamageReportSheet.swift        // Sheet báo hỏng thiết bị
│   │
│   ├── Inventory/
│   │   └── ProductListView.swift          // Kho phụ tùng & cảnh báo tồn
│   │
│   └── More/
│       ├── MoreHubView.swift              // Menu quản trị tổng hợp
│       ├── ServiceListView.swift          // Bảng giá dịch vụ & gói combo
│       ├── TechnicianListView.swift       // Danh sách đội ngũ thợ máy
│       └── ExpenseListView.swift          // Báo cáo chi phí & sổ quỹ
│
├── Services/
│   └── SupabaseManager.swift              // Supabase Client Singleton kết nối backend
│
└── Components/                            // Thành phần UI tái sử dụng & Extensions
    ├── AppHeaderView.swift                // Thanh điều hướng tùy biến chuẩn hóa
    ├── MetricCard.swift                   // Thẻ chỉ số KPI
    ├── StatusBadge.swift                  // Badge trạng thái tự động màu
    └── Extensions/
        ├── Color+Theme.swift              // Bảng màu nhận diện thương hiệu
        └── Number+Extensions.swift        // Định dạng tiền tệ VNĐ chuẩn hóa
```

---

## Quy chuẩn mã nguồn (Clean Code)

Dự án tuân thủ nghiêm ngặt các nguyên tắc thiết kế phần mềm sạch:

- **DRY (Don't Repeat Yourself)**: Chuẩn hóa toàn bộ navigation header thông qua component `AppHeaderView`, loại bỏ hoàn toàn mã giao diện trùng lặp trên các màn hình con.
- **Single Source of Truth (SSOT)**: Định nghĩa màu sắc và nhãn hiển thị của trạng thái (`title`, `color`) trực tiếp trong enum của Model (`ToolStatus`, `AppointmentStatus`, `WorkOrderStatus`, `TechnicianStatus`).
- **Semantic Theming**: Loại bỏ mã màu RGB viết cứng trong View; tập trung quản lý qua extension `Color.brandNavy` và `Color.brandPrimary`.
- **Định dạng dữ liệu tập trung**: Định dạng tiền tệ VNĐ được quản lý qua extension `Double.formattedVND` sử dụng `NumberFormatter` với phân tách hàng nghìn tự động.
- **Quản lý bộ nhớ & Concurrency**: Sử dụng cấu trúc `async/await` và `@MainActor` đảm bảo tính an toàn luồng khi cập nhật trạng thái UI.

---

## Mô hình dữ liệu (Database Schema)

| Tên bảng (Supabase) | Model tương ứng (Swift) | Mô tả nghiệp vụ |
|---------------------|-------------------------|-----------------|
| `tools` | `Tool.swift` | Dụng cụ xưởng, số lượng tổng, khả dụng, hỏng hóc |
| `appointments` | `Appointment.swift` | Lịch hẹn khách hàng, biển số xe, khoang nâng gán |
| `invoices` | `WorkOrder.swift` | Lệnh sửa chữa, chi phí công thợ, vật tư linh kiện |
| `products` | `Product.swift` | Danh mục phụ tùng, đơn giá, ngưỡng tồn kho tối thiểu |
| `staff` | `Technician.swift` | Đội ngũ kỹ thuật viên, chuyên môn, đánh giá năng suất |
| `fixed_expenses` | `Expense.swift` | Sổ quỹ chi phí định kỳ và phát sinh của xưởng |

---

## Hướng dẫn cài đặt & Chạy ứng dụng

### Yêu cầu hệ thống
- macOS Sonoma 14.0 trở lên
- Xcode 15.0+ hoặc Xcode 16.0+
- iOS 17.0+ Simulator hoặc thiết bị vật lý

### Các bước cài đặt
1. **Clone repository**:
   ```bash
   git clone https://github.com/ThanhhDaoo/GarageManager_Swift.git
   cd GarageManager_Swift
   ```

2. **Mở dự án trong Xcode**:
   ```bash
   open GarageManager_Swift.xcodeproj
   ```

3. **Cài đặt thư viện phụ thuộc**:
   Xcode sẽ tự động phân giải các package SPM:
   - `supabase-swift` (v2.x)

4. **Cấu hình kết nối Supabase**:
   Mở tệp `GarageManager_Swift/Services/SupabaseManager.swift` và cập nhật thông số kết nối của bạn:
   ```swift
   private let supabaseURL = URL(string: "https://<your-project-id>.supabase.co")!
   private let supabaseAnonKey = "<your-anon-key>"
   ```

5. **Khởi chạy ứng dụng**:
   Chọn scheme `GarageManager_Swift`, chọn thiết bị mục tiêu (ví dụ: *iPhone 16 Pro* hoặc *iPhone 17*) và nhấn **Run** (`⌘ + R`).

---

## Tác giả & Bản quyền

- **Tác giả**: Trần Thanh Đạo ([@ThanhhDaoo](https://github.com/ThanhhDaoo))
- **Giấy phép**: Phân phối và sử dụng nội bộ (All rights reserved).

import SwiftUI

public struct DashboardView: View {
    @State private var viewModel = DashboardViewModel()
    
    public init() {}
    
    private let kpiColumns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    public var body: some View {
        NavigationStack {
            VStack (spacing: 0){
                HStack (alignment: .center, spacing: 12){
                    Text("AD")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 44, height: 44)
                        .background(Color(red: 10/255, green: 25/255, blue: 255)) // Màu xanh đậm
                        .cornerRadius(12)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("MTPro Auto ")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color(red: 10/255, green: 25/255, blue: 50/255))
                                        
                         HStack(spacing: 4) {
                            // Chấm xanh trạng thái đang mở cửa
                            Circle()
                                .fill(Color.green)
                                .frame(width: 8, height: 8)
                            Text("Đang mở cửa • Ca sáng")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.green)
                        }
                    }
                    Spacer()
                    Button(action: {
                        print("Bấm nút thông báo")
                    }) {
                        Image(systemName: "bell.fill")
                            .font(.system(size: 16))
                            .foregroundColor(.orange) // Màu chuông vàng/cam
                            .frame(width: 40, height: 40)
                            .background(Color(.systemGray6)) // Nền xám nhạt tròn
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 12)
                // Lấy khoảng trống tự động phía trên để tránh đè vào Dynamic Island/Pin/Sóng
                .background(Color.white) // Màu nền của thanh header
                // Đường kẻ mờ phân cách ở dưới cùng header (giống vệt xám mờ trong ảnh)
                Divider()

            }
            ScrollView {
                VStack(spacing: 16) {
                    // Header KPI Cards
                    LazyVGrid(columns: kpiColumns, spacing: 12) {
                        MetricCard(
                            title: "Doanh thu hôm nay",
                            value: String(format: "%.0f đ", viewModel.todayRevenue),
                            icon: "banknote.fill",
                            color: .green,
                            subtitle: "+12% so với hôm qua"
                        )
                        
                        MetricCard(
                            title: "Xe đang sửa chữa",
                            value: "\(viewModel.activeVehiclesCount) xe",
                            icon: "wrench.and.screwdriver.fill",
                            color: .blue,
                            subtitle: "Chiếm 3/4 khoang nâng"
                        )
                        
                        MetricCard(
                            title: "Đã hoàn thành",
                            value: "\(viewModel.completedTodayCount) xe",
                            icon: "checkmark.seal.fill",
                            color: .indigo,
                            subtitle: "Đã bàn giao khách"
                        )
                        
                        MetricCard(
                            title: "Lịch hẹn chờ duyệt",
                            value: "\(viewModel.pendingAppointmentsCount) lịch",
                            icon: "calendar.badge.clock",
                            color: .orange,
                            subtitle: "Trong ngày hôm nay"
                        )
                    }
                    
                    // 8 Quick Actions
                    QuickActionGrid { tag in
                        // Xử lý chuyển tab hoặc mở modal tương ứng
                    }
                    
                    // Khoang cầu nâng (Lift Bays)
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Trạng thái khoang cầu nâng")
                                .font(.headline)
                            Spacer()
                            Text("4 Khoang")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        ForEach(viewModel.liftBays) { bay in
                            LiftBayStatusView(bay: bay)
                        }
                    }
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .refreshable {
                await viewModel.fetchDashboardData()
            }
        }
    }
}

#Preview {
    DashboardView()
}


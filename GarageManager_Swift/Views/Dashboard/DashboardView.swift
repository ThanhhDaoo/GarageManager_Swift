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
            .navigationTitle("Garage Manager")
            .refreshable {
                await viewModel.fetchDashboardData()
            }
        }
    }
}

#Preview {
    DashboardView()
}


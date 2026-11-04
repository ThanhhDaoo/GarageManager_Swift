import SwiftUI

public struct DashboardView: View {
    @Environment(AppNavigationState.self) private var navigationState: AppNavigationState?
    @State private var viewModel = DashboardViewModel()
    
    public init() {}
    
    private let kpiColumns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    public var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Header thương hiệu của Garage
                HStack(alignment: .center, spacing: 12) {
                    Text("AD")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 44, height: 44)
                        .background(Color.brandPrimary)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("MTPro Auto")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(Color.brandNavy)
                                        
                        HStack(spacing: 4) {
                            Circle()
                                .fill(Color.green)
                                .frame(width: 8, height: 8)
                            Text("Đang mở cửa • Ca sáng")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(.green)
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        // Mở danh sách thông báo
                    } label: {
                        Image(systemName: "bell.fill")
                            .font(.system(size: 16))
                            .foregroundStyle(.orange)
                            .frame(width: 40, height: 40)
                            .background(Color(.systemGray6))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 12)
                .background(Color(.secondarySystemGroupedBackground))
                
                Divider()
            }
            
            ScrollView {
                VStack(spacing: 16) {
                    // Header KPI Cards
                    LazyVGrid(columns: kpiColumns, spacing: 12) {
                        MetricCard(
                            title: "Doanh thu hôm nay",
                            value: viewModel.todayRevenue.formattedVND,
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
                        switch tag {
                        case "appointments":
                            navigationState?.selectedTab = .appointments
                        case "invoices":
                            navigationState?.selectedTab = .invoices
                        case "tools":
                            navigationState?.selectedTab = .tools
                        case "products", "services", "technicians", "expenses", "reports":
                            navigationState?.selectedTab = .more
                        default:
                            break
                        }
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
            .toolbar(.hidden, for: .navigationBar)
            .refreshable {
                await viewModel.fetchDashboardData()
            }
        }
    }
}

#Preview {
    DashboardView()
        .environment(AppNavigationState())
}

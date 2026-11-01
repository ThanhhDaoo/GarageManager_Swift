import SwiftUI

public struct MainTabView: View {
    @State private var selectedTab: TabItem = .dashboard
    
    public enum TabItem: Int, Hashable {
        case dashboard = 0
        case appointments = 1
        case invoices = 2
        case tools = 3
        case more = 4
    }
    
    public init() {}
    
    public var body: some View {
        TabView(selection: $selectedTab) {
            DashboardView()
                .tabItem {
                    Label("Tổng quan", systemImage: "gauge.with.dots.needle.bottom.50percent")
                }
                .tag(TabItem.dashboard)
            
            AppointmentListView()
                .tabItem {
                    Label("Lịch hẹn", systemImage: "calendar.badge.clock")
                }
                .tag(TabItem.appointments)
            
            InvoiceListView()
                .tabItem {
                    Label("Hoá đơn", systemImage: "receipt.fill")
                }
                .tag(TabItem.invoices)
            
            ToolListView()
                .tabItem {
                    Label("Đồ nghề", systemImage: "hammer.fill")
                }
                .tag(TabItem.tools)
            
            MoreHubView()
                .tabItem {
                    Label("Quản trị", systemImage: "ellipsis.circle.fill")
                }
                .tag(TabItem.more)
        }
        .tint(.blue)
    }
}

#Preview {
    MainTabView()
}


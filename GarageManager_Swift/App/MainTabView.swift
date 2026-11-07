import SwiftUI

public struct MainTabView: View {
    @Environment(AppNavigationState.self) private var environmentNavState: AppNavigationState?
    @State private var localNavState = AppNavigationState(isAuthenticated: true)
    
    private var navigationState: AppNavigationState {
        environmentNavState ?? localNavState
    }
    
    public enum TabItem: Int, Hashable, CaseIterable {
        case dashboard = 0
        case appointments = 1
        case invoices = 2
        case tools = 3
        case more = 4
    }
    
    public init() {}
    
    public var body: some View {
        @Bindable var state = navigationState
        TabView(selection: $state.selectedTab) {
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
        .environment(AppNavigationState(isAuthenticated: true))
}

import SwiftUI
import Observation

/// Quản lý điều hướng toàn cục của ứng dụng (chuyển tab, điều hướng nhanh từ Dashboard)
@Observable
public final class AppNavigationState {
    public var selectedTab: MainTabView.TabItem = .dashboard
    
    public init() {}
    
    public func navigateToHome() {
        selectedTab = .dashboard
    }
}


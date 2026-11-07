import SwiftUI
import Observation

/// Quản lý điều hướng toàn cục và trạng thái phiên đăng nhập của ứng dụng
@Observable
public final class AppNavigationState {
    public var selectedTab: MainTabView.TabItem = .dashboard
    public var isAuthenticated: Bool = false
    
    public init(isAuthenticated: Bool = false) {
        self.isAuthenticated = isAuthenticated
    }
    
    public func navigateToHome() {
        selectedTab = .dashboard
    }
    
    public func signOut() {
        isAuthenticated = false
        selectedTab = .dashboard
    }
}

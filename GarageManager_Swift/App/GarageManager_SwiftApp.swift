import SwiftUI

@main
struct GarageManager_SwiftApp: App {
    @State private var navigationState = AppNavigationState()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if navigationState.isAuthenticated {
                    MainTabView()
                } else {
                    LoginView()
                }
            }
            .environment(navigationState)
            .animation(.easeInOut(duration: 0.3), value: navigationState.isAuthenticated)
        }
    }
}

#Preview("Login") {
    LoginView()
        .environment(AppNavigationState())
}

#Preview("Main Tab") {
    MainTabView()
        .environment(AppNavigationState(isAuthenticated: true))
}

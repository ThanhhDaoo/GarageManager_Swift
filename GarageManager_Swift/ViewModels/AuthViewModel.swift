import Foundation
import Observation
import Supabase

@Observable
public final class AuthViewModel {
    public var email: String = ""
    public var password: String = ""
    public var isLoading: Bool = false
    public var errorMessage: String?
    public var isPasswordVisible: Bool = false
    public var rememberMe: Bool = true
    
    public init() {}
    
    /// Kiểm tra tính hợp lệ sơ bộ của form
    public var isFormValid: Bool {
        !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        password.count >= 6
    }
    
    /// Tự động điền tài khoản quản trị mẫu để trải nghiệm nhanh
    public func fillDemoCredentials() {
        self.email = "admin@mtpro.vn"
        self.password = "123456"
        self.errorMessage = nil
    }
    
    /// Xử lý đăng nhập qua Supabase Auth (có fallback cho tài khoản demo)
    @MainActor
    public func signIn() async -> Bool {
        guard isFormValid else {
            errorMessage = "Vui lòng nhập email hợp lệ và mật khẩu từ 6 ký tự trở lên."
            return false
        }
        
        isLoading = true
        errorMessage = nil
        
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        // 1. Cho phép tài khoản demo nội bộ đăng nhập nhanh không cần mạng
        if (trimmedEmail == "admin@mtpro.vn" || trimmedEmail == "demo@garage.vn") && password == "123456" {
            try? await Task.sleep(nanoseconds: 600_000_000)
            isLoading = false
            return true
        }
        
        // 2. Gọi Supabase Auth API
        do {
            _ = try await SupabaseManager.shared.client.auth.signIn(
                email: trimmedEmail,
                password: password
            )
            isLoading = false
            return true
        } catch {
            isLoading = false
            errorMessage = error.localizedDescription
            return false
        }
    }
    
    /// Đăng xuất khỏi hệ thống
    @MainActor
    public func signOut() async {
        try? await SupabaseManager.shared.client.auth.signOut()
    }
}

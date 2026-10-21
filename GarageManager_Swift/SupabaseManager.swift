import Foundation
import Supabase

final class SupabaseManager {
    // Biến dùng chung (Singleton) trong toàn bộ ứng dụng
    static let shared = SupabaseManager()
    
    // URL dự án của bạn (đã bỏ phần /rest/v1/)
    private let supabaseURL = URL(string: "https://zubobalqonmzfeonmpgp.supabase.co")!
    
    // Chuỗi anon public key bạn đã copy từ Dashboard Supabase
    private let supabaseAnonKey = "sb_publishable_CA2VfIASXvFJylKrIzX4Kw_ozG09eTd"
    
    // Đối tượng client chính thức để gọi database sau này
    let client: SupabaseClient
    
    private init() {
        self.client = SupabaseClient(
            supabaseURL: supabaseURL,
            supabaseKey: supabaseAnonKey
        )
    }
}

import Foundation
import Observation

@Observable
public final class ToolViewModel {
    public var tools: [Tool] = []
    public var isLoading: Bool = false
    public var errorMessage: String?
    public var selectedCategory: String = "Tất cả"
    
    public var totalCount: Int {
        tools.reduce(0) { $0 + $1.totalQuantity }
    }
    
    public var availableCount: Int {
        tools.reduce(0) { $0 + $1.availableQuantity }
    }
    
    public var brokenCount: Int {
        tools.reduce(0) { $0 + $1.brokenQuantity }
    }
    
    public var inUseCount: Int {
        tools.filter { $0.status == .inUse }.count
    }
    
    public init() {
        self.tools = [
            Tool(name: "Súng siết bu-lông khí nén 1/2 inch", code: "TL-001", category: "Dụng cụ khí nén", status: .available, totalQuantity: 4, availableQuantity: 3, brokenQuantity: 1, unitPrice: 3_200_000, location: "Tủ đồ nghề A1"),
            Tool(name: "Bộ cờ lê tròng tự động 8-24mm", code: "TL-002", category: "Dụng cụ cầm tay", status: .available, totalQuantity: 6, availableQuantity: 6, brokenQuantity: 0, unitPrice: 1_850_000, location: "Kệ treo B2"),
            Tool(name: "Máy chẩn đoán lỗi OBD2 Autel", code: "TL-003", category: "Thiết bị điện tử", status: .inUse, totalQuantity: 2, availableQuantity: 1, brokenQuantity: 0, unitPrice: 18_500_000, location: "Bàn kỹ thuật chính"),
            Tool(name: "Đồng hồ đo áp suất lốp điện tử", code: "TL-004", category: "Dụng cụ đo kiểm", status: .damaged, totalQuantity: 3, availableQuantity: 1, brokenQuantity: 2, unitPrice: 650_000, location: "Khoang tiếp nhận"),
            Tool(name: "Kích thủy lực cá sấu 3 tấn", code: "TL-005", category: "Thiết bị nâng hạ", status: .available, totalQuantity: 4, availableQuantity: 4, brokenQuantity: 0, unitPrice: 4_500_000, location: "Khu vực khoang 1-4")
        ]
    }
    
    @MainActor
    public func fetchTools() async {
        isLoading = true
        errorMessage = nil
        do {
            try await Task.sleep(nanoseconds: 400_000_000)
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
    
    @MainActor
    public func reportDamage(for tool: Tool, brokenCount: Int, reason: String) async {
        if let index = tools.firstIndex(where: { $0.id == tool.id }) {
            tools[index].brokenQuantity += brokenCount
            tools[index].availableQuantity = max(0, tools[index].availableQuantity - brokenCount)
            if tools[index].availableQuantity == 0 {
                tools[index].status = .damaged
            }
        }
    }
    
    @MainActor
    public func requestPurchase(toolName: String, quantity: Int, estimatedPrice: Double?) async {
        // Gửi đề xuất mua sắm vào Supabase
    }
}


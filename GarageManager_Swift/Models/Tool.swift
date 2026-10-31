import Foundation

public enum ToolStatus: String, Codable, CaseIterable, Sendable {
    case available = "available"
    case inUse = "in_use"
    case damaged = "damaged"
    case maintenance = "maintenance"
    
    public var title: String {
        switch self {
        case .available: return "Sẵn sàng"
        case .inUse: return "Đang dùng"
        case .damaged: return "Báo hỏng"
        case .maintenance: return "Bảo trì"
        }
    }
}

public struct Tool: Identifiable, Codable, Hashable, Sendable {
    public let id: UUID
    public var name: String
    public var code: String
    public var category: String
    public var status: ToolStatus
    public var totalQuantity: Int
    public var availableQuantity: Int
    public var brokenQuantity: Int
    public var unitPrice: Double?
    public var location: String?
    public var notes: String?
    public var createdAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case code
        case category
        case status
        case totalQuantity = "total_quantity"
        case availableQuantity = "available_quantity"
        case brokenQuantity = "broken_quantity"
        case unitPrice = "unit_price"
        case location
        case notes
        case createdAt = "created_at"
    }
    
    public init(
        id: UUID = UUID(),
        name: String,
        code: String,
        category: String,
        status: ToolStatus = .available,
        totalQuantity: Int = 1,
        availableQuantity: Int = 1,
        brokenQuantity: Int = 0,
        unitPrice: Double? = nil,
        location: String? = nil,
        notes: String? = nil,
        createdAt: Date? = Date()
    ) {
        self.id = id
        self.name = name
        self.code = code
        self.category = category
        self.status = status
        self.totalQuantity = totalQuantity
        self.availableQuantity = availableQuantity
        self.brokenQuantity = brokenQuantity
        self.unitPrice = unitPrice
        self.location = location
        self.notes = notes
        self.createdAt = createdAt
    }
}


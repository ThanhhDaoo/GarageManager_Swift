import Foundation

public struct Product: Identifiable, Codable, Hashable, Sendable {
    public let id: UUID
    public var name: String
    public var sku: String
    public var category: String
    public var unit: String
    public var unitPrice: Double
    public var stockQuantity: Int
    public var minStockAlert: Int
    public var location: String?
    public var supplier: String?
    public var createdAt: Date?
    
    public var isLowStock: Bool {
        stockQuantity <= minStockAlert
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case sku
        case category
        case unit
        case unitPrice = "unit_price"
        case stockQuantity = "stock_quantity"
        case minStockAlert = "min_stock_alert"
        case location
        case supplier
        case createdAt = "created_at"
    }
    
    public init(
        id: UUID = UUID(),
        name: String,
        sku: String,
        category: String,
        unit: String,
        unitPrice: Double,
        stockQuantity: Int,
        minStockAlert: Int = 5,
        location: String? = nil,
        supplier: String? = nil,
        createdAt: Date? = Date()
    ) {
        self.id = id
        self.name = name
        self.sku = sku
        self.category = category
        self.unit = unit
        self.unitPrice = unitPrice
        self.stockQuantity = stockQuantity
        self.minStockAlert = minStockAlert
        self.location = location
        self.supplier = supplier
        self.createdAt = createdAt
    }
}


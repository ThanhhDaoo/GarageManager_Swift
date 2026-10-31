import Foundation

public struct Expense: Identifiable, Codable, Hashable, Sendable {
    public let id: UUID
    public var title: String
    public var category: String
    public var amount: Double
    public var expenseDate: Date
    public var isRecurring: Bool
    public var notes: String?
    public var createdAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case category
        case amount
        case expenseDate = "expense_date"
        case isRecurring = "is_recurring"
        case notes
        case createdAt = "created_at"
    }
    
    public init(
        id: UUID = UUID(),
        title: String,
        category: String,
        amount: Double,
        expenseDate: Date = Date(),
        isRecurring: Bool = false,
        notes: String? = nil,
        createdAt: Date? = Date()
    ) {
        self.id = id
        self.title = title
        self.category = category
        self.amount = amount
        self.expenseDate = expenseDate
        self.isRecurring = isRecurring
        self.notes = notes
        self.createdAt = createdAt
    }
}


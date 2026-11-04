import Foundation
import SwiftUI

public enum WorkOrderStatus: String, Codable, CaseIterable, Sendable {
    case received = "received"
    case diagnosing = "diagnosing"
    case repairing = "repairing"
    case waitingParts = "waiting_parts"
    case completed = "completed"
    case paid = "paid"
    
    public var title: String {
        switch self {
        case .received: return "Tiếp nhận"
        case .diagnosing: return "Chẩn đoán"
        case .repairing: return "Đang sửa"
        case .waitingParts: return "Chờ phụ tùng"
        case .completed: return "Đã xong"
        case .paid: return "Đã thanh toán"
        }
    }
    
    public var color: Color {
        switch self {
        case .received: return .blue
        case .diagnosing: return .purple
        case .repairing: return .orange
        case .waitingParts: return .red
        case .completed: return .teal
        case .paid: return .green
        }
    }
}

public struct WorkOrder: Identifiable, Codable, Hashable, Sendable {
    public let id: UUID
    public var code: String
    public var customerName: String
    public var phoneNumber: String
    public var licensePlate: String
    public var vehicleModel: String
    public var status: WorkOrderStatus
    public var technicianName: String?
    public var liftBay: Int?
    public var laborCost: Double
    public var partsCost: Double
    public var discount: Double
    public var notes: String?
    public var createdAt: Date?
    
    public var totalAmount: Double {
        max(0, (laborCost + partsCost) - discount)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case code
        case customerName = "customer_name"
        case phoneNumber = "phone_number"
        case licensePlate = "license_plate"
        case vehicleModel = "vehicle_model"
        case status
        case technicianName = "technician_name"
        case liftBay = "lift_bay"
        case laborCost = "labor_cost"
        case partsCost = "parts_cost"
        case discount
        case notes
        case createdAt = "created_at"
    }
    
    public init(
        id: UUID = UUID(),
        code: String,
        customerName: String,
        phoneNumber: String,
        licensePlate: String,
        vehicleModel: String,
        status: WorkOrderStatus = .received,
        technicianName: String? = nil,
        liftBay: Int? = nil,
        laborCost: Double = 0,
        partsCost: Double = 0,
        discount: Double = 0,
        notes: String? = nil,
        createdAt: Date? = Date()
    ) {
        self.id = id
        self.code = code
        self.customerName = customerName
        self.phoneNumber = phoneNumber
        self.licensePlate = licensePlate
        self.vehicleModel = vehicleModel
        self.status = status
        self.technicianName = technicianName
        self.liftBay = liftBay
        self.laborCost = laborCost
        self.partsCost = partsCost
        self.discount = discount
        self.notes = notes
        self.createdAt = createdAt
    }
}

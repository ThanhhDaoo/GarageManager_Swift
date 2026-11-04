import Foundation
import SwiftUI

public enum TechnicianStatus: String, Codable, CaseIterable, Sendable {
    case available = "available"
    case busy = "busy"
    case offDuty = "off_duty"
    
    public var title: String {
        switch self {
        case .available: return "Sẵn sàng"
        case .busy: return "Đang bận"
        case .offDuty: return "Nghỉ ca"
        }
    }
    
    public var color: Color {
        switch self {
        case .available: return .green
        case .busy: return .orange
        case .offDuty: return .gray
        }
    }
}

public struct Technician: Identifiable, Codable, Hashable, Sendable {
    public let id: UUID
    public var fullName: String
    public var phone: String
    public var role: String
    public var specialty: String
    public var status: TechnicianStatus
    public var activeOrdersCount: Int
    public var rating: Double
    public var createdAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case phone
        case role
        case specialty
        case status
        case activeOrdersCount = "active_orders_count"
        case rating
        case createdAt = "created_at"
    }
    
    public init(
        id: UUID = UUID(),
        fullName: String,
        phone: String,
        role: String = "Kỹ thuật viên",
        specialty: String,
        status: TechnicianStatus = .available,
        activeOrdersCount: Int = 0,
        rating: Double = 5.0,
        createdAt: Date? = Date()
    ) {
        self.id = id
        self.fullName = fullName
        self.phone = phone
        self.role = role
        self.specialty = specialty
        self.status = status
        self.activeOrdersCount = activeOrdersCount
        self.rating = rating
        self.createdAt = createdAt
    }
}

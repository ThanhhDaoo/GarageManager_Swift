import Foundation

public enum AppointmentStatus: String, Codable, CaseIterable, Sendable {
    case pending = "pending"
    case confirmed = "confirmed"
    case inProgress = "in_progress"
    case completed = "completed"
    case cancelled = "cancelled"
    
    public var title: String {
        switch self {
        case .pending: return "Chờ xác nhận"
        case .confirmed: return "Đã xác nhận"
        case .inProgress: return "Đang xử lý"
        case .completed: return "Hoàn thành"
        case .cancelled: return "Đã hủy"
        }
    }
}

public struct Appointment: Identifiable, Codable, Hashable, Sendable {
    public let id: UUID
    public var customerName: String
    public var phoneNumber: String
    public var licensePlate: String
    public var vehicleModel: String
    public var serviceDescription: String
    public var appointmentDate: Date
    public var status: AppointmentStatus
    public var technicianId: UUID?
    public var technicianName: String?
    public var liftBay: Int?
    public var notes: String?
    public var createdAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case id
        case customerName = "customer_name"
        case phoneNumber = "phone_number"
        case licensePlate = "license_plate"
        case vehicleModel = "vehicle_model"
        case serviceDescription = "service_description"
        case appointmentDate = "appointment_date"
        case status
        case technicianId = "technician_id"
        case technicianName = "technician_name"
        case liftBay = "lift_bay"
        case notes
        case createdAt = "created_at"
    }
    
    public init(
        id: UUID = UUID(),
        customerName: String,
        phoneNumber: String,
        licensePlate: String,
        vehicleModel: String,
        serviceDescription: String,
        appointmentDate: Date = Date(),
        status: AppointmentStatus = .pending,
        technicianId: UUID? = nil,
        technicianName: String? = nil,
        liftBay: Int? = nil,
        notes: String? = nil,
        createdAt: Date? = Date()
    ) {
        self.id = id
        self.customerName = customerName
        self.phoneNumber = phoneNumber
        self.licensePlate = licensePlate
        self.vehicleModel = vehicleModel
        self.serviceDescription = serviceDescription
        self.appointmentDate = appointmentDate
        self.status = status
        self.technicianId = technicianId
        self.technicianName = technicianName
        self.liftBay = liftBay
        self.notes = notes
        self.createdAt = createdAt
    }
}


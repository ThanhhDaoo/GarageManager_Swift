import Foundation
import Observation

public struct LiftBayInfo: Identifiable, Hashable, Sendable {
    public let id: Int
    public var name: String
    public var isOccupied: Bool
    public var licensePlate: String?
    public var carModel: String?
    public var technicianName: String?
    public var statusDescription: String?
    
    public init(
        id: Int,
        name: String,
        isOccupied: Bool = false,
        licensePlate: String? = nil,
        carModel: String? = nil,
        technicianName: String? = nil,
        statusDescription: String? = nil
    ) {
        self.id = id
        self.name = name
        self.isOccupied = isOccupied
        self.licensePlate = licensePlate
        self.carModel = carModel
        self.technicianName = technicianName
        self.statusDescription = statusDescription
    }
}

@Observable
public final class DashboardViewModel {
    public var todayRevenue: Double = 14_500_000
    public var activeVehiclesCount: Int = 4
    public var completedTodayCount: Int = 8
    public var pendingAppointmentsCount: Int = 5
    public var liftBays: [LiftBayInfo] = []
    public var isLoading: Bool = false
    public var errorMessage: String?
    
    public init() {
        self.liftBays = [
            LiftBayInfo(id: 1, name: "Khoang 1 (Cầu 2 trụ)", isOccupied: true, licensePlate: "30H-889.12", carModel: "Mazda CX-5", technicianName: "Nguyễn Văn Tuấn", statusDescription: "Đang thay dầu máy & lọc"),
            LiftBayInfo(id: 2, name: "Khoang 2 (Cầu cắt kéo)", isOccupied: true, licensePlate: "29A-678.99", carModel: "Toyota Camry", technicianName: "Trần Văn Bình", statusDescription: "Bảo dưỡng phanh"),
            LiftBayInfo(id: 3, name: "Khoang 3 (Cầu 4 trụ)", isOccupied: false, licensePlate: nil, carModel: nil, technicianName: nil, statusDescription: "Sẵn sàng nhận xe"),
            LiftBayInfo(id: 4, name: "Khoang 4 (Cầu 2 trụ)", isOccupied: true, licensePlate: "51K-123.45", carModel: "Ford Ranger", technicianName: "Lê Hoàng Nam", statusDescription: "Thay giảm xóc trước")
        ]
    }
    
    @MainActor
    public func fetchDashboardData() async {
        isLoading = true
        errorMessage = nil
        
        // Mô phỏng tải dữ liệu hoặc kết nối SupabaseManager.shared.client
        do {
            try await Task.sleep(nanoseconds: 500_000_000)
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
}


import Foundation
import Observation

@Observable
public final class InvoiceViewModel {
    public var workOrders: [WorkOrder] = []
    public var isLoading: Bool = false
    public var errorMessage: String?
    public var selectedStatus: WorkOrderStatus?
    
    public var filteredWorkOrders: [WorkOrder] {
        if let status = selectedStatus {
            return workOrders.filter { $0.status == status }
        }
        return workOrders
    }
    
    public init() {
        self.workOrders = [
            WorkOrder(
                code: "WO-2410-001",
                customerName: "Nguyễn Văn Hùng",
                phoneNumber: "0901234567",
                licensePlate: "30G-998.22",
                vehicleModel: "Hyundai Tucson 2022",
                status: .repairing,
                technicianName: "Nguyễn Văn Tuấn",
                liftBay: 1,
                laborCost: 450_000,
                partsCost: 1_850_000,
                discount: 100_000,
                notes: "Thay 4L dầu nhớt Motul 5W30 + Lọc nhớt chính hãng"
            ),
            WorkOrder(
                code: "WO-2410-002",
                customerName: "Vũ Đình Khiêm",
                phoneNumber: "0934567890",
                licensePlate: "30F-123.45",
                vehicleModel: "Mazda 3 2020",
                status: .paid,
                technicianName: "Trần Văn Bình",
                liftBay: 2,
                laborCost: 600_000,
                partsCost: 2_400_000,
                discount: 0,
                notes: "Thay má phanh trước Brembo & láng đĩa"
            ),
            WorkOrder(
                code: "WO-2410-003",
                customerName: "Đỗ Minh Quân",
                phoneNumber: "0977889900",
                licensePlate: "29A-887.65",
                vehicleModel: "Honda CR-V 2019",
                status: .waitingParts,
                technicianName: "Lê Hoàng Nam",
                liftBay: 4,
                laborCost: 800_000,
                partsCost: 4_200_000,
                discount: 200_000,
                notes: "Đặt rô-tuyn cân bằng và cao su chân máy"
            )
        ]
    }
    
    @MainActor
    public func fetchWorkOrders() async {
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
    
    public func calculateTotal(laborCost: Double, partsCost: Double, discount: Double) -> Double {
        max(0, (laborCost + partsCost) - discount)
    }
    
    @MainActor
    public func updateStatus(orderId: UUID, to status: WorkOrderStatus) {
        if let index = workOrders.firstIndex(where: { $0.id == orderId }) {
            workOrders[index].status = status
        }
    }
}


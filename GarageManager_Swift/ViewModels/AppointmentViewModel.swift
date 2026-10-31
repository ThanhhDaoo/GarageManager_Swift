import Foundation
import Observation

@Observable
public final class AppointmentViewModel {
    public var appointments: [Appointment] = []
    public var selectedStatus: AppointmentStatus?
    public var isLoading: Bool = false
    public var errorMessage: String?
    
    public var filteredAppointments: [Appointment] {
        if let status = selectedStatus {
            return appointments.filter { $0.status == status }
        }
        return appointments
    }
    
    public init() {
        self.appointments = [
            Appointment(
                customerName: "Nguyễn Văn Hùng",
                phoneNumber: "0901234567",
                licensePlate: "30G-998.22",
                vehicleModel: "Hyundai Tucson 2022",
                serviceDescription: "Bảo dưỡng 40.000km, thay dầu máy, kiểm tra gầm",
                appointmentDate: Date(),
                status: .inProgress,
                technicianName: "Nguyễn Văn Tuấn",
                liftBay: 1,
                notes: "Khách hẹn lấy xe trước 17h"
            ),
            Appointment(
                customerName: "Lê Thị Thảo",
                phoneNumber: "0987654321",
                licensePlate: "29E-554.11",
                vehicleModel: "Kia Seltos 2021",
                serviceDescription: "Điều hòa không mát, có tiếng kêu lạ",
                appointmentDate: Calendar.current.date(byAdding: .hour, value: 2, to: Date()) ?? Date(),
                status: .confirmed,
                technicianName: "Trần Văn Bình",
                liftBay: 2,
                notes: "Cần kiểm tra kỹ lốc lạnh"
            ),
            Appointment(
                customerName: "Phạm Quốc Dũng",
                phoneNumber: "0912348888",
                licensePlate: "51H-332.90",
                vehicleModel: "Ford Everest 2023",
                serviceDescription: "Cân chỉnh thước lái, đảo lốp xe",
                appointmentDate: Calendar.current.date(byAdding: .hour, value: 4, to: Date()) ?? Date(),
                status: .pending,
                notes: "Khách đặt hẹn qua website"
            )
        ]
    }
    
    @MainActor
    public func fetchAppointments() async {
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
    public func assignTechnician(appointmentId: UUID, technicianName: String, liftBay: Int) {
        if let index = appointments.firstIndex(where: { $0.id == appointmentId }) {
            appointments[index].technicianName = technicianName
            appointments[index].liftBay = liftBay
            appointments[index].status = .confirmed
        }
    }
    
    @MainActor
    public func addAppointment(_ appointment: Appointment) {
        appointments.insert(appointment, at: 0)
    }
}


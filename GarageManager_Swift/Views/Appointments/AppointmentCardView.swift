import SwiftUI

public struct AppointmentCardView: View {
    public let appointment: Appointment
    
    public init(appointment: Appointment) {
        self.appointment = appointment
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(appointment.licensePlate)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(Color(.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                
                Text(appointment.vehicleModel)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Spacer()
                
                StatusBadge(appointment.status.title, color: appointment.status.color)
            }
            
            Text(appointment.serviceDescription)
                .font(.footnote)
                .foregroundStyle(.primary)
                .lineLimit(2)
            
            Divider()
            
            HStack {
                Label(appointment.customerName, systemImage: "person.circle")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                Label(appointment.appointmentDate.formatted(date: .omitted, time: .shortened), systemImage: "clock")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            if let tech = appointment.technicianName {
                HStack {
                    Label("Thợ phụ trách: \(tech)", systemImage: "wrench.fill")
                        .font(.caption2)
                        .foregroundStyle(.blue)
                    
                    if let bay = appointment.liftBay {
                        Text("• Khoang \(bay)")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .padding(14)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
    }
}

#Preview {
    AppointmentCardView(
        appointment: Appointment(
            customerName: "Nguyễn Văn Hùng",
            phoneNumber: "0901234567",
            licensePlate: "30G-998.22",
            vehicleModel: "Hyundai Tucson 2022",
            serviceDescription: "Bảo dưỡng định kỳ 40.000km",
            status: .inProgress,
            technicianName: "Nguyễn Văn Tuấn",
            liftBay: 1
        )
    )
    .padding()
}

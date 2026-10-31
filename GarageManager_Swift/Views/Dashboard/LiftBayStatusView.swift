import SwiftUI

public struct LiftBayStatusView: View {
    public let bay: LiftBayInfo
    
    public init(bay: LiftBayInfo) {
        self.bay = bay
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                HStack(spacing: 6) {
                    Circle()
                        .fill(bay.isOccupied ? Color.orange : Color.green)
                        .frame(width: 8, height: 8)
                    Text(bay.name)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                
                Spacer()
                
                StatusBadge(
                    bay.isOccupied ? "Đang sửa" : "Trống",
                    color: bay.isOccupied ? .orange : .green
                )
            }
            
            if bay.isOccupied {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        if let plate = bay.licensePlate {
                            Text(plate)
                                .font(.caption)
                                .fontWeight(.bold)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color(.systemGray5))
                                .clipShape(RoundedRectangle(cornerRadius: 4))
                        }
                        
                        if let model = bay.carModel {
                            Text(model)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    if let tech = bay.technicianName {
                        Label(tech, systemImage: "person.fill")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                    
                    if let desc = bay.statusDescription {
                        Text(desc)
                            .font(.caption2)
                            .foregroundStyle(.tertiary)
                            .lineLimit(1)
                    }
                }
            } else {
                Text(bay.statusDescription ?? "Sẵn sàng nhận xe mới")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(12)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

#Preview {
    LiftBayStatusView(bay: LiftBayInfo(
        id: 1,
        name: "Khoang 1 (Cầu 2 trụ)",
        isOccupied: true,
        licensePlate: "30H-889.12",
        carModel: "Mazda CX-5",
        technicianName: "Nguyễn Văn Tuấn",
        statusDescription: "Đang thay dầu máy & lọc"
    ))
    .padding()
}


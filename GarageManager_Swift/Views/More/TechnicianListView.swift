import SwiftUI

public struct TechnicianListView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showingAddSheet = false
    @State private var technicians: [Technician] = [
        Technician(fullName: "Nguyễn Văn Tuấn", phone: "0912 345 678", role: "Thợ trưởng", specialty: "Máy - Gầm - Điện động cơ", status: .busy, activeOrdersCount: 2, rating: 4.9),
        Technician(fullName: "Trần Văn Bình", phone: "0923 456 789", role: "Kỹ thuật viên", specialty: "Điện lạnh & Điều hòa", status: .busy, activeOrdersCount: 1, rating: 4.8),
        Technician(fullName: "Lê Hoàng Nam", phone: "0934 567 890", role: "Kỹ thuật viên", specialty: "Bảo dưỡng định kỳ & Lốp", status: .available, activeOrdersCount: 0, rating: 4.7),
        Technician(fullName: "Hoàng Minh Đức", phone: "0945 678 901", role: "Học việc", specialty: "Rửa xe & Vệ sinh khoang máy", status: .offDuty, activeOrdersCount: 0, rating: 4.5)
    ]
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 0) {
            AppHeaderView(
                title: "Quản Lý Nhân Sự",
                backTitle: "Quản trị",
                backAction: {
                    dismiss()
                },
                trailingIcon: "plus.circle.fill",
                trailingAction: {
                    showingAddSheet = true
                }
            )
            
            Divider()
            
            List {
                ForEach(technicians) { tech in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text(tech.fullName)
                                    .font(.headline)
                                Text(tech.role)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            
                            Spacer()
                            
                            StatusBadge(tech.status.title, color: tech.status.color)
                        }
                        
                        HStack {
                            Label(tech.specialty, systemImage: "wrench.and.screwdriver")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        Divider()
                        
                        HStack {
                            Label(tech.phone, systemImage: "phone.fill")
                                .font(.caption2)
                                .foregroundStyle(.blue)
                            
                            Spacer()
                            
                            Label(String(format: "%.1f ★", tech.rating), systemImage: "star.fill")
                                .font(.caption2)
                                .foregroundStyle(.orange)
                            
                            Text("•")
                                .foregroundStyle(.secondary)
                            
                            Text("Đang nhận: \(tech.activeOrdersCount) xe")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        TechnicianListView()
    }
}

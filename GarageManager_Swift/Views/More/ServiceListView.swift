import SwiftUI

public struct ServiceItem: Identifiable, Sendable {
    public let id = UUID()
    public let name: String
    public let category: String
    public let estimatedDuration: String
    public let price: Double
    public let isCombo: Bool
}

public struct ServiceListView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showingAddSheet = false
    
    public init() {}
    
    private let services: [ServiceItem] = [
        ServiceItem(name: "Gói Combo Bảo Dưỡng Cấp 40.000km", category: "Gói Combo", estimatedDuration: "3 giờ", price: 2_800_000, isCombo: true),
        ServiceItem(name: "Gói Combo Chăm Sóc & Vệ Sinh Khoang Máy", category: "Gói Combo", estimatedDuration: "1.5 giờ", price: 1_200_000, isCombo: true),
        ServiceItem(name: "Thay dầu động cơ & lọc dầu", category: "Bảo dưỡng", estimatedDuration: "30 phút", price: 250_000, isCombo: false),
        ServiceItem(name: "Vệ sinh hệ thống phanh 4 bánh", category: "Phanh & Gầm", estimatedDuration: "45 phút", price: 350_000, isCombo: false),
        ServiceItem(name: "Cân chỉnh góc đặt bánh xe (thước lái)", category: "Lốp & Cân mâm", estimatedDuration: "60 phút", price: 600_000, isCombo: false),
        ServiceItem(name: "Nạp gas & bảo dưỡng điều hòa ô tô", category: "Điều hòa", estimatedDuration: "60 phút", price: 850_000, isCombo: false)
    ]
    
    public var body: some View {
        VStack(spacing: 0) {
            AppHeaderView(
                title: "Quản Lý Gói Dịch Vụ",
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
                Section("Gói dịch vụ Combo tiết kiệm") {
                    ForEach(services.filter { $0.isCombo }) { item in
                        serviceRow(item)
                    }
                }
                
                Section("Dịch vụ lẻ") {
                    ForEach(services.filter { !$0.isCombo }) { item in
                        serviceRow(item)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
    
    @ViewBuilder
    private func serviceRow(_ item: ServiceItem) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(item.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Spacer()
                Text(item.price.formattedVND)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(.blue)
            }
            
            HStack {
                Text(item.category)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                Label(item.estimatedDuration, systemImage: "clock")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        ServiceListView()
    }
}

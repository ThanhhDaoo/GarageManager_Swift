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
    public init() {}
    @State private var showingAddSheet = false
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
            HStack(alignment: .center, spacing: 8) {
                // Nút Back
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text("Trang chủ")
                    }
                    .offset(x: 10)
                    .font(.subheadline)
                    .foregroundStyle(.blue)
                }

                Spacer()
                Text("Quản Lý Gói Dịch Vụ")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color(red: 10/255, green: 25/255, blue: 50/255))
                    .lineLimit(1)
                    .offset(x: -10)
                    .minimumScaleFactor(0.8)

                Spacer()
                Button {
                    showingAddSheet = true
                    print("+")
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 30))
                        .foregroundStyle(.blue)
                        .offset(x: -10)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(.secondarySystemGroupedBackground))
            
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
                Text(String(format: "%.0f đ", item.price))
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

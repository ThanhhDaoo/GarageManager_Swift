import SwiftUI

public struct QuickActionItem: Identifiable {
    public let id = UUID()
    public let title: String
    public let icon: String
    public let color: Color
    public let actionTag: String
}

public struct QuickActionGrid: View {
    public var onSelectAction: ((String) -> Void)?
    
    private let actions: [QuickActionItem] = [
        QuickActionItem(title: "Tiếp nhận xe", icon: "car.fill", color: .blue, actionTag: "new_reception"),
        QuickActionItem(title: "Lập lệnh SC", icon: "wrench.and.screwdriver.fill", color: .indigo, actionTag: "new_order"),
        QuickActionItem(title: "Báo hỏng đồ", icon: "exclamationmark.triangle.fill", color: .red, actionTag: "report_tool"),
        QuickActionItem(title: "Kho phụ tùng", icon: "shippingbox.fill", color: .orange, actionTag: "inventory"),
        QuickActionItem(title: "Đội ngũ thợ", icon: "person.3.fill", color: .teal, actionTag: "technicians"),
        QuickActionItem(title: "Bảng giá DV", icon: "list.clipboard.fill", color: .purple, actionTag: "services"),
        QuickActionItem(title: "Ghi chi phí", icon: "tray.and.arrow.down.fill", color: .pink, actionTag: "expense"),
        QuickActionItem(title: "Báo cáo ngày", icon: "chart.bar.xaxis", color: .green, actionTag: "report")
    ]
    
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    public init(onSelectAction: ((String) -> Void)? = nil) {
        self.onSelectAction = onSelectAction
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Lối tắt nhanh")
                .font(.headline)
                .foregroundStyle(.primary)
            
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(actions) { action in
                    Button {
                        onSelectAction?(action.actionTag)
                    } label: {
                        VStack(spacing: 8) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 14, style: .continuous)
                                    .fill(action.color.opacity(0.12))
                                    .frame(height: 52)
                                
                                Image(systemName: action.icon)
                                    .font(.title3)
                                    .foregroundStyle(action.color)
                            }
                            
                            Text(action.title)
                                .font(.caption2)
                                .fontWeight(.medium)
                                .foregroundStyle(.primary)
                                .lineLimit(1)
                                .minimumScaleFactor(0.8)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding(14)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

#Preview {
    QuickActionGrid()
        .padding()
}


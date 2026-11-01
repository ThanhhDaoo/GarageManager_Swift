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
        QuickActionItem(title: "Lịch Hẹn", icon: "calendar.badge.clock", color: .blue, actionTag: "appointments"),
        QuickActionItem(title: "Hoá Đơn", icon: "receipt.fill", color: .indigo, actionTag: "invoices"),
        QuickActionItem(title: "Sản Phẩm", icon: "shippingbox.fill", color: .orange, actionTag: "products"),
        QuickActionItem(title: "Dịch Vụ", icon: "gearshape.2.fill", color: .purple, actionTag: "services"),
        QuickActionItem(title: "Dụng Cụ", icon: "wrench.and.screwdriver.fill", color: .teal, actionTag: "tools"),
        QuickActionItem(title: "Nhân Sự", icon: "person.2.fill", color: .cyan, actionTag: "technicians"),
        QuickActionItem(title: "Ghi Phí", icon: "tray.and.arrow.down.fill", color: .pink, actionTag: "expenses"),
        QuickActionItem(title: "Báo Cáo", icon: "chart.bar.xaxis", color: .green, actionTag: "reports")
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


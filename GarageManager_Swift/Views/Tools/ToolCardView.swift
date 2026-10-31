import SwiftUI

public struct ToolCardView: View {
    public let tool: Tool
    public var onReportDamage: (() -> Void)?
    
    public init(tool: Tool, onReportDamage: (() -> Void)? = nil) {
        self.tool = tool
        self.onReportDamage = onReportDamage
    }
    
    private var statusColor: Color {
        switch tool.status {
        case .available: return .green
        case .inUse: return .blue
        case .damaged: return .red
        case .maintenance: return .orange
        }
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(tool.code)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color(.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                
                Text(tool.category)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                StatusBadge(tool.status.title, color: statusColor)
            }
            
            Text(tool.name)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
                .lineLimit(2)
            
            HStack {
                HStack(spacing: 4) {
                    Text("Tổng:")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("\(tool.totalQuantity)")
                        .font(.caption)
                        .fontWeight(.bold)
                }
                
                Text("•")
                    .foregroundStyle(.secondary)
                
                HStack(spacing: 4) {
                    Text("Còn:")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("\(tool.availableQuantity)")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(.green)
                }
                
                if tool.brokenQuantity > 0 {
                    Text("•")
                        .foregroundStyle(.secondary)
                    
                    HStack(spacing: 4) {
                        Text("Hỏng:")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text("\(tool.brokenQuantity)")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundStyle(.red)
                    }
                }
                
                Spacer()
                
                if let location = tool.location {
                    Label(location, systemImage: "mappin.circle.fill")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
            
            if tool.availableQuantity > 0 {
                Button {
                    onReportDamage?()
                } label: {
                    Label("Báo hỏng", systemImage: "exclamationmark.triangle")
                        .font(.caption)
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 6)
                        .background(Color.red.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .buttonStyle(.plain)
            }
        }
        .padding(14)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
    }
}

#Preview {
    ToolCardView(
        tool: Tool(
            name: "Súng siết bu-lông khí nén 1/2 inch",
            code: "TL-001",
            category: "Dụng cụ khí nén",
            status: .available,
            totalQuantity: 4,
            availableQuantity: 3,
            brokenQuantity: 1,
            location: "Tủ đồ nghề A1"
        )
    )
    .padding()
}


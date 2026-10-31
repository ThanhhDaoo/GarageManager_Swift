import SwiftUI

public struct StatusBadge: View {
    public let text: String
    public let color: Color
    
    public init(_ text: String, color: Color = .blue) {
        self.text = text
        self.color = color
    }
    
    public var body: some View {
        Text(text)
            .font(.caption)
            .fontWeight(.semibold)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(color.opacity(0.15))
            .foregroundStyle(color)
            .clipShape(Capsule())
    }
}

#Preview {
    HStack {
        StatusBadge("Sẵn sàng", color: .green)
        StatusBadge("Đang sửa", color: .orange)
        StatusBadge("Báo hỏng", color: .red)
    }
    .padding()
}


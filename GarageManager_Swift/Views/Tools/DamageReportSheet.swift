import SwiftUI

public struct DamageReportSheet: View {
    @Environment(\.dismiss) private var dismiss
    public let tool: Tool
    public var onSubmit: ((Int, String) -> Void)?
    
    @State private var damagedCount: Int = 1
    @State private var reason: String = ""
    
    public init(tool: Tool, onSubmit: ((Int, String) -> Void)? = nil) {
        self.tool = tool
        self.onSubmit = onSubmit
    }
    
    public var body: some View {
        NavigationStack {
            Form {
                Section("Dụng cụ gặp sự cố") {
                    LabeledContent("Tên", value: tool.name)
                    LabeledContent("Mã", value: tool.code)
                    LabeledContent("Khả dụng", value: "\(tool.availableQuantity)")
                }
                
                Section("Số lượng báo hỏng") {
                    Stepper(value: $damagedCount, in: 1...max(1, tool.availableQuantity)) {
                        HStack {
                            Text("Số lượng:")
                            Spacer()
                            Text("\(damagedCount)")
                                .fontWeight(.bold)
                                .foregroundStyle(.red)
                        }
                    }
                }
                
                Section("Lý do & Tình trạng hư hại") {
                    TextField("Mô tả nguyên nhân hỏng hóc...", text: $reason, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle("Báo Hỏng Đồ Nghề")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Hủy") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Gửi báo cáo") {
                        onSubmit?(damagedCount, reason)
                        dismiss()
                    }
                    .disabled(reason.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}

#Preview {
    DamageReportSheet(
        tool: Tool(
            name: "Súng siết bu-lông khí nén",
            code: "TL-001",
            category: "Dụng cụ khí nén",
            totalQuantity: 4,
            availableQuantity: 3
        )
    )
}


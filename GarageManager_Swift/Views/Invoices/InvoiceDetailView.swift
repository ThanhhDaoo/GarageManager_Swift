import SwiftUI

public struct InvoiceDetailView: View {
    public let order: WorkOrder
    
    public init(order: WorkOrder) {
        self.order = order
    }
    
    public var body: some View {
        List {
            Section("Thông tin phương tiện & Khách hàng") {
                LabeledContent("Mã lệnh", value: order.code)
                LabeledContent("Biển số xe", value: order.licensePlate)
                LabeledContent("Dòng xe", value: order.vehicleModel)
                LabeledContent("Khách hàng", value: order.customerName)
                LabeledContent("Số điện thoại", value: order.phoneNumber)
                if let tech = order.technicianName {
                    LabeledContent("Kỹ thuật viên", value: tech)
                }
                if let bay = order.liftBay {
                    LabeledContent("Khoang sửa chữa", value: "Khoang \(bay)")
                }
            }
            
            Section("Chi tiết chi phí") {
                HStack {
                    Label("Tiền công thợ máy", systemImage: "wrench.adjustable")
                    Spacer()
                    Text(order.laborCost.formattedVND)
                        .fontWeight(.semibold)
                }
                
                HStack {
                    Label("Tiền linh kiện, phụ tùng", systemImage: "shippingbox")
                    Spacer()
                    Text(order.partsCost.formattedVND)
                        .fontWeight(.semibold)
                }
                
                if order.discount > 0 {
                    HStack {
                        Label("Chiết khấu / Giảm giá", systemImage: "tag")
                        Spacer()
                        Text("-\(order.discount.formattedVND)")
                            .foregroundStyle(.red)
                    }
                }
                
                HStack {
                    Text("Tổng cộng")
                        .font(.headline)
                    Spacer()
                    Text(order.totalAmount.formattedVND)
                        .font(.headline)
                        .foregroundStyle(.blue)
                }
            }
            
            if let notes = order.notes, !notes.isEmpty {
                Section("Ghi chú kỹ thuật") {
                    Text(notes)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .navigationTitle(order.code)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        InvoiceDetailView(
            order: WorkOrder(
                code: "WO-2410-001",
                customerName: "Nguyễn Văn Hùng",
                phoneNumber: "0901234567",
                licensePlate: "30G-998.22",
                vehicleModel: "Hyundai Tucson 2022",
                status: .repairing,
                technicianName: "Nguyễn Văn Tuấn",
                liftBay: 1,
                laborCost: 450_000,
                partsCost: 1_850_000,
                discount: 100_000,
                notes: "Thay nhớt động cơ + lọc nhớt"
            )
        )
    }
}

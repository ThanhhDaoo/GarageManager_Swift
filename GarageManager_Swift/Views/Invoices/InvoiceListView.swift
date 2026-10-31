import SwiftUI

public struct InvoiceListView: View {
    @State private var viewModel = InvoiceViewModel()
    
    public init() {}
    
    private func statusColor(for status: WorkOrderStatus) -> Color {
        switch status {
        case .received: return .blue
        case .diagnosing: return .purple
        case .repairing: return .orange
        case .waitingParts: return .red
        case .completed: return .teal
        case .paid: return .green
        }
    }
    
    public var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.filteredWorkOrders) { order in
                    NavigationLink {
                        InvoiceDetailView(order: order)
                    } label: {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text(order.code)
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                                StatusBadge(order.status.title, color: statusColor(for: order.status))
                            }
                            
                            HStack {
                                Text(order.licensePlate)
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 2)
                                    .background(Color(.systemGray5))
                                    .clipShape(RoundedRectangle(cornerRadius: 4))
                                
                                Text(order.vehicleModel)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                
                                Spacer()
                                
                                Text(String(format: "%.0f đ", order.totalAmount))
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.blue)
                            }
                            
                            HStack {
                                Text(order.customerName)
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                                
                                Spacer()
                                
                                if let tech = order.technicianName {
                                    Text("Thợ: \(tech)")
                                        .font(.caption2)
                                        .foregroundStyle(.tertiary)
                                }
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Lệnh Sửa Chữa & HĐ")
            .refreshable {
                await viewModel.fetchWorkOrders()
            }
        }
    }
}

#Preview {
    InvoiceListView()
}


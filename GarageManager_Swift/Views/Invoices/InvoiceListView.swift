import SwiftUI

public struct InvoiceListView: View {
    @Environment(AppNavigationState.self) private var navigationState: AppNavigationState?
    @State private var viewModel = InvoiceViewModel()
    @State private var showingAddSheet = false
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                AppHeaderView(
                    title: "Quản Lý Hoá Đơn",
                    backTitle: "Trang chủ",
                    backAction: {
                        navigationState?.navigateToHome()
                    },
                    trailingIcon: "plus.circle.fill",
                    trailingAction: {
                        showingAddSheet = true
                    }
                )
                
                Divider()
                
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
                                    
                                    StatusBadge(order.status.title, color: order.status.color)
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
                                    
                                    Text(order.totalAmount.formattedVND)
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
            }
            .toolbar(.hidden, for: .navigationBar)
            .refreshable {
                await viewModel.fetchWorkOrders()
            }
        }
    }
}

#Preview {
    InvoiceListView()
        .environment(AppNavigationState())
}

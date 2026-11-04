import SwiftUI

public struct ToolListView: View {
    @Environment(AppNavigationState.self) private var navigationState: AppNavigationState?
    @State private var viewModel = ToolViewModel()
    @State private var reportingTool: Tool?
    @State private var showingAddSheet = false
    public init() {}
    
    private let kpiColumns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    public var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                AppHeaderView(
                    title: "Quản Lý Dụng Cụ",
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
                
                ScrollView {
                    VStack(spacing: 16) {
                        // 4 Thẻ KPI
                        LazyVGrid(columns: kpiColumns, spacing: 10) {
                            MetricCard(
                                title: "Tổng số",
                                value: "\(viewModel.totalCount)",
                                icon: "archivebox.fill",
                                color: .blue
                            )
                            
                            MetricCard(
                                title: "Sẵn sàng",
                                value: "\(viewModel.availableCount)",
                                icon: "checkmark.circle.fill",
                                color: .green
                            )
                            
                            MetricCard(
                                title: "Báo hỏng",
                                value: "\(viewModel.brokenCount)",
                                icon: "exclamationmark.triangle.fill",
                                color: .red
                            )
                            
                            MetricCard(
                                title: "Đang dùng",
                                value: "\(viewModel.inUseCount)",
                                icon: "wrench.adjustable.fill",
                                color: .orange
                            )
                        }
                        
                        // Danh sách đồ nghề
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Trang thiết bị & Dụng cụ")
                                .font(.headline)
                            
                            LazyVStack(spacing: 12) {
                                ForEach(viewModel.tools) { tool in
                                    ToolCardView(tool: tool) {
                                        reportingTool = tool
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
                .background(Color(.systemGroupedBackground))
            }
            .toolbar(.hidden, for: .navigationBar)
            .sheet(item: $reportingTool) { tool in
                DamageReportSheet(tool: tool) { count, reason in
                    Task {
                        await viewModel.reportDamage(for: tool, brokenCount: count, reason: reason)
                    }
                }
            }
            .refreshable {
                await viewModel.fetchTools()
            }
        }
    }
}

#Preview {
    ToolListView()
        .environment(AppNavigationState())
}

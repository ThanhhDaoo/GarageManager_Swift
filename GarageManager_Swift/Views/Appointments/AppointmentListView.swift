import SwiftUI

public struct AppointmentListView: View {
    @Environment(AppNavigationState.self) private var navigationState: AppNavigationState?
    @State private var viewModel = AppointmentViewModel()
    @State private var showingAddSheet = false
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Header chuẩn dùng chung
                AppHeaderView(
                    title: "Quản Lý Lịch Hẹn",
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

                // Thanh lọc danh mục theo trạng thái (cuộn ngang)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        FilterChip(
                            title: "Tất cả",
                            isSelected: viewModel.selectedStatus == nil
                        ) {
                            viewModel.selectedStatus = nil
                        }
                        
                        ForEach(AppointmentStatus.allCases, id: \.self) { status in
                            FilterChip(
                                title: status.title,
                                isSelected: viewModel.selectedStatus == status
                            ) {
                                viewModel.selectedStatus = status
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                }
                .background(Color(.secondarySystemGroupedBackground))
                
                // Danh sách lịch hẹn xe
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.filteredAppointments) { appointment in
                            AppointmentCardView(appointment: appointment)
                        }
                    }
                    .padding()
                }
            }
            .background(Color(.systemGroupedBackground))
            .toolbar(.hidden, for: .navigationBar)
            .refreshable {
                await viewModel.fetchAppointments()
            }
        }
    }
}

private struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(isSelected ? .semibold : .regular)
                .padding(.horizontal, 14)
                .padding(.vertical, 6)
                .background(isSelected ? Color.blue : Color(.systemGray6))
                .foregroundStyle(isSelected ? Color.white : Color.primary)
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    AppointmentListView()
        .environment(AppNavigationState())
}

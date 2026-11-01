import SwiftUI

public struct AppointmentListView: View {
    @State private var viewModel = AppointmentViewModel()
    @State private var showingAddSheet = false
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                // MARK: - 1. HEADER CỐ ĐỊNH (Không nằm trong ScrollView)
                HStack(alignment: .center, spacing: 8) {
                    // Nút Back
                    Button {
                        // Action: Quay lại màn hình trước
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                            Text("Trang chủ")
                        }
                        .font(.subheadline)
                        .foregroundStyle(.blue)
                    }

                    Spacer()

                    // Tiêu đề căn giữa
                    Text("Quản Lý Lịch Hẹn")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(Color(red: 10/255, green: 25/255, blue: 50/255))
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)

                    Spacer()

                    // Nút Thêm (+)
                    Button {
                        showingAddSheet = true
                        print("+")
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 26))
                            .foregroundStyle(.blue)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color(.secondarySystemGroupedBackground))
                
                Divider() // Ngăn cách nhẹ giữa Header và danh mục

                // MARK: - 2. THANH LỌC DANH MỤC (Cuộn ngang)
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
                
                // MARK: - 3. DANH SÁCH LỊCH HẸN (Cuộn dọc)
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
}


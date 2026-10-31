import SwiftUI

public struct AppointmentListView: View {
    @State private var viewModel = AppointmentViewModel()
    @State private var showingAddSheet = false
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Filter Segment
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
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                }
                .background(Color(.secondarySystemGroupedBackground))
                
                // List of Appointments
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
            .navigationTitle("Lịch Hẹn Xe")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
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


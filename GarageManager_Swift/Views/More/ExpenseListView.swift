import SwiftUI

public struct ExpenseListView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showingAddSheet = false
    @State private var expenses: [Expense] = [
        Expense(title: "Tiền thuê mặt bằng xưởng", category: "Mặt bằng", amount: 25_000_000, isRecurring: true, notes: "Thanh toán đầu tháng qua chuyển khoản"),
        Expense(title: "Hóa đơn điện 3 pha gara", category: "Điện nước", amount: 6_450_000, isRecurring: false, notes: "Tháng này dùng nhiều máy nén khí"),
        Expense(title: "Nước sạch sinh hoạt & rửa xe", category: "Điện nước", amount: 1_200_000, isRecurring: false),
        Expense(title: "Mua giẻ lau & xà phòng công nghiệp", category: "Vật tư tiêu hao", amount: 850_000, isRecurring: false),
        Expense(title: "Bảo dưỡng định kỳ cầu nâng 2 trụ", category: "Bảo trì thiết bị", amount: 3_200_000, isRecurring: false, notes: "Thay phớt và dầu thủy lực cầu 1 & 2")
    ]
    
    public init() {}
    
    private var totalMonthlyExpense: Double {
        expenses.reduce(0) { $0 + $1.amount }
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            AppHeaderView(
                title: "Chi Phí & Sổ Quỹ",
                backTitle: "Quản trị",
                backAction: {
                    dismiss()
                },
                trailingIcon: "plus.circle.fill",
                trailingAction: {
                    showingAddSheet = true
                }
            )
            
            Divider()
            
            List {
                Section {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Tổng chi phí tháng này")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(totalMonthlyExpense.formattedVND)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.red)
                    }
                    .padding(.vertical, 4)
                }
                
                Section("Khoản chi chi tiết") {
                    ForEach(expenses) { expense in
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Text(expense.title)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                Spacer()
                                Text(expense.amount.formattedVND)
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.red)
                            }
                            
                            HStack {
                                Text(expense.category)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                
                                if expense.isRecurring {
                                    StatusBadge("Cố định hàng tháng", color: .indigo)
                                }
                                
                                Spacer()
                                
                                Text(expense.expenseDate.formatted(date: .numeric, time: .omitted))
                                    .font(.caption2)
                                    .foregroundStyle(.tertiary)
                            }
                            
                            if let notes = expense.notes {
                                Text(notes)
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        ExpenseListView()
    }
}

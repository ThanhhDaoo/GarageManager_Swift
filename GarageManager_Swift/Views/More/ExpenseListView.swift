import SwiftUI

public struct ExpenseListView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var expenses: [Expense] = [
        Expense(title: "Tiền thuê mặt bằng xưởng", category: "Mặt bằng", amount: 25_000_000, isRecurring: true, notes: "Thanh toán đầu tháng qua chuyển khoản"),
        Expense(title: "Hóa đơn điện 3 pha gara", category: "Điện nước", amount: 6_450_000, isRecurring: false, notes: "Tháng này dùng nhiều máy nén khí"),
        Expense(title: "Nước sạch sinh hoạt & rửa xe", category: "Điện nước", amount: 1_200_000, isRecurring: false),
        Expense(title: "Mua giẻ lau & xà phòng công nghiệp", category: "Vật tư tiêu hao", amount: 850_000, isRecurring: false),
        Expense(title: "Bảo dưỡng định kỳ cầu nâng 2 trụ", category: "Bảo trì thiết bị", amount: 3_200_000, isRecurring: false, notes: "Thay phớt và dầu thủy lực cầu 1 & 2")
    ]
    @State private var showingAddSheet = false
    public init() {}
    
    private var totalMonthlyExpense: Double {
        expenses.reduce(0) { $0 + $1.amount }
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 8) {
                // Nút Back
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text("Trang chủ")
                    }
                    .offset(x: 10)
                    .font(.subheadline)
                    .foregroundStyle(.blue)
                }

                Spacer()
                Text("Quản Lý Doanh Thu")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color(red: 10/255, green: 25/255, blue: 50/255))
                    .lineLimit(1)
                    .offset(x: -10)
                    .minimumScaleFactor(0.8)

                Spacer()
                Button {
                    showingAddSheet = true
                    print("+")
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 30))
                        .foregroundStyle(.blue)
                        .offset(x: -10)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(.secondarySystemGroupedBackground))
            
            List {
                Section {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Tổng chi phí tháng này")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(String(format: "%.0f đ", totalMonthlyExpense))
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
                                Text(String(format: "%.0f đ", expense.amount))
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

import SwiftUI

public struct ProductListView: View {
    @State private var products: [Product] = [
        Product(name: "Dầu nhớt động cơ Motul 5W30 4L", sku: "OIL-MT-5W30", category: "Dầu nhớt", unit: "Can", unitPrice: 850_000, stockQuantity: 18, minStockAlert: 5, location: "Kệ O-01"),
        Product(name: "Lọc dầu nhớt động cơ Toyota/Lexus", sku: "FLT-TY-01", category: "Lọc phụ tùng", unit: "Cái", unitPrice: 120_000, stockQuantity: 4, minStockAlert: 10, location: "Kệ F-02"),
        Product(name: "Má phanh trước Brembo Ceramic", sku: "BRK-BR-001", category: "Hệ thống phanh", unit: "Bộ", unitPrice: 1_650_000, stockQuantity: 2, minStockAlert: 3, location: "Kệ B-04"),
        Product(name: "Nước làm mát động cơ pha sẵn 4L", sku: "CLT-PR-04", category: "Dung dịch", unit: "Can", unitPrice: 280_000, stockQuantity: 25, minStockAlert: 6, location: "Kệ C-01"),
        Product(name: "Bugi bạch kim NGK Iridium Laser", sku: "SPK-NGK-IR", category: "Đánh lửa", unit: "Cái", unitPrice: 220_000, stockQuantity: 16, minStockAlert: 8, location: "Kệ S-03")
    ]
    @State private var searchText: String = ""
    @State private var filterOnlyLowStock: Bool = false
    @State private var showingAddSheet = false
    public init() {}
    
    private var filteredProducts: [Product] {
        products.filter { product in
            let matchesSearch = searchText.isEmpty ||
                product.name.localizedCaseInsensitiveContains(searchText) ||
                product.sku.localizedCaseInsensitiveContains(searchText)
            let matchesLowStock = !filterOnlyLowStock || product.isLowStock
            return matchesSearch && matchesLowStock
        }
    }
    
    private var lowStockCount: Int {
        products.filter { $0.isLowStock }.count
    }
    
    public var body: some View {
        NavigationStack {
            HStack(alignment: .center, spacing: 8) {
                // Nút Back
                Button {
                    // Action: Quay lại màn hình trước
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
                Text("Quản Lý Hoá Đơn")
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
            List {
                if lowStockCount > 0 {
                    Section {
                        HStack(spacing: 12) {
                            Image(systemName: "exclamationmark.octagon.fill")
                                .font(.title2)
                                .foregroundStyle(.red)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Cảnh báo tồn kho tối thiểu")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                Text("Có \(lowStockCount) mặt hàng sắp hết, cần nhập thêm")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            
                            Spacer()
                            
                            Toggle("", isOn: $filterOnlyLowStock)
                                .labelsHidden()
                        }
                        .padding(.vertical, 4)
                    }
                }
                
                Section("Danh mục vật tư & phụ tùng") {
                    ForEach(filteredProducts) { item in
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Text(item.name)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                Spacer()
                                Text(String(format: "%.0f đ", item.unitPrice))
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.blue)
                            }
                            
                            HStack {
                                Text(item.sku)
                                    .font(.caption2)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 2)
                                    .background(Color(.systemGray5))
                                    .clipShape(RoundedRectangle(cornerRadius: 4))
                                
                                Text(item.category)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                
                                Spacer()
                                
                                if item.isLowStock {
                                    StatusBadge("Sắp hết (\(item.stockQuantity) \(item.unit))", color: .red)
                                } else {
                                    Text("Tồn: \(item.stockQuantity) \(item.unit)")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            
                            if let loc = item.location {
                                Text("Vị trí: \(loc)")
                                    .font(.caption2)
                                    .foregroundStyle(.tertiary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Tìm theo tên hoặc mã SKU")
        }
    }
}

#Preview {
    ProductListView()
}


import SwiftUI

public struct MoreHubView: View {
    public init() {}
    @State private var showingAddSheet = false
    public var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
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
                    Text("Quản Trị Thêm")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(red: 10/255, green: 25/255, blue: 50/255))
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                        .offset(x: -20)
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 15)
                .background(Color(.secondarySystemGroupedBackground))
                
                List {
                    Section("Nghiệp vụ Mở rộng") {
                        NavigationLink {
                            ProductListView()
                        } label: {
                            Label {
                                VStack(alignment: .leading) {
                                    Text("Kho Sản Phẩm")
                                        .font(.body)
                                    Text("Quản lý tồn kho & cảnh báo nhập hàng")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            } icon: {
                                Image(systemName: "shippingbox.fill")
                                    .foregroundStyle(.orange)
                            }
                        }
                        
                        NavigationLink {
                            ServiceListView()
                        } label: {
                            Label {
                                VStack(alignment: .leading) {
                                    Text("Bảng Giá Dịch Vụ")
                                        .font(.body)
                                    Text("Gói combo bảo dưỡng & tiền công tiêu chuẩn")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            } icon: {
                                Image(systemName: "list.clipboard.fill")
                                    .foregroundStyle(.purple)
                            }
                        }
                        
                        NavigationLink {
                            TechnicianListView()
                        } label: {
                            Label {
                                VStack(alignment: .leading) {
                                    Text("Đội Ngũ Thợ Máy")
                                        .font(.body)
                                    Text("Phân ca, xếp việc & năng suất thợ")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            } icon: {
                                Image(systemName: "person.3.fill")
                                    .foregroundStyle(.teal)
                            }
                        }
                        
                        NavigationLink {
                            ExpenseListView()
                        } label: {
                            Label {
                                VStack(alignment: .leading) {
                                    Text("Chi Phí & Báo Cáo")
                                        .font(.body)
                                    Text("Tiền thuê, điện nước, vật tư tiêu hao")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            } icon: {
                                Image(systemName: "banknote.fill")
                                    .foregroundStyle(.green)
                            }
                        }
                    }
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    MoreHubView()
}

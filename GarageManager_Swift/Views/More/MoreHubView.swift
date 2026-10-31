import SwiftUI

public struct MoreHubView: View {
    public init() {}
    
    public var body: some View {
        NavigationStack {
            List {
                Section("Nghiệp vụ Mở rộng") {
                    NavigationLink {
                        ProductListView()
                    } label: {
                        Label {
                            VStack(alignment: .leading) {
                                Text("Kho Phụ Tùng")
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
                                Text("Chi Phí & Sổ Quỹ")
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
                
                Section("Hệ Thống & Đồng Bộ") {
                    HStack {
                        Label("Kết nối Supabase Cloud", systemImage: "cloud.fill")
                            .foregroundStyle(.blue)
                        Spacer()
                        StatusBadge("Đang kết nối", color: .green)
                    }
                    
                    LabeledContent("Phiên bản", value: "1.0.0 (Build 2026)")
                }
            }
            .navigationTitle("Quản Trị Tổng Hợp")
        }
    }
}

#Preview {
    MoreHubView()
}


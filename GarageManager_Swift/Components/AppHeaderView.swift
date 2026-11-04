import SwiftUI

/// Header điều hướng chuẩn dùng chung cho tất cả màn hình trong ứng dụng
public struct AppHeaderView: View {
    public let title: String
    public var backTitle: String? = "Trang chủ"
    public var backAction: (() -> Void)? = nil
    public var trailingIcon: String? = nil
    public var trailingAction: (() -> Void)? = nil
    
    public init(
        title: String,
        backTitle: String? = "Trang chủ",
        backAction: (() -> Void)? = nil,
        trailingIcon: String? = nil,
        trailingAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.backTitle = backTitle
        self.backAction = backAction
        self.trailingIcon = trailingIcon
        self.trailingAction = trailingAction
    }
    
    public var body: some View {
        HStack(alignment: .center, spacing: 8) {
            // Nút điều hướng bên trái (Back / Home)
            if let backAction = backAction {
                Button(action: backAction) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 14, weight: .semibold))
                        if let backTitle = backTitle, !backTitle.isEmpty {
                            Text(backTitle)
                                .font(.subheadline)
                        }
                    }
                    .foregroundStyle(.blue)
                }
                .frame(minWidth: 70, alignment: .leading)
            } else {
                Spacer()
                    .frame(width: 70)
            }
            
            Spacer()
            
            // Tiêu đề chính giữa
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(Color.brandNavy)
                .lineLimit(1)
                .minimumScaleFactor(0.85)
            
            Spacer()
            
            // Nút hành động bên phải (Thêm mới / Tùy chọn)
            if let trailingIcon = trailingIcon, let trailingAction = trailingAction {
                Button(action: trailingAction) {
                    Image(systemName: trailingIcon)
                        .font(.system(size: 26))
                        .foregroundStyle(.blue)
                }
                .frame(minWidth: 70, alignment: .trailing)
            } else {
                Spacer()
                    .frame(width: 70)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.secondarySystemGroupedBackground))
    }
}

#Preview {
    VStack(spacing: 20) {
        AppHeaderView(
            title: "Quản Lý Lịch Hẹn",
            backAction: {},
            trailingIcon: "plus.circle.fill",
            trailingAction: {}
        )
        
        AppHeaderView(
            title: "Quản Trị Thêm",
            backAction: {}
        )
        
        AppHeaderView(
            title: "Trang Chủ Không Back",
            trailingIcon: "bell.fill",
            trailingAction: {}
        )
    }
}

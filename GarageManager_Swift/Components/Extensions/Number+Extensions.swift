import Foundation

extension Double {
    /// Định dạng tiền tệ VNĐ chuẩn với phân tách hàng nghìn (ví dụ: 14.500.000 đ)
    public var formattedVND: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.maximumFractionDigits = 0
        let formatted = formatter.string(from: NSNumber(value: self)) ?? String(format: "%.0f", self)
        return "\(formatted) đ"
    }
}


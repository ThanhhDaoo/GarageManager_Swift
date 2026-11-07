import SwiftUI

/// Màn hình đăng nhập phong cách Siêu Xe Điện Ảnh (Luxury Dark Cinematic)
/// Thiết kế lấy cảm hứng từ Porsche, Tesla và Polestar: Nền Obsidian sâu thẳm,
/// vệt sáng khí động học LED, trường nhập liệu kính tối không khung hộp, tương phản cao.
public struct LoginView: View {
    @Environment(AppNavigationState.self) private var navigationState: AppNavigationState?
    @State private var viewModel = AuthViewModel()
    @FocusState private var focusedField: Field?
    
    private enum Field: Hashable {
        case email
        case password
    }
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            ZStack {
                // MARK: - 1. NỀN ĐIỆN ẢNH ĐEN OBSIDIAN & ÁNH SÁNG LED
                CinematicBackgroundView()
                
                // MARK: - 2. NỘI DUNG ĐĂNG NHẬP
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 36) {
                        Spacer(minLength: 44)
                        
                        // MARK: - BRAND HEADER (TYPOGRAPHY SIÊU XE)
                        VStack(spacing: 14) {
                            // Biểu tượng vệt sáng khí động học siêu xe
                            HStack(spacing: 8) {
                                Rectangle()
                                    .fill(
                                        LinearGradient(
                                            colors: [.clear, Color.cyan.opacity(0.8)],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .frame(width: 32, height: 1.5)
                                
                                Image(systemName: "shield.righthalf.filled")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundStyle(
                                        LinearGradient(
                                            colors: [.white, Color.cyan],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                                
                                Rectangle()
                                    .fill(
                                        LinearGradient(
                                            colors: [Color.cyan.opacity(0.8), .clear],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .frame(width: 32, height: 1.5)
                            }
                            
                            VStack(spacing: 6) {
                                Text("M T P R O")
                                    .font(.system(size: 30, weight: .black, design: .default))
                                    .tracking(8)
                                    .foregroundStyle(
                                        LinearGradient(
                                            colors: [.white, Color(white: 0.82)],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                                    .shadow(color: Color.white.opacity(0.2), radius: 10, x: 0, y: 0)
                                
                                Text("PERFORMANCE GARAGE OS")
                                    .font(.system(size: 10.5, weight: .semibold))
                                    .tracking(4)
                                    .foregroundStyle(Color.white.opacity(0.4))
                            }
                        }
                        .padding(.top, 16)
                        
                        // MARK: - FORM NHẬP LIỆU (KÍNH TỐI KHÔNG KHUNG HỘP)
                        VStack(spacing: 22) {
                            // Trường Email / Tài khoản
                            VStack(alignment: .leading, spacing: 8) {
                                Text("TÀI KHOẢN HỆ THỐNG")
                                    .font(.system(size: 10.5, weight: .semibold))
                                    .tracking(1.5)
                                    .foregroundStyle(Color.white.opacity(0.45))
                                
                                HStack(spacing: 14) {
                                    Image(systemName: "envelope")
                                        .font(.system(size: 15, weight: .light))
                                        .foregroundStyle(focusedField == .email ? Color.cyan : Color.white.opacity(0.35))
                                        .frame(width: 20)
                                    
                                    TextField("", text: $viewModel.email, prompt: Text("admin@mtpro.vn").foregroundStyle(Color.white.opacity(0.25)))
                                        .font(.system(size: 15, weight: .regular))
                                        .foregroundStyle(.white)
                                        .keyboardType(.emailAddress)
                                        .textInputAutocapitalization(.never)
                                        .autocorrectionDisabled(true)
                                        .focused($focusedField, equals: .email)
                                        .submitLabel(.next)
                                        .onSubmit {
                                            focusedField = .password
                                        }
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 15)
                                .background(Color.white.opacity(0.04))
                                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                                        .stroke(
                                            focusedField == .email
                                                ? Color.cyan.opacity(0.8)
                                                : Color.white.opacity(0.08),
                                            lineWidth: focusedField == .email ? 1.2 : 0.8
                                        )
                                )
                                .shadow(color: focusedField == .email ? Color.cyan.opacity(0.15) : .clear, radius: 8)
                            }
                            
                            // Trường Mật khẩu
                            VStack(alignment: .leading, spacing: 8) {
                                Text("MẬT KHẨU")
                                    .font(.system(size: 10.5, weight: .semibold))
                                    .tracking(1.5)
                                    .foregroundStyle(Color.white.opacity(0.45))
                                
                                HStack(spacing: 14) {
                                    Image(systemName: "lock")
                                        .font(.system(size: 15, weight: .light))
                                        .foregroundStyle(focusedField == .password ? Color.cyan : Color.white.opacity(0.35))
                                        .frame(width: 20)
                                    
                                    Group {
                                        if viewModel.isPasswordVisible {
                                            TextField("", text: $viewModel.password, prompt: Text("Nhập mật khẩu").foregroundStyle(Color.white.opacity(0.25)))
                                        } else {
                                            SecureField("", text: $viewModel.password, prompt: Text("Nhập mật khẩu").foregroundStyle(Color.white.opacity(0.25)))
                                        }
                                    }
                                    .font(.system(size: 15, weight: .regular))
                                    .foregroundStyle(.white)
                                    .textInputAutocapitalization(.never)
                                    .autocorrectionDisabled(true)
                                    .focused($focusedField, equals: .password)
                                    .submitLabel(.done)
                                    .onSubmit {
                                        handleLogin()
                                    }
                                    
                                    Button {
                                        viewModel.isPasswordVisible.toggle()
                                    } label: {
                                        Image(systemName: viewModel.isPasswordVisible ? "eye.slash" : "eye")
                                            .font(.system(size: 14, weight: .light))
                                            .foregroundStyle(Color.white.opacity(0.4))
                                    }
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 15)
                                .background(Color.white.opacity(0.04))
                                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                                        .stroke(
                                            focusedField == .password
                                                ? Color.cyan.opacity(0.8)
                                                : Color.white.opacity(0.08),
                                            lineWidth: focusedField == .password ? 1.2 : 0.8
                                        )
                                )
                                .shadow(color: focusedField == .password ? Color.cyan.opacity(0.15) : .clear, radius: 8)
                            }
                            
                            // Ghi nhớ & Quên mật khẩu
                            HStack {
                                Button {
                                    viewModel.rememberMe.toggle()
                                } label: {
                                    HStack(spacing: 8) {
                                        Image(systemName: viewModel.rememberMe ? "checkmark.circle.fill" : "circle")
                                            .font(.system(size: 14, weight: .light))
                                            .foregroundStyle(viewModel.rememberMe ? Color.cyan : Color.white.opacity(0.3))
                                        
                                        Text("Ghi nhớ phiên đăng nhập")
                                            .font(.system(size: 12.5))
                                            .foregroundStyle(Color.white.opacity(0.6))
                                    }
                                }
                                .buttonStyle(.plain)
                                
                                Spacer()
                                
                                Button {
                                    // Action khôi phục mật khẩu
                                } label: {
                                    Text("Quên mật khẩu?")
                                        .font(.system(size: 12.5, weight: .medium))
                                        .foregroundStyle(Color.white.opacity(0.45))
                                }
                                .buttonStyle(.plain)
                            }
                            .padding(.horizontal, 2)
                            
                            // Thông báo lỗi nếu có
                            if let error = viewModel.errorMessage {
                                HStack(spacing: 10) {
                                    Image(systemName: "exclamationmark.octagon.fill")
                                        .font(.system(size: 14))
                                        .foregroundStyle(Color(red: 255/255, green: 80/255, blue: 80/255))
                                    Text(error)
                                        .font(.system(size: 12.5))
                                        .foregroundStyle(Color(red: 255/255, green: 200/255, blue: 200/255))
                                    Spacer()
                                }
                                .padding(12)
                                .background(Color(red: 255/255, green: 50/255, blue: 50/255).opacity(0.12))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.red.opacity(0.3), lineWidth: 0.8)
                                )
                            }
                            
                            // MARK: - NÚT ĐĂNG NHẬP TƯƠNG PHẢN CAO (HIGH-CONTRAST PORSCHE CTA)
                            HStack(spacing: 12) {
                                Button {
                                    handleLogin()
                                } label: {
                                    HStack(spacing: 10) {
                                        if viewModel.isLoading {
                                            ProgressView()
                                                .tint(.black)
                                        } else {
                                            Text("ĐĂNG NHẬP")
                                                .font(.system(size: 14, weight: .bold))
                                                .tracking(2.5)
                                                .foregroundStyle(.black)
                                            
                                            Image(systemName: "arrow.right")
                                                .font(.system(size: 13, weight: .bold))
                                                .foregroundStyle(.black)
                                        }
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 16)
                                    .background(
                                        viewModel.isFormValid
                                            ? Color.white
                                            : Color.white.opacity(0.3)
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                                    .shadow(color: viewModel.isFormValid ? Color.white.opacity(0.25) : .clear, radius: 14, x: 0, y: 0)
                                }
                                .disabled(viewModel.isLoading || !viewModel.isFormValid)
                                
                                // Phím nhanh Face ID / Sinh trắc học
                                Button {
                                    // Xác thực sinh trắc học Face ID
                                } label: {
                                    Image(systemName: "faceid")
                                        .font(.system(size: 20, weight: .light))
                                        .foregroundStyle(Color.white.opacity(0.75))
                                        .frame(width: 52, height: 52)
                                        .background(Color.white.opacity(0.05))
                                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                                .stroke(Color.white.opacity(0.12), lineWidth: 0.8)
                                        )
                                }
                                .buttonStyle(.plain)
                            }
                            .padding(.top, 10)
                        }
                        .padding(.horizontal, 24)
                        
                        Spacer(minLength: 40)
                        
                        // MARK: - FOOTER TỐI GIẢN CHUẨN XUẤT XƯỞNG
                        VStack(spacing: 6) {
                            Text("MTPRO AUTOMOTIVE • GARAGE WORKSPACE")
                                .font(.system(size: 9.5, weight: .medium))
                                .tracking(2.5)
                                .foregroundStyle(Color.white.opacity(0.25))
                            
                            Text("VERSION 1.0 • ENCRYPTED SESSION")
                                .font(.system(size: 8.5))
                                .tracking(1.8)
                                .foregroundStyle(Color.white.opacity(0.15))
                        }
                        .padding(.bottom, 24)
                    }
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .preferredColorScheme(.dark)
            .onTapGesture {
                focusedField = nil
            }
        }
    }
    
    private func handleLogin() {
        focusedField = nil
        Task {
            let success = await viewModel.signIn()
            if success {
                navigationState?.isAuthenticated = true
            }
        }
    }
}

#Preview {
    LoginView()
        .environment(AppNavigationState())
}

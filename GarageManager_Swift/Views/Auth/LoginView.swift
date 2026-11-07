import SwiftUI

/// Màn hình đăng nhập phong cách Siêu Xe Điện Ảnh (Luxury Dark Cinematic)
/// Cân chỉnh độ sáng & độ tương phản cao (High Contrast & High Clarity):
/// Các trường nhập liệu rõ ràng, chữ sắc nét, nút bấm nổi bật, dễ đọc và sang trọng.
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
                // MARK: - 1. NỀN ĐIỆN ẢNH MIDNIGHT & DẢI LED
                CinematicBackgroundView()
                
                // MARK: - 2. NỘI DUNG ĐĂNG NHẬP
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 32) {
                        Spacer(minLength: 36)
                        
                        // MARK: - BRAND HEADER (TYPOGRAPHY SIÊU XE)
                        VStack(spacing: 14) {
                            // Biểu tượng vệt sáng khí động học siêu xe
                            HStack(spacing: 10) {
                                Rectangle()
                                    .fill(
                                        LinearGradient(
                                            colors: [.clear, Color.cyan],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .frame(width: 36, height: 2)
                                
                                Image(systemName: "shield.righthalf.filled")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundStyle(
                                        LinearGradient(
                                            colors: [.white, Color.cyan],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                                    .shadow(color: Color.cyan.opacity(0.6), radius: 8)
                                
                                Rectangle()
                                    .fill(
                                        LinearGradient(
                                            colors: [Color.cyan, .clear],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .frame(width: 36, height: 2)
                            }
                            
                            VStack(spacing: 6) {
                                Text("M T P R O")
                                    .font(.system(size: 32, weight: .black, design: .default))
                                    .tracking(8)
                                    .foregroundStyle(.white)
                                    .shadow(color: Color.cyan.opacity(0.35), radius: 12, x: 0, y: 0)
                                
                                Text("PERFORMANCE GARAGE OS")
                                    .font(.system(size: 11, weight: .bold))
                                    .tracking(4)
                                    .foregroundStyle(Color.white.opacity(0.75))
                            }
                        }
                        .padding(.top, 12)
                        
                        // MARK: - FORM NHẬP LIỆU RÕ NÉT (HIGH-CLARITY DARK GLASS)
                        VStack(spacing: 22) {
                            // Trường Email / Tài khoản
                            VStack(alignment: .leading, spacing: 8) {
                                Text("TÀI KHOẢN HỆ THỐNG")
                                    .font(.system(size: 11, weight: .bold))
                                    .tracking(1.5)
                                    .foregroundStyle(Color.white.opacity(0.85))
                                
                                HStack(spacing: 14) {
                                    Image(systemName: "envelope.fill")
                                        .font(.system(size: 16))
                                        .foregroundStyle(focusedField == .email ? Color.cyan : Color.white.opacity(0.7))
                                        .frame(width: 20)
                                    
                                    TextField("", text: $viewModel.email, prompt: Text("admin@mtpro.vn").foregroundStyle(Color.white.opacity(0.45)))
                                        .font(.system(size: 15, weight: .medium))
                                        .foregroundStyle(.white)
                                        .tint(.cyan)
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
                                .background(Color(red: 24/255, green: 32/255, blue: 54/255).opacity(0.75))
                                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                                        .stroke(
                                            focusedField == .email
                                                ? Color.cyan
                                                : Color.white.opacity(0.18),
                                            lineWidth: focusedField == .email ? 1.5 : 1
                                        )
                                )
                                .shadow(color: focusedField == .email ? Color.cyan.opacity(0.25) : Color.black.opacity(0.2), radius: 8)
                            }
                            
                            // Trường Mật khẩu
                            VStack(alignment: .leading, spacing: 8) {
                                Text("MẬT KHẨU")
                                    .font(.system(size: 11, weight: .bold))
                                    .tracking(1.5)
                                    .foregroundStyle(Color.white.opacity(0.85))
                                
                                HStack(spacing: 14) {
                                    Image(systemName: "lock.fill")
                                        .font(.system(size: 16))
                                        .foregroundStyle(focusedField == .password ? Color.cyan : Color.white.opacity(0.7))
                                        .frame(width: 20)
                                    
                                    Group {
                                        if viewModel.isPasswordVisible {
                                            TextField("", text: $viewModel.password, prompt: Text("Nhập mật khẩu").foregroundStyle(Color.white.opacity(0.45)))
                                        } else {
                                            SecureField("", text: $viewModel.password, prompt: Text("Nhập mật khẩu").foregroundStyle(Color.white.opacity(0.45)))
                                        }
                                    }
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundStyle(.white)
                                    .tint(.cyan)
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
                                        Image(systemName: viewModel.isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                            .font(.system(size: 15))
                                            .foregroundStyle(Color.white.opacity(0.75))
                                    }
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 15)
                                .background(Color(red: 24/255, green: 32/255, blue: 54/255).opacity(0.75))
                                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                                        .stroke(
                                            focusedField == .password
                                                ? Color.cyan
                                                : Color.white.opacity(0.18),
                                            lineWidth: focusedField == .password ? 1.5 : 1
                                        )
                                )
                                .shadow(color: focusedField == .password ? Color.cyan.opacity(0.25) : Color.black.opacity(0.2), radius: 8)
                            }
                            
                            // Ghi nhớ & Quên mật khẩu
                            HStack {
                                Button {
                                    viewModel.rememberMe.toggle()
                                } label: {
                                    HStack(spacing: 8) {
                                        Image(systemName: viewModel.rememberMe ? "checkmark.circle.fill" : "circle")
                                            .font(.system(size: 15))
                                            .foregroundStyle(viewModel.rememberMe ? Color.cyan : Color.white.opacity(0.45))
                                        
                                        Text("Ghi nhớ phiên đăng nhập")
                                            .font(.system(size: 13, weight: .medium))
                                            .foregroundStyle(Color.white.opacity(0.85))
                                    }
                                }
                                .buttonStyle(.plain)
                                
                                Spacer()
                                
                                Button {
                                    // Action khôi phục mật khẩu
                                } label: {
                                    Text("Quên mật khẩu?")
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundStyle(Color.cyan)
                                }
                                .buttonStyle(.plain)
                            }
                            .padding(.horizontal, 2)
                            
                            // Thông báo lỗi nếu có
                            if let error = viewModel.errorMessage {
                                HStack(spacing: 10) {
                                    Image(systemName: "exclamationmark.octagon.fill")
                                        .font(.system(size: 15))
                                        .foregroundStyle(Color(red: 255/255, green: 90/255, blue: 90/255))
                                    Text(error)
                                        .font(.system(size: 13, weight: .medium))
                                        .foregroundStyle(Color(red: 255/255, green: 220/255, blue: 220/255))
                                    Spacer()
                                }
                                .padding(12)
                                .background(Color(red: 255/255, green: 50/255, blue: 50/255).opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.red.opacity(0.4), lineWidth: 1)
                                )
                            }
                            
                            // MARK: - NÚT ĐĂNG NHẬP NỔI BẬT (ELECTRIC BLUE GRADIENT CTA)
                            HStack(spacing: 12) {
                                Button {
                                    handleLogin()
                                } label: {
                                    HStack(spacing: 10) {
                                        if viewModel.isLoading {
                                            ProgressView()
                                                .tint(.white)
                                        } else {
                                            Text("ĐĂNG NHẬP")
                                                .font(.system(size: 14, weight: .bold))
                                                .tracking(2)
                                                .foregroundStyle(.white)
                                            
                                            Image(systemName: "arrow.right")
                                                .font(.system(size: 13, weight: .bold))
                                                .foregroundStyle(.white)
                                        }
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 16)
                                    .background(
                                        LinearGradient(
                                            colors: viewModel.isFormValid
                                                ? [Color(red: 0/255, green: 130/255, blue: 255/255), Color(red: 0/255, green: 90/255, blue: 230/255)]
                                                : [Color(red: 0/255, green: 130/255, blue: 255/255).opacity(0.45), Color(red: 0/255, green: 90/255, blue: 230/255).opacity(0.45)],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                                            .stroke(Color.white.opacity(viewModel.isFormValid ? 0.35 : 0.1), lineWidth: 1)
                                    )
                                    .shadow(color: viewModel.isFormValid ? Color(red: 0/255, green: 120/255, blue: 255/255).opacity(0.45) : .clear, radius: 12, x: 0, y: 4)
                                }
                                .disabled(viewModel.isLoading || !viewModel.isFormValid)
                                
                                // Phím nhanh Face ID / Sinh trắc học
                                Button {
                                    // Xác thực sinh trắc học Face ID
                                } label: {
                                    Image(systemName: "faceid")
                                        .font(.system(size: 22, weight: .regular))
                                        .foregroundStyle(Color.cyan)
                                        .frame(width: 52, height: 52)
                                        .background(Color(red: 24/255, green: 32/255, blue: 54/255).opacity(0.75))
                                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                        )
                                }
                                .buttonStyle(.plain)
                            }
                            .padding(.top, 8)
                        }
                        .padding(.horizontal, 24)
                        
                        Spacer(minLength: 36)
                        
                        // MARK: - FOOTER RÕ RÀNG
                        VStack(spacing: 6) {
                            Text("MTPRO AUTOMOTIVE • GARAGE WORKSPACE")
                                .font(.system(size: 10, weight: .bold))
                                .tracking(2)
                                .foregroundStyle(Color.white.opacity(0.55))
                            
                            Text("PHIÊN BẢN 1.0.0 • BẢO MẬT BỞI SSL")
                                .font(.system(size: 9, weight: .medium))
                                .tracking(1.5)
                                .foregroundStyle(Color.white.opacity(0.35))
                        }
                        .padding(.bottom, 20)
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

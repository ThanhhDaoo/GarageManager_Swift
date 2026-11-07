import SwiftUI

public struct LoginView: View {
    @Environment(\.colorScheme) private var colorScheme
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
                // MARK: - 1. NỀN ĐỘNG TOÀN MÀN HÌNH (FULL-SCREEN AMBIENT MESH)
                AnimatedBackgroundView()
                
                // MARK: - 2. NỘI DUNG ĐĂNG NHẬP
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 28) {
                        Spacer(minLength: 40)
                        
                        // Header & Logo thương hiệu tối giản, chuyên nghiệp
                        VStack(spacing: 12) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .fill(
                                        LinearGradient(
                                            colors: [
                                                Color(red: 25/255, green: 90/255, blue: 245/255),
                                                Color(red: 10/255, green: 50/255, blue: 190/255)
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 68, height: 68)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                                            .stroke(Color.white.opacity(0.25), lineWidth: 1)
                                    )
                                    .shadow(color: Color.blue.opacity(0.3), radius: 14, x: 0, y: 7)
                                
                                Image(systemName: "car.fill")
                                    .font(.system(size: 30, weight: .semibold))
                                    .foregroundStyle(.white)
                            }
                            
                            VStack(spacing: 4) {
                                Text("MTPro Auto")
                                    .font(.system(size: 26, weight: .bold))
                                    .foregroundStyle(colorScheme == .dark ? Color.white : Color.brandNavy)
                                
                                Text("Hệ Thống Quản Lý Gara Ô Tô")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        
                        // MARK: - 3. KHUNG FORM KÍNH MỜ (FROSTED GLASS CARD)
                        VStack(spacing: 18) {
                            // Email Field
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Tài khoản / Email")
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .foregroundStyle(.secondary)
                                
                                HStack(spacing: 12) {
                                    Image(systemName: "envelope.fill")
                                        .foregroundStyle(.blue)
                                        .frame(width: 20)
                                    
                                    TextField("admin@mtpro.vn", text: $viewModel.email)
                                        .keyboardType(.emailAddress)
                                        .textInputAutocapitalization(.never)
                                        .autocorrectionDisabled(true)
                                        .focused($focusedField, equals: .email)
                                        .submitLabel(.next)
                                        .onSubmit {
                                            focusedField = .password
                                        }
                                }
                                .padding(.horizontal, 14)
                                .padding(.vertical, 13)
                                .background(Color(.systemBackground).opacity(colorScheme == .dark ? 0.6 : 0.85))
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                                        .stroke(focusedField == .email ? Color.blue : Color.white.opacity(0.15), lineWidth: 1.5)
                                )
                            }
                            
                            // Password Field
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Mật khẩu")
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .foregroundStyle(.secondary)
                                
                                HStack(spacing: 12) {
                                    Image(systemName: "lock.fill")
                                        .foregroundStyle(.blue)
                                        .frame(width: 20)
                                    
                                    Group {
                                        if viewModel.isPasswordVisible {
                                            TextField("Nhập mật khẩu", text: $viewModel.password)
                                        } else {
                                            SecureField("Nhập mật khẩu", text: $viewModel.password)
                                        }
                                    }
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
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                .padding(.horizontal, 14)
                                .padding(.vertical, 13)
                                .background(Color(.systemBackground).opacity(colorScheme == .dark ? 0.6 : 0.85))
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                                        .stroke(focusedField == .password ? Color.blue : Color.white.opacity(0.15), lineWidth: 1.5)
                                )
                            }
                            
                            // Remember Me & Forgot Password
                            HStack {
                                Toggle("Ghi nhớ đăng nhập", isOn: $viewModel.rememberMe)
                                    .toggleStyle(CheckboxToggleStyle())
                                    .font(.footnote)
                                    .foregroundStyle(.secondary)
                                
                                Spacer()
                                
                                Button("Quên mật khẩu?") {
                                    // Action quên mật khẩu
                                }
                                .font(.footnote)
                                .foregroundStyle(.blue)
                            }
                            .padding(.horizontal, 2)
                            
                            // Error Banner
                            if let error = viewModel.errorMessage {
                                HStack(spacing: 8) {
                                    Image(systemName: "exclamationmark.triangle.fill")
                                        .foregroundStyle(.red)
                                    Text(error)
                                        .font(.caption)
                                        .foregroundStyle(.red)
                                    Spacer()
                                }
                                .padding(10)
                                .background(Color.red.opacity(0.12))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                            
                            // Nút Đăng nhập
                            Button {
                                handleLogin()
                            } label: {
                                HStack(spacing: 8) {
                                    if viewModel.isLoading {
                                        ProgressView()
                                            .tint(.white)
                                    } else {
                                        Text("Đăng Nhập")
                                            .fontWeight(.semibold)
                                        Image(systemName: "arrow.right")
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(viewModel.isFormValid ? Color.blue : Color.blue.opacity(0.5))
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                .shadow(color: Color.blue.opacity(viewModel.isFormValid ? 0.3 : 0), radius: 8, x: 0, y: 4)
                            }
                            .disabled(viewModel.isLoading || !viewModel.isFormValid)
                            .padding(.top, 4)
                        }
                        .padding(22)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 24, style: .continuous)
                                .stroke(Color.white.opacity(colorScheme == .dark ? 0.18 : 0.6), lineWidth: 1)
                        )
                        .shadow(color: Color.black.opacity(colorScheme == .dark ? 0.35 : 0.06), radius: 20, x: 0, y: 10)
                        
                        Spacer(minLength: 28)
                        
                        // MARK: - 4. FOOTER
                        VStack(spacing: 4) {
                            HStack(spacing: 4) {
                                Image(systemName: "shield.checkmark.fill")
                                    .font(.caption2)
                                    .foregroundStyle(.green)
                                Text("Bảo mật bởi Supabase PostgreSQL")
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                            }
                            Text("Phiên bản 1.0.0 • MTPro Garage System")
                                .font(.caption2)
                                .foregroundStyle(.secondary.opacity(0.8))
                        }
                        .padding(.bottom, 20)
                    }
                    .padding(.horizontal, 22)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
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

/// Style tùy chỉnh cho Checkbox Toggle chuẩn iOS
private struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            HStack(spacing: 8) {
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .foregroundStyle(configuration.isOn ? .blue : .secondary)
                configuration.label
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    LoginView()
        .environment(AppNavigationState())
}

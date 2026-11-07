import SwiftUI

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
            ScrollView {
                VStack(spacing: 24) {
                    // MARK: - 1. LOGO ĐỘNG & BRANDING HEADER
                    VStack(spacing: 8) {
                        AnimatedGarageLogo()
                            .padding(.top, 8)
                        
                        VStack(spacing: 4) {
                            Text("MTPro Auto")
                                .font(.system(size: 26, weight: .bold))
                                .foregroundStyle(Color.brandNavy)
                            
                            Text("Hệ Thống Quản Lý Gara Ô Tô")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    // MARK: - 2. KHUNG NHẬP LIỆU (LOGIN FORM)
                    VStack(spacing: 16) {
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
                            .padding(.vertical, 14)
                            .background(Color(.secondarySystemGroupedBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(focusedField == .email ? Color.blue : Color.clear, lineWidth: 1.5)
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
                            .padding(.vertical, 14)
                            .background(Color(.secondarySystemGroupedBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(focusedField == .password ? Color.blue : Color.clear, lineWidth: 1.5)
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
                            .background(Color.red.opacity(0.1))
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
                            .shadow(color: Color.blue.opacity(viewModel.isFormValid ? 0.25 : 0), radius: 8, x: 0, y: 4)
                        }
                        .disabled(viewModel.isLoading || !viewModel.isFormValid)
                        .padding(.top, 4)
                    }
                    .padding(20)
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 5)
                    
                    Spacer(minLength: 24)
                    
                    // MARK: - 3. FOOTER
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
                            .foregroundStyle(.tertiary)
                    }
                    .padding(.bottom, 16)
                }
                .padding(.horizontal, 20)
            }
            .background(Color(.systemGroupedBackground))
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

import SwiftUI

/// Background động toàn màn hình dạng Ambient Fluid Mesh
/// Tạo chuyển động ánh sáng mượt mà, sang trọng, chuẩn giao diện ứng dụng cao cấp
public struct AnimatedBackgroundView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var startAnimation = false
    
    public init() {}
    
    public var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let isDark = colorScheme == .dark
            
            ZStack {
                // 1. Nền cơ sở
                (isDark
                    ? Color(red: 12/255, green: 16/255, blue: 28/255)
                    : Color(red: 242/255, green: 245/255, blue: 252/255)
                )
                .ignoresSafeArea()
                
                // 2. Các khối cầu ánh sáng động (Fluid Ambient Orbs)
                // Orb 1: Xanh Sapphire / Royal Blue (Góc trên trái)
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                (isDark ? Color(red: 30/255, green: 90/255, blue: 240/255) : Color(red: 60/255, green: 130/255, blue: 250/255)).opacity(isDark ? 0.45 : 0.35),
                                Color.clear
                            ],
                            center: .center,
                            startRadius: 0,
                            endRadius: size.width * 0.45
                        )
                    )
                    .frame(width: size.width * 0.9, height: size.width * 0.9)
                    .offset(
                        x: startAnimation ? -size.width * 0.2 : size.width * 0.1,
                        y: startAnimation ? -size.height * 0.25 : -size.height * 0.15
                    )
                    .scaleEffect(startAnimation ? 1.15 : 0.9)
                    .blur(radius: 50)
                
                // Orb 2: Xanh Cyan / Điện quang (Khu vực giữa & phải)
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                (isDark ? Color(red: 0/255, green: 170/255, blue: 240/255) : Color(red: 0/255, green: 190/255, blue: 230/255)).opacity(isDark ? 0.35 : 0.25),
                                Color.clear
                            ],
                            center: .center,
                            startRadius: 0,
                            endRadius: size.width * 0.4
                        )
                    )
                    .frame(width: size.width * 0.8, height: size.width * 0.8)
                    .offset(
                        x: startAnimation ? size.width * 0.25 : -size.width * 0.1,
                        y: startAnimation ? size.height * 0.05 : -size.height * 0.05
                    )
                    .scaleEffect(startAnimation ? 0.95 : 1.2)
                    .blur(radius: 60)
                
                // Orb 3: Chàm Indigo / Tím than (Góc dưới)
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                (isDark ? Color(red: 90/255, green: 50/255, blue: 210/255) : Color(red: 130/255, green: 100/255, blue: 240/255)).opacity(isDark ? 0.35 : 0.2),
                                Color.clear
                            ],
                            center: .center,
                            startRadius: 0,
                            endRadius: size.width * 0.5
                        )
                    )
                    .frame(width: size.width * 0.95, height: size.width * 0.95)
                    .offset(
                        x: startAnimation ? -size.width * 0.15 : size.width * 0.2,
                        y: startAnimation ? size.height * 0.3 : size.height * 0.2
                    )
                    .scaleEffect(startAnimation ? 1.2 : 0.9)
                    .blur(radius: 55)
                
                // Orb 4: Điểm nhấn ánh kim Hổ phách nhẹ (Warm Ember Accent)
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                (isDark ? Color(red: 255/255, green: 140/255, blue: 40/255) : Color(red: 255/255, green: 170/255, blue: 70/255)).opacity(isDark ? 0.2 : 0.15),
                                Color.clear
                            ],
                            center: .center,
                            startRadius: 0,
                            endRadius: size.width * 0.3
                        )
                    )
                    .frame(width: size.width * 0.6, height: size.width * 0.6)
                    .offset(
                        x: startAnimation ? size.width * 0.15 : -size.width * 0.2,
                        y: startAnimation ? -size.height * 0.05 : size.height * 0.15
                    )
                    .blur(radius: 45)
                
                // 3. Lớp phủ kính mờ làm dịu chuyển động (Subtle Glass Veil)
                Rectangle()
                    .fill(.ultraThinMaterial.opacity(isDark ? 0.25 : 0.45))
                    .ignoresSafeArea()
            }
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.easeInOut(duration: 8).repeatForever(autoreverses: true)) {
                startAnimation = true
            }
        }
    }
}

#Preview {
    AnimatedBackgroundView()
}

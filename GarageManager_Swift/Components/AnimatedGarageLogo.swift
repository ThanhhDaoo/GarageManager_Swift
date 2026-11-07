import SwiftUI

/// Component Logo động xe / gara với hiệu ứng ánh sáng, vòng xoay công nghệ và chuyển động mượt mà
public struct AnimatedGarageLogo: View {
    @State private var isRotating = false
    @State private var isPulsing = false
    @State private var isFloating = false
    
    public init() {}
    
    public var body: some View {
        ZStack {
            // 1. Vòng hào quang phát sáng thở nhịp nhàng (Ambient Breathing Glow)
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color.blue.opacity(0.35),
                            Color.cyan.opacity(0.15),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 20,
                        endRadius: 65
                    )
                )
                .frame(width: 130, height: 130)
                .scaleEffect(isPulsing ? 1.15 : 0.95)
                .opacity(isPulsing ? 0.9 : 0.5)
            
            // 2. Vòng xoay bánh răng công nghệ nét đứt (Rotating Orbit Gauge)
            Circle()
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [
                            Color.blue.opacity(0.8),
                            Color.cyan,
                            Color.blue.opacity(0.1),
                            Color.blue.opacity(0.8)
                        ]),
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: 2.5, lineCap: .round, dash: [8, 6])
                )
                .frame(width: 96, height: 96)
                .rotationEffect(.degrees(isRotating ? 360 : 0))
            
            // 3. Khối huy hiệu trung tâm kính mờ cao cấp (Glassmorphic Center Badge)
            ZStack {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 25/255, green: 85/255, blue: 255/255),
                                Color(red: 10/255, green: 40/255, blue: 180/255)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 76, height: 76)
                    .shadow(color: Color.blue.opacity(0.4), radius: 14, x: 0, y: 8)
                
                // Viền ánh sáng specular highlight
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .stroke(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.6),
                                Color.white.opacity(0.1),
                                Color.clear
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1.2
                    )
                    .frame(width: 76, height: 76)
                
                // 4. Icon xe & công cụ ô tô nổi bồng bềnh (Floating Center Vehicle)
                VStack(spacing: 3) {
                    Image(systemName: "car.side.fill")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(.white)
                    
                    HStack(spacing: 4) {
                        Image(systemName: "wrench.fill")
                            .font(.system(size: 10))
                        Image(systemName: "gauge.with.dots.needle.bottom.50percent")
                            .font(.system(size: 10))
                    }
                    .foregroundStyle(Color.cyan.opacity(0.9))
                }
                .offset(y: isFloating ? -2.5 : 2.5)
            }
        }
        .frame(width: 130, height: 130)
        .onAppear {
            withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
                isRotating = true
            }
            withAnimation(.easeInOut(duration: 2.2).repeatForever(autoreverses: true)) {
                isPulsing = true
            }
            withAnimation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true)) {
                isFloating = true
            }
        }
    }
}

#Preview {
    ZStack {
        Color(.systemGroupedBackground)
            .ignoresSafeArea()
        AnimatedGarageLogo()
    }
}

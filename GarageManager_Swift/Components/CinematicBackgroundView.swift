import SwiftUI

/// Nền động điện ảnh cao cấp (Cinematic Luxury Dark)
/// Độ sáng & tương phản được cân chỉnh hoàn hảo: Nền xanh Midnight Obsidian,
/// vệt sáng khí động học LED neon rực rỡ, không bị tối đen làm mờ nội dung.
public struct CinematicBackgroundView: View {
    @State private var phase: CGFloat = 0
    @State private var beamPulse: Bool = false
    
    public init() {}
    
    public var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            ZStack {
                // 1. Nền chuyển sắc Midnight Navy sâu thẳm, có chiều sâu ánh sáng
                LinearGradient(
                    stops: [
                        .init(color: Color(red: 14/255, green: 20/255, blue: 36/255), location: 0.0),
                        .init(color: Color(red: 20/255, green: 28/255, blue: 48/255), location: 0.4),
                        .init(color: Color(red: 12/255, green: 16/255, blue: 28/255), location: 1.0)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                // 2. Vầng hào quang ánh sáng trung tâm & đỉnh rực rỡ (Luminous Ambient Aura)
                RadialGradient(
                    colors: [
                        Color(red: 30/255, green: 110/255, blue: 255/255).opacity(beamPulse ? 0.35 : 0.22),
                        Color(red: 10/255, green: 40/255, blue: 120/255).opacity(0.12),
                        Color.clear
                    ],
                    center: .top,
                    startRadius: 20,
                    endRadius: size.height * 0.65
                )
                .ignoresSafeArea()
                
                // Quầng sáng ấm bổ trợ phía sau form giúp các trường nhập liệu nổi bật rõ ràng
                RadialGradient(
                    colors: [
                        Color(red: 0/255, green: 140/255, blue: 255/255).opacity(0.15),
                        Color.clear
                    ],
                    center: .center,
                    startRadius: 10,
                    endRadius: size.width * 0.7
                )
                .ignoresSafeArea()
                
                // 3. Vệt sáng LED khí động học uốn lượn (Aerodynamic LED Horizon Curve)
                Path { path in
                    path.move(to: CGPoint(x: -size.width * 0.2, y: size.height * 0.25))
                    path.addCurve(
                        to: CGPoint(x: size.width * 1.2, y: size.height * 0.21),
                        control1: CGPoint(x: size.width * 0.35, y: size.height * 0.29),
                        control2: CGPoint(x: size.width * 0.75, y: size.height * 0.17)
                    )
                }
                .stroke(
                    LinearGradient(
                        stops: [
                            .init(color: .clear, location: 0.0),
                            .init(color: Color.cyan.opacity(0.2), location: 0.2),
                            .init(color: Color.white.opacity(beamPulse ? 0.8 : 0.45), location: 0.5),
                            .init(color: Color.cyan.opacity(0.4), location: 0.7),
                            .init(color: .clear, location: 1.0)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    lineWidth: 2
                )
                .offset(y: beamPulse ? -6 : 6)
                
                // Glow lan toả của dải LED
                Path { path in
                    path.move(to: CGPoint(x: -size.width * 0.2, y: size.height * 0.25))
                    path.addCurve(
                        to: CGPoint(x: size.width * 1.2, y: size.height * 0.21),
                        control1: CGPoint(x: size.width * 0.35, y: size.height * 0.29),
                        control2: CGPoint(x: size.width * 0.75, y: size.height * 0.17)
                    )
                }
                .stroke(
                    Color(red: 0/255, green: 160/255, blue: 255/255).opacity(beamPulse ? 0.4 : 0.2),
                    lineWidth: 20
                )
                .blur(radius: 12)
                .offset(y: beamPulse ? -6 : 6)
                
                // 4. Vệt quét ánh kim (Metallic Sheen Sweep)
                Rectangle()
                    .fill(
                        LinearGradient(
                            stops: [
                                .init(color: .clear, location: 0.0),
                                .init(color: Color.white.opacity(0.05), location: 0.48),
                                .init(color: Color.cyan.opacity(0.08), location: 0.5),
                                .init(color: Color.white.opacity(0.04), location: 0.52),
                                .init(color: .clear, location: 1.0)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .rotationEffect(.degrees(25))
                    .scaleEffect(1.6)
                    .offset(x: phase)
                    .ignoresSafeArea()
            }
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.easeInOut(duration: 5.5).repeatForever(autoreverses: true)) {
                beamPulse.toggle()
            }
            withAnimation(.linear(duration: 14).repeatForever(autoreverses: false)) {
                phase = 600
            }
        }
    }
}

#Preview {
    CinematicBackgroundView()
}

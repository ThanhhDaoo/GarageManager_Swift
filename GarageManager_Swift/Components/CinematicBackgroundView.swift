import SwiftUI

/// Nền động điện ảnh cao cấp (Cinematic Luxury Dark)
/// Phong cách siêu xe (Porsche / Tesla / Polestar): Nền đen Obsidian sâu,
/// hiệu ứng vệt sáng đèn LED khí động học uốn lượn và ánh sáng kim loại sang trọng.
public struct CinematicBackgroundView: View {
    @State private var phase: CGFloat = 0
    @State private var beamPulse: Bool = false
    
    public init() {}
    
    public var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            ZStack {
                // 1. Nền đen sâu Obsidian đa tầng
                LinearGradient(
                    stops: [
                        .init(color: Color(red: 5/255, green: 7/255, blue: 11/255), location: 0.0),
                        .init(color: Color(red: 11/255, green: 14/255, blue: 22/255), location: 0.45),
                        .init(color: Color(red: 6/255, green: 8/255, blue: 12/255), location: 1.0)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                // 2. Ánh sáng sân khấu studio siêu xe từ đỉnh (Overhead Studio Rim Light)
                RadialGradient(
                    colors: [
                        Color(red: 30/255, green: 80/255, blue: 200/255).opacity(beamPulse ? 0.28 : 0.16),
                        Color(red: 15/255, green: 35/255, blue: 90/255).opacity(0.08),
                        Color.clear
                    ],
                    center: .top,
                    startRadius: 10,
                    endRadius: size.height * 0.55
                )
                .ignoresSafeArea()
                
                // 3. Lưới kỹ thuật carbon ma trận chìm siêu thực (Subtle Carbon Grid lines)
                Canvas { context, canvasSize in
                    let step: CGFloat = 40
                    var path = Path()
                    
                    // Kẻ các đường ngang mảnh với độ mờ cực thấp
                    var y: CGFloat = 0
                    while y < canvasSize.height {
                        path.move(to: CGPoint(x: 0, y: y))
                        path.addLine(to: CGPoint(x: canvasSize.width, y: y))
                        y += step
                    }
                    
                    // Kẻ các đường dọc mảnh
                    var x: CGFloat = 0
                    while x < canvasSize.width {
                        path.move(to: CGPoint(x: x, y: 0))
                        path.addLine(to: CGPoint(x: x, y: canvasSize.height))
                        x += step
                    }
                    
                    context.stroke(path, with: .color(Color.white.opacity(0.018)), lineWidth: 0.5)
                }
                .ignoresSafeArea()
                
                // 4. Vệt sáng LED khí động học uốn lượn (Aerodynamic LED Horizon Curve)
                Path { path in
                    path.move(to: CGPoint(x: -size.width * 0.2, y: size.height * 0.28))
                    path.addCurve(
                        to: CGPoint(x: size.width * 1.2, y: size.height * 0.24),
                        control1: CGPoint(x: size.width * 0.35, y: size.height * 0.32),
                        control2: CGPoint(x: size.width * 0.75, y: size.height * 0.20)
                    )
                }
                .stroke(
                    LinearGradient(
                        stops: [
                            .init(color: .clear, location: 0.0),
                            .init(color: Color(red: 40/255, green: 140/255, blue: 255/255).opacity(0.1), location: 0.2),
                            .init(color: Color.white.opacity(beamPulse ? 0.45 : 0.2), location: 0.5),
                            .init(color: Color(red: 40/255, green: 140/255, blue: 255/255).opacity(0.25), location: 0.7),
                            .init(color: .clear, location: 1.0)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    lineWidth: 1.5
                )
                .blur(radius: 0.5)
                .offset(y: beamPulse ? -6 : 6)
                
                // Glow lan toả của dải LED
                Path { path in
                    path.move(to: CGPoint(x: -size.width * 0.2, y: size.height * 0.28))
                    path.addCurve(
                        to: CGPoint(x: size.width * 1.2, y: size.height * 0.24),
                        control1: CGPoint(x: size.width * 0.35, y: size.height * 0.32),
                        control2: CGPoint(x: size.width * 0.75, y: size.height * 0.20)
                    )
                }
                .stroke(
                    Color(red: 30/255, green: 120/255, blue: 255/255).opacity(beamPulse ? 0.3 : 0.12),
                    lineWidth: 18
                )
                .blur(radius: 14)
                .offset(y: beamPulse ? -6 : 6)
                
                // 5. Luồng ánh sáng kim loại quét ngang chậm rãi (Metallic Sheen Sweep)
                Rectangle()
                    .fill(
                        LinearGradient(
                            stops: [
                                .init(color: .clear, location: 0.0),
                                .init(color: Color.white.opacity(0.03), location: 0.45),
                                .init(color: Color.cyan.opacity(0.04), location: 0.5),
                                .init(color: Color.white.opacity(0.02), location: 0.55),
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
                
                // 6. Vignette làm tối 4 góc màn hình tăng độ tập trung điện ảnh
                RadialGradient(
                    colors: [
                        Color.clear,
                        Color.black.opacity(0.65)
                    ],
                    center: .center,
                    startRadius: size.width * 0.5,
                    endRadius: size.height * 0.8
                )
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

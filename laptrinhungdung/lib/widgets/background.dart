import 'package:flutter/material.dart';

/// 🌊 Nền gradient + sóng + bóng tròn, có thể tái sử dụng toàn app
class WaveBackground extends StatelessWidget {
  final Widget? child;
  const WaveBackground({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Vẽ nền gradient và sóng
        Positioned.fill(
          child: CustomPaint(
            painter: _WavesPainter(),
          ),
        ),

        // Các bong bóng trang trí (đặt chung ở đây)
        const _Bubble(
          left: -18,
          top: 8,
          diameter: 64,
          dark: true,
        ),
        const _Bubble(
          right: 24,
          top: 48,
          diameter: 72,
        ),
        const _Bubble(
          left: 28,
          top: 300,
          diameter: 42,
        ),
        const _Bubble(
          left: 120,
          bottom: 120,
          diameter: 110,
        ),

        // Nội dung của từng màn hình
        if (child != null) child!,
      ],
    );
  }
}

/// 🎨 Vẽ nền gradient + các đường sóng
class _WavesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // Nền gradient
    final base = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF0E2A59),
          Color.fromARGB(255, 17, 50, 99),
        ],
      ).createShader(rect);
    canvas.drawRect(rect, base);

    // Sóng 1
    final wave1 = Paint()
      ..color = const Color(0x334B6CA7);
    final p2 = Path()
      ..moveTo(0, size.height * 0.30)
      ..quadraticBezierTo(
        size.width * 0.45,
        size.height * 0.38,
        size.width * 0.62,
        size.height * 0.55,
      )
      ..quadraticBezierTo(
        size.width * 0.78,
        size.height * 0.72,
        size.width,
        size.height * 0.68,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(p2, wave1);

    // Sóng 2
    final wave2 = Paint()
      ..color = const Color(0x33405C8C);
    final p3 = Path()
      ..moveTo(0, size.height * 0.50)
      ..quadraticBezierTo(
        size.width * 0.28,
        size.height * 0.40,
        size.width * 0.50,
        size.height * 0.63,
      )
      ..quadraticBezierTo(
        size.width * 0.72,
        size.height * 0.86,
        size.width,
        size.height * 0.78,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(p3, wave2);
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) => false;
}

/// 🔵 Bubble tròn có gradient + đổ bóng (đặt chung trong nền)
class _Bubble extends StatelessWidget {
  const _Bubble({
    super.key,
    this.left,
    this.right,
    this.top,
    this.bottom,
    required this.diameter,
    this.dark = false,
  });

  final double? left, right, top, bottom;
  final double diameter;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            center: const Alignment(-0.3, -0.3),
            radius: 0.9,
            colors: dark
                ? const [
                    Color(0xFF18305B),
                    Color(0xFF0E2147),
                  ]
                : const [
                    Color(0xFFE9F2FF),
                    Color(0xFF6BA5FF),
                  ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(
                0.25,
              ),
              blurRadius: 16,
              offset: const Offset(6, 8),
            ),
          ],
        ),
      ),
    );
  }
}

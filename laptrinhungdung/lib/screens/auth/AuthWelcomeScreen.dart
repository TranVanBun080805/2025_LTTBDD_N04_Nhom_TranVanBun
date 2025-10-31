import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import '../../widgets/background.dart';

class AuthWelcomeScreen extends StatelessWidget {
  const AuthWelcomeScreen({super.key});

  void _slideTo(
    BuildContext context,
    Widget page, {
    bool reverse = false,
  }) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(
          milliseconds: 500,
        ),
        pageBuilder: (_, animation, __) =>
            SlideTransition(
              position:
                  Tween<Offset>(
                    begin: Offset(
                      reverse ? -1 : 1,
                      0,
                    ),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeInOut,
                    ),
                  ),
              child: page,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: WaveBackground(
        child: Stack(
          children: [
            Align(
              alignment: const Alignment(
                0,
                -0.30,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Chào Mừng',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize:
                          size.width * 0.085,
                      fontWeight: FontWeight.w700,
                      color: Colors.white
                          .withOpacity(0.95),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Lập quản lý chi tiêu\nTiết kiệm cho bản thân mình',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize:
                          size.width * 0.035,
                      height: 1.3,
                      color: Colors.white
                          .withOpacity(0.85),
                    ),
                  ),
                  const SizedBox(height: 40),
                  LayoutBuilder(
                    builder:
                        (context, constraints) {
                          final screenHeight =
                              MediaQuery.sizeOf(
                                context,
                              ).height;
                          final logoHeight =
                              screenHeight * 0.45;
                          final logoWidth =
                              constraints
                                  .maxWidth *
                              0.65;
                          return Image.asset(
                            'imgs/LogoMobile.png',
                            height: logoHeight
                                .clamp(120, 220),
                            width: logoWidth
                                .clamp(140, 260),
                            fit: BoxFit.contain,
                          );
                        },
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _BottomSwitcher(
                onSignIn: () => _slideTo(
                  context,
                  const LoginScreen(),
                  reverse: true,
                ),
                onSignUp: () => _slideTo(
                  context,
                  const RegisterScreen(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomSwitcher extends StatefulWidget {
  const _BottomSwitcher({
    required this.onSignIn,
    required this.onSignUp,
  });

  final VoidCallback onSignIn;
  final VoidCallback onSignUp;

  @override
  State<_BottomSwitcher> createState() =>
      _BottomSwitcherState();
}

class _BottomSwitcherState
    extends State<_BottomSwitcher> {
  bool _hoverSignIn = false;
  bool _hoverSignUp = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      decoration: BoxDecoration(
        color: const Color(0xFF102A54),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Expanded(
            child: MouseRegion(
              onEnter: (_) => setState(
                () => _hoverSignIn = true,
              ),
              onExit: (_) => setState(
                () => _hoverSignIn = false,
              ),
              child: InkWell(
                onTap: widget.onSignIn,
                borderRadius:
                    const BorderRadius.only(
                      topLeft: Radius.circular(
                        26,
                      ),
                      bottomLeft: Radius.circular(
                        26,
                      ),
                    ),
                child: AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 250,
                  ),
                  decoration: BoxDecoration(
                    color: _hoverSignIn
                        ? Colors.white
                              .withOpacity(0.15)
                        : Colors.transparent,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Đăng Nhập',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: MouseRegion(
              onEnter: (_) => setState(
                () => _hoverSignUp = true,
              ),
              onExit: (_) => setState(
                () => _hoverSignUp = false,
              ),
              child: InkWell(
                onTap: widget.onSignUp,
                borderRadius:
                    const BorderRadius.only(
                      topRight: Radius.circular(
                        26,
                      ),
                      bottomRight:
                          Radius.circular(26),
                    ),
                child: AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 300,
                  ),
                  decoration: BoxDecoration(
                    color: _hoverSignUp
                        ? Colors.white
                        : Colors.transparent,
                    borderRadius:
                        const BorderRadius.only(
                          topRight:
                              Radius.circular(26),
                          bottomRight:
                              Radius.circular(26),
                        ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Đăng Ký',
                    style: TextStyle(
                      color: _hoverSignUp
                          ? const Color(
                              0xFF1E2A78,
                            )
                          : Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

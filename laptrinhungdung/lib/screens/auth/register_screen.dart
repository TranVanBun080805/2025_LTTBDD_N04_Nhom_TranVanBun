import 'package:flutter/material.dart';
import '../../widgets/background.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends State<RegisterScreen> {
  final fullNameController =
      TextEditingController();
  final emailController = TextEditingController();
  final passwordController =
      TextEditingController();
  bool agreePolicy = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WaveBackground(
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 16,
                left: 16,
                child: IconButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(
                          Colors.white
                              .withOpacity(0.2),
                        ),
                    shape:
                        WidgetStateProperty.all(
                          const CircleBorder(),
                        ),
                  ),
                  onPressed: () =>
                      Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned.fill(
                top: 100,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 30,
                      ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(
                          topLeft:
                              Radius.circular(32),
                          topRight:
                              Radius.circular(32),
                        ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [
                        const Center(
                          child: Text(
                            "Chào mừng bắt đầu",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight:
                                  FontWeight.bold,
                              color: Color(
                                0xFF1E2A78,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextField(
                          controller:
                              fullNameController,
                          decoration: _inputStyle(
                            "Tên đầy đủ",
                            "Nhập tên của bạn",
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextField(
                          controller:
                              emailController,
                          keyboardType:
                              TextInputType
                                  .emailAddress,
                          decoration: _inputStyle(
                            "Email",
                            "Nhập email",
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextField(
                          controller:
                              passwordController,
                          obscureText: true,
                          decoration: _inputStyle(
                            "Mật khẩu",
                            "Nhập mật khẩu",
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: agreePolicy,
                              activeColor:
                                  const Color(
                                    0xFF1E2A78,
                                  ),
                              onChanged: (val) =>
                                  setState(
                                    () =>
                                        agreePolicy =
                                            val ??
                                            false,
                                  ),
                            ),
                            Expanded(
                              child: RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                    color: Colors
                                        .black87,
                                    fontSize:
                                        13.5,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          "Tôi đồng ý với ",
                                    ),
                                    TextSpan(
                                      text:
                                          "Điều khoản dịch vụ",
                                      style: TextStyle(
                                        color: Color(
                                          0xFF1E2A78,
                                        ),
                                        fontWeight:
                                            FontWeight
                                                .w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(
                                    0xFF1E2A78,
                                  ),
                              padding:
                                  const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(
                                      12,
                                    ),
                              ),
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Đăng ký thành công (demo)!",
                                  ),
                                ),
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const LoginScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Đăng ký",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight:
                                    FontWeight
                                        .bold,
                                color:
                                    Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const Center(
                          child: Text(
                            "Đăng ký với",
                            style: TextStyle(
                              color:
                                  Colors.black54,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .center,
                          children: [
                            _socialIcon(
                              "imgs/facebook.png",
                            ),
                            _socialIcon(
                              "imgs/twitter.png",
                            ),
                            _socialIcon(
                              "imgs/google.png",
                            ),
                            _socialIcon(
                              "imgs/apple.png",
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .center,
                          children: [
                            const Text(
                              "Bạn đã có tài khoản? ",
                              style: TextStyle(
                                color: Colors
                                    .black87,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(
                                          milliseconds:
                                              500,
                                        ),
                                    pageBuilder:
                                        (
                                          _,
                                          animation,
                                          __,
                                        ) => SlideTransition(
                                          position:
                                              Tween<
                                                    Offset
                                                  >(
                                                    begin: const Offset(
                                                      -1,
                                                      0,
                                                    ),
                                                    end: Offset.zero,
                                                  )
                                                  .animate(
                                                    CurvedAnimation(
                                                      parent: animation,
                                                      curve: Curves.easeInOut,
                                                    ),
                                                  ),
                                          child:
                                              const LoginScreen(),
                                        ),
                                  ),
                                );
                              },
                              child: const Text(
                                "Đăng nhập",
                                style: TextStyle(
                                  color: Color(
                                    0xFF1E2A78,
                                  ),
                                  fontWeight:
                                      FontWeight
                                          .w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputStyle(
    String label,
    String hint,
  ) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: const TextStyle(
        color: Colors.black54,
      ),
      hintStyle: const TextStyle(
        color: Colors.black38,
      ),
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Colors.grey.shade300,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFF1E2A78),
          width: 1.6,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
    );
  }

  Widget _socialIcon(String path) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {},
        child: Image.asset(
          path,
          height: 32,
          width: 32,
          fit: BoxFit.contain,
          errorBuilder:
              (context, error, stackTrace) {
                return const Icon(
                  Icons.error_outline,
                  color: Colors.redAccent,
                  size: 28,
                );
              },
        ),
      ),
    );
  }
}

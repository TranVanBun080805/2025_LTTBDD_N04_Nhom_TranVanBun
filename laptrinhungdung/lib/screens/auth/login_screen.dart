import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../widgets/background.dart';
import 'register_screen.dart';
import '../home/home_screen.dart';

final User = {
  'email': 'Tranbun05@gmail.com',
  'password': '12345678',
};

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController =
      TextEditingController();
  bool rememberMe = false;
  bool _obscurePassword = true;

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
                top: 120,
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
                        Center(
                          child: Text(
                            "welcome_back".tr(),
                            style:
                                const TextStyle(
                                  fontSize: 26,
                                  fontWeight:
                                      FontWeight
                                          .bold,
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
                              emailController,
                          decoration: _inputStyle(
                            "email_label".tr(),
                            "email_hint".tr(),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextField(
                          controller:
                              passwordController,
                          obscureText:
                              _obscurePassword,
                          decoration:
                              _inputStyle(
                                "password_label"
                                    .tr(),
                                "password_hint"
                                    .tr(),
                              ).copyWith(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons
                                              .visibility_off
                                        : Icons
                                              .visibility,
                                    color:
                                        _obscurePassword
                                        ? Colors
                                              .grey
                                        : const Color(
                                            0xFF1E2A78,
                                          ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword =
                                          !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: rememberMe,
                              onChanged:
                                  (bool? val) {
                                    setState(() {
                                      rememberMe =
                                          val ??
                                          false;
                                    });
                                  },
                              activeColor:
                                  const Color(
                                    0xFF1E2A78,
                                  ),
                            ),
                            Text(
                              "remember_me".tr(),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "forgot_password"
                                    .tr(),
                                style: const TextStyle(
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
                          height: 20,
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
                              final email =
                                  emailController
                                      .text
                                      .toUpperCase()
                                      .trim();
                              final password =
                                  passwordController
                                      .text
                                      .trim();

                              if (email ==
                                      User['email']
                                          ?.toUpperCase() &&
                                  password ==
                                      User['password']) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (
                                          context,
                                        ) =>
                                            const HomeScreen(),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "login_failed"
                                          .tr(),
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              "login_button".tr(),
                              style:
                                  const TextStyle(
                                    fontSize: 17,
                                    fontWeight:
                                        FontWeight
                                            .bold,
                                    color: Colors
                                        .white,
                                  ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Center(
                          child: Text(
                            "login_with".tr(),
                            style:
                                const TextStyle(
                                  color: Colors
                                      .black54,
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
                            Text(
                              "no_account".tr(),
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
                                                      1,
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
                                              const RegisterScreen(),
                                        ),
                                  ),
                                );
                              },
                              child: MouseRegion(
                                cursor:
                                    SystemMouseCursors
                                        .click,
                                child: Text(
                                  "sign_up".tr(),
                                  style: const TextStyle(
                                    color: Color(
                                      0xFF1E2A78,
                                    ),
                                    fontWeight:
                                        FontWeight
                                            .w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        borderSide: BorderSide(
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

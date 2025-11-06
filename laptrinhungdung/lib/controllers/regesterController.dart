import 'package:flutter/material.dart';
import '../screens/auth/login_screen.dart';

class Regestercontroller {
  final fulllNameController =
      TextEditingController();
  final emailController = TextEditingController();
  final passwordController =
      TextEditingController();
  bool agreePolicy = false;
  bool validateInputs(BuildContext context) {
    final fullName = fulllNameController.text
        .trim();
    final email = emailController.text.trim();
    final password = passwordController.text
        .trim();
    if (fullName.isEmpty ||
        email.isEmpty ||
        password.isEmpty) {
      print(
        'Full Name: $fullName, Email: $email, Password: $password',
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Vui lòng điền tất cả các trường thông tin.',
          ),
        ),
      );
      return false;
    }
    if (!RegExp(
      r'^[^@]+@[^@]+\.[^@]+',
    ).hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Vui lòng nhập địa chỉ email hợp lệ.',
          ),
        ),
      );
      return false;
    }
    if (password.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Mật khẩu phải có ít nhất 8 ký tự.',
          ),
        ),
      );
      return false;
    }
    if (!agreePolicy) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Bạn phải đồng ý với chính sách của chúng tôi.',
          ),
        ),
      );
      return false;
    }
    return true;
  }

  Future<void> register(
    BuildContext context,
  ) async {
    if (!validateInputs(context)) {
      return;
    }
    final fullName = fulllNameController.text
        .trim();
    final email = emailController.text.trim();
    final password = passwordController.text
        .trim();

    await Future.delayed(Duration(seconds: 1));
    _showSnackBar(
      context,
      'Đăng ký thành công cho $fullName với email $email.',
    );
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(
          milliseconds: 500,
        ),
        pageBuilder: (_, animation, __) =>
            SlideTransition(
              position:
                  Tween<Offset>(
                    begin: Offset(-1, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeInOut,
                    ),
                  ),
              child: LoginScreen(),
            ),
      ),
    );
  }

  void _showSnackBar(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void disposeControllers(
    Regestercontroller controller,
  ) {
    controller.fulllNameController.dispose();
    controller.emailController.dispose();
    controller.passwordController.dispose();
  }
}

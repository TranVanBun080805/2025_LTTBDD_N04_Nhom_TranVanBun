import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../auth/login_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = {
      'name': 'Trần Văn Bun',
      'email': '23010370@st.phenikaa-uni.edu.vn',
      'job':
          'Sinh viên CNTT - Phenikaa University',
      'avatar': 'imgs/avata.png',
    };

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FB),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Cài đặt'),
        backgroundColor: const Color(0xFF3A7BD5),
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          20,
          20,
          20,
          100,
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center,
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage(
                      user['avatar']!,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(
                      6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(
                        0xFF3A7BD5,
                      ),
                      borderRadius:
                          BorderRadius.circular(
                            12,
                          ),
                    ),
                    child: const Icon(
                      Icons.edit,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              user['name']!,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E355B),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              user['job']!,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey
                        .withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.email_outlined,
                    color: Color(0xFF3A7BD5),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      user['email']!,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF1E355B),
                        fontWeight:
                            FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _buildSettingTile(
              icon: Icons.person_outline,
              title: "Chỉnh sửa thông tin",
              onTap: () {},
            ),
            _buildSettingTile(
              icon: Icons.lock_outline,
              title: "Đổi mật khẩu",
              onTap: () {},
            ),
            _buildSettingTile(
              icon: Icons.notifications_none,
              title: "Thông báo",
              onTap: () {},
            ),
            _buildSettingTile(
              icon: Icons.history,
              title: "Lịch sử chi tiêu",
              onTap: () {},
            ),
            _buildSettingTile(
              icon: Icons.language_rounded,
              title: "Chọn ngôn ngữ",
              onTap: () =>
                  _showLanguageDialog(context),
            ),
            _buildSettingTile(
              icon: Icons.logout,
              title: "Đăng xuất",
              color: Colors.redAccent,
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const LoginScreen(),
                  ),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        title: const Text("Chọn ngôn ngữ"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Text(
                "🇻🇳",
                style: TextStyle(fontSize: 24),
              ),
              title: const Text("Tiếng Việt"),
              onTap: () {
                context.setLocale(
                  const Locale('vi', 'VN'),
                );
                Navigator.pop(ctx);
                _showSnack(
                  context,
                  "Đã chuyển sang Tiếng Việt 🇻🇳",
                );
              },
            ),
            ListTile(
              leading: const Text(
                "🇬🇧",
                style: TextStyle(fontSize: 24),
              ),
              title: const Text("Tiếng Anh"),
              onTap: () {
                context.setLocale(
                  const Locale('en', 'US'),
                );
                Navigator.pop(ctx);
                _showSnack(
                  context,
                  "Đã chuyển sang Tiếng Anh",
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showSnack(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF3A7BD5),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = const Color(0xFF1E355B),
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(
          title,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
        ),
        onTap: onTap,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'auth/AuthWelcomeScreen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() =>
      _IntroScreenState();
}

class _IntroScreenState
    extends State<IntroScreen> {
  final PageController _pageController =
      PageController();
  int currentPage = 0;

  // 🔹 Chỉ lưu key, không gọi .tr() trước
  final List<Map<String, String>> pages = [
    {
      'image': 'imgs/tietKiem.png',
      'title': 'intro_title_1',
      'desc': 'intro_desc_1',
    },
    {
      'image': 'imgs/quanLyChiTieu.png',
      'title': 'intro_title_2',
      'desc': 'intro_desc_2',
    },
    {
      'image': 'imgs/baoMat.png',
      'title': 'intro_title_3',
      'desc': 'intro_desc_3',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // 🔹 Hình tròn nền trang trí
            Positioned(
              bottom: -100,
              left: -50,
              child: Container(
                width: 400,
                height: 400,
                decoration: const BoxDecoration(
                  color: Color(0xFFF6F7FB),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // 🔹 PageView ở dưới cùng để không che nút
            PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(
                  () => currentPage = index,
                );
              },
              itemCount: pages.length,
              itemBuilder: (_, index) {
                final page = pages[index];
                return _buildPage(
                  context,
                  page,
                  size,
                );
              },
            ),

            // 🌍 Nút đổi ngôn ngữ — nằm trên cùng, luôn bấm được
            Positioned(
              top: 16,
              right: 16,
              child: Material(
                color: Colors.transparent,
                child: PopupMenuButton<Locale>(
                  icon: const Icon(
                    Icons.language,
                    color: Colors.blueAccent,
                    size: 28,
                  ),
                  onSelected: (Locale locale) async {
                    await context.setLocale(
                      locale,
                    );
                    setState(
                      () {},
                    ); // làm mới UI sau khi đổi ngôn ngữ
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: Locale('vi', 'VN'),
                      child: Text(
                        "🇻🇳 Tiếng Việt",
                      ),
                    ),
                    const PopupMenuItem(
                      value: Locale('en', 'US'),
                      child: Text("🇺🇸 English"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(
    BuildContext context,
    Map<String, String> page,
    Size size,
  ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Image.asset(
                'imgs/logoMobile.png',
                height: size.height * 0.15,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              Image.asset(
                page['image']!,
                height: size.height * 0.35,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: size.width * 0.5,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    page['title']!.tr(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF446DDF),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    page['desc']!.tr(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              // 🔹 Dấu chấm chuyển trang
              Row(
                children: List.generate(
                  pages.length,
                  (i) => AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 300,
                    ),
                    margin:
                        const EdgeInsets.symmetric(
                          horizontal: 3,
                        ),
                    width: currentPage == i
                        ? 20
                        : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: currentPage == i
                          ? const Color(
                              0xFF1E90FF,
                            )
                          : const Color(
                              0xFFB0C4DE,
                            ),
                      borderRadius:
                          BorderRadius.circular(
                            4,
                          ),
                    ),
                  ),
                ),
              ),

              // 🔹 Nút Tiếp theo / Bắt đầu
              InkWell(
                onTap: () {
                  if (currentPage ==
                      pages.length - 1) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const AuthWelcomeScreen(),
                      ),
                    );
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(
                        milliseconds: 400,
                      ),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                borderRadius:
                    BorderRadius.circular(30),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 14,
                      ),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(30),
                    gradient:
                        const LinearGradient(
                          colors: [
                            Color(0xFF1565FF),
                            Color.fromARGB(
                              255,
                              19,
                              188,
                              235,
                            ),
                            Color(0xFF9C27B0),
                          ],
                          begin:
                              Alignment.topLeft,
                          end: Alignment
                              .bottomRight,
                        ),
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(2, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize:
                        MainAxisSize.min,
                    children: [
                      Text(
                        currentPage ==
                                pages.length - 1
                            ? 'start'.tr()
                            : 'next'.tr(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons
                            .arrow_forward_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

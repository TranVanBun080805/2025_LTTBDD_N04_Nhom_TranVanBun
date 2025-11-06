import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'controllers/incomeProvider.dart';
import 'controllers/categoryProvider.dart';
import 'screens/load.dart';
import 'utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('vi', 'VN'),
      ],
      path:
          'lib/translations', // ✅ đường dẫn chứa file ngôn ngữ
      fallbackLocale: const Locale(
        'vi',
        'VN',
      ), // 🔹 Ngôn ngữ mặc định
      startLocale: const Locale(
        'vi',
        'VN',
      ), // 🔹 App khởi động với Tiếng Việt
      saveLocale:
          true, // 🔹 Ghi nhớ lựa chọn của người dùng
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Incomeprovider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'app_title'.tr(),
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: kPrimaryColor,
          ),
          scaffoldBackgroundColor: const Color(
            0xFFF5F7FA,
          ),
        ),
        localizationsDelegates:
            context.localizationDelegates,
        supportedLocales:
            context.supportedLocales,
        locale: context.locale,
        home: const LoadingScreen(),
      ),
    );
  }
}

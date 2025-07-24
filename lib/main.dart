import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suncore_mobile/src/core/theme/app_theme.dart';
import 'package:suncore_mobile/src/core/theme/theme_provider.dart';
import 'package:suncore_mobile/src/features/auth/auth_screen.dart';
import 'package:suncore_mobile/src/features/onboarding/onboarding_scree.dart';
import 'package:suncore_mobile/src/features/splash/splash_screen.dart';


Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
    runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(prefs),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
     final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'SunCore Digital',
      theme: ThemeData.light(), // Your light theme
      darkTheme: ThemeData.dark(), // Your dark theme
      themeMode: themeProvider.themeMode,
            debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
      },

    );
  }
}
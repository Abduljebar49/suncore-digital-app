import 'package:flutter/material.dart';
import 'package:suncore_mobile/src/core/const/constants.dart';
import 'package:suncore_mobile/src/core/theme/app_theme.dart';
import 'package:suncore_mobile/src/features/splash/splash_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SplashController.initializeApp(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    // final appName = 'SunCore'; // Replace with your actual appName variable

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo with built-in loading animation
            SizedBox(
              width: 150,
              height: 150,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Hero(
                    tag: 'logo',
                    child: SvgPicture.network(
                      'https://suncoredigital.com/wp-content/uploads/2025/03/SunCore-Logo-Black.svg',
                      width: 120,
                      height: 120,
                    ),
                  ),
                  CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppTheme.primaryColor, // Use your theme's primary color
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // App name text
            Text(
              appName,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Optional subtitle or version text
            Text(
              'Loading...',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController {
  static Future<void> initializeApp(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate loading
    
    final prefs = await SharedPreferences.getInstance();
    final bool firstTimeUser = prefs.getBool('firstTimeUser') ?? true;
    
    Navigator.pushReplacementNamed(
      context,
      firstTimeUser ? '/onboarding' : '/login',
    );
    
    if (firstTimeUser) {
      await prefs.setBool('firstTimeUser', false);
    }
  }
}
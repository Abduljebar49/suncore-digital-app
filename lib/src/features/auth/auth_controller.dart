import 'package:auth0_flutter/auth0_flutter_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static final Auth0 auth0 = Auth0(
    dotenv.get('AUTH0_DOMAIN'),
    dotenv.get('AUTH0_CLIENT_ID'),
  );
  static final auth0Web = Auth0Web(
    dotenv.env['AUTH0_DOMAIN']!,
    dotenv.env['AUTH0_CLIENT_ID']!,
  );
  static String get _scheme => dotenv.get('AUTH0_CUSTOM_SCHEME');
  static String get _domain => dotenv.get('AUTH0_DOMAIN');
  static String get _packageName => dotenv.get('ANDROID_PACKAGE_NAME');

  static String get _redirectUrl =>
      '$_scheme://$_domain/android/$_packageName/callback';
  static String get _logoutRedirectUrl =>
      '$_scheme://$_domain/android/$_packageName/logout';

  static Future<Credentials?> login() async {
    try {

      if (kIsWeb) {
        // For web: Use redirect login
        await auth0Web.loginWithRedirect(
          redirectUrl:
              'http://localhost:3000', // 👈 change to your actual URL in production
          audience: dotenv.env['AUTH0_AUDIENCE'],
        );
        return null;
      }

      // For mobile: Use native login
      final credentials = await auth0
          .webAuthentication(scheme: dotenv.env['AUTH0_CUSTOM_SCHEME'])
          .login(
            useHTTPS: true,
            audience: dotenv.env['AUTH0_AUDIENCE'], // 👈 Important: Set audience for accessToken
            scopes: {'openid', 'profile', 'email', 'offline_access'},
          );

      // Validate access token
      if (credentials.accessToken != null &&
          credentials.accessToken.isNotEmpty) {
            debugPrint('audience ${dotenv.env['AUTH0_AUDIENCE']}');
        debugPrint('Successfully received token: ${credentials.accessToken}');
        // await _storeToken(credentials.accessToken); // Optional: save token securely
      } else {
        debugPrint('No access token received.');
      }

      // Set user in state
      return credentials;
    } catch (e, stack) {
      debugPrint('Login error: $e');
      debugPrint('Stack trace: $stack');
    }
  }

  static Future<void> logout() async {
    try {
      // Clear stored token
      await _clearToken();
      await auth0.webAuthentication().logout(returnTo: _logoutRedirectUrl);
    } catch (e) {
      debugPrint('Logout error: $e');
    }
  }

  static Future<UserProfile?> getCurrentUser() async {
    try {
      final credentials = await auth0.credentialsManager.credentials();
      if (credentials.accessToken.isNotEmpty) {
        await _storeToken(credentials.accessToken);
        debugPrint('Current user token: ${credentials.accessToken}');
      }
      return credentials.user;
    } catch (e) {
      debugPrint('Get user error: $e');
      return null;
    }
  }

  static Future<void> _storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  static Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  static Future<String?> getStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suncore_mobile/src/core/theme/theme_provider.dart';
import 'package:suncore_mobile/src/features/auth/auth_screen.dart';
import 'package:suncore_mobile/src/features/auth/bloc/auth_bloc.dart';
import 'package:suncore_mobile/src/features/onboarding/onboarding_scree.dart';
import 'package:suncore_mobile/src/features/splash/splash_screen.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: ".env");

    final requiredVars = ['AUTH0_DOMAIN', 'AUTH0_CLIENT_ID'];
    for (final varName in requiredVars) {
      if (dotenv.get(varName).isEmpty) {
        throw Exception('Missing required environment variable: $varName');
      }
    }

    final prefs = await SharedPreferences.getInstance();

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider(prefs)),
          BlocProvider(create: (_) => AuthBloc()),
        ],
        child: const MyApp(),
      ),
    );
  } catch (e, stack) {
    debugPrint('Initialization error: $e\n$stack');
    runApp(const ErrorApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'SunCore Digital',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
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

class ErrorApp extends StatelessWidget {
  final Object? error;
  final StackTrace? stackTrace;
  final String? additionalInfo;

  const ErrorApp({super.key, this.error, this.stackTrace, this.additionalInfo});

  @override
  Widget build(BuildContext context) {
    final isEnvFileError = error.toString().contains('FileNotFoundError');
    final isMissingVarError = error.toString().contains(
      'Missing required environment variable',
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.red[50],
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 24),
                Text(
                  _getErrorTitle(isEnvFileError, isMissingVarError),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  _getErrorMessage(isEnvFileError, isMissingVarError),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                if (additionalInfo != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    additionalInfo!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
                const SizedBox(height: 32),
                if (isEnvFileError || isMissingVarError)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      // Add logic to retry or open documentation
                    },
                    child: const Text('View Setup Instructions'),
                  ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    // Add logic to contact support
                  },
                  child: const Text('Contact Support'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getErrorTitle(bool isEnvFileError, bool isMissingVarError) {
    if (isEnvFileError) return 'Configuration File Missing';
    if (isMissingVarError) return 'Invalid Configuration';
    return 'Application Error';
  }

  String _getErrorMessage(bool isEnvFileError, bool isMissingVarError) {
    if (isEnvFileError) {
      return 'The required .env file was not found. '
          'Please make sure it exists in your project root directory.';
    }
    if (isMissingVarError) {
      return 'A required configuration value is missing. '
          'Please check your .env file configuration.';
    }
    return 'An unexpected error occurred during application startup:\n\n${error?.toString() ?? 'Unknown error'}';
  }
}

// Usage example in main.dart:
// runApp(ErrorApp(
//   errorMessage: e.toString(),
//   stackTrace: stack,
//   isAuthError: e is AuthException,
// ));

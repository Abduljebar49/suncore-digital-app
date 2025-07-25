import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suncore_mobile/src/core/const/constants.dart';
import 'package:suncore_mobile/src/core/theme/app_theme.dart';
import 'package:suncore_mobile/src/features/auth/bloc/auth_bloc.dart';
import 'package:suncore_mobile/src/features/dashboard/dashboard_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardScreen(
                user: state.user,
                onLogout: () {
                  context.read<AuthBloc>().add(LogoutRequested());
                },
              ),
            ),
          );
        } else if (state is AuthFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppTheme.primaryColor.withOpacity(0.8),
                AppTheme.backgroundColor,
              ],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo and Title
                  Column(
                    children: [
                      Icon(
                        Icons.currency_bitcoin,
                        size: 80,
                        color: AppTheme.secondaryColor,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        appName,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Mine crypto the way nature intended',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppTheme.textPrimary.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // Login Card
                  Card(
                    color: AppTheme.cardColor,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          const Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 40),
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if (state is AuthLoading) {
                                return const CircularProgressIndicator();
                              }
                              return SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.secondaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    context.read<AuthBloc>().add(LoginRequested());
                                  },
                                  child: const Text(
                                    'LOGIN WITH AUTH0',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(color: AppTheme.textSecondary),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.read<AuthBloc>().add(LoginRequested());
                                },
                                child: const Text(
                                  'Sign up',
                                  style: TextStyle(
                                    color: AppTheme.secondaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Biometric Login Option
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.fingerprint,
                          color: AppTheme.secondaryColor,
                          size: 24,
                        ),
                        label: const Text(
                          'Use Biometric Login',
                          style: TextStyle(color: AppTheme.secondaryColor),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
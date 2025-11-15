import 'dart:convert';

import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:auth0_flutter/auth0_flutter_web.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final Auth0 _auth0;
  late final Auth0Web _auth0Web;

  AuthBloc() : super(AuthInitial()) {
    _auth0 = Auth0(dotenv.env['AUTH0_DOMAIN']!, dotenv.env['AUTH0_CLIENT_ID']!);
    _auth0Web = Auth0Web(
      dotenv.env['AUTH0_DOMAIN']!,
      dotenv.env['AUTH0_CLIENT_ID']!,
    );

    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);

    add(CheckAuthStatus());
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      if (kIsWeb) {
        await _auth0Web.loginWithRedirect(redirectUrl: 'http://localhost:3000');
        return;
      }

      final credentials = await _auth0
          .webAuthentication(scheme: dotenv.env['AUTH0_CUSTOM_SCHEME'])
          .login(
            useHTTPS: true,
            audience: dotenv
                .env['AUTH0_AUDIENCE'], // 👈 Important: Set audience for accessToken
            scopes: {'openid', 'profile', 'email', 'offline_access'},
          );
final credsMap = {
  'accessToken': credentials.accessToken,
  'idToken': credentials.idToken,
  'refreshToken': credentials.refreshToken,
  'tokenType': credentials.tokenType,
  'expiresAt': credentials.expiresAt.toIso8601String(),
  'user': credentials.user.toMap(), // UserProfile has toMap()
};

// Pretty-print JSON
debugPrint(const JsonEncoder.withIndent('  ').convert(credsMap)); 
      if (credentials.accessToken.isNotEmpty) {
        await _storeToken(credentials.accessToken);
        debugPrint('Login successful - Token: ${credentials.accessToken}');
      }

      emit(AuthAuthenticated(user: credentials.user));
    } catch (e) {
      emit(AuthFailed(message: 'Login failed: ${e.toString()}'));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      if (kIsWeb) {
        await _auth0Web.logout(returnToUrl: 'http://localhost:3000');
      } else {
        await _auth0
            .webAuthentication(scheme: dotenv.env['AUTH0_CUSTOM_SCHEME'])
            .logout(useHTTPS: true);
      }
      // Clear stored token
      await _clearToken();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthFailed(message: 'Logout failed: ${e.toString()}'));
    }
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      if (kIsWeb) {
        final credentials = await _auth0Web.onLoad();
        if (credentials != null) {
          await _storeToken(credentials.accessToken);
          debugPrint('Web auth token: ${credentials.accessToken}');
          emit(AuthAuthenticated(user: credentials.user));
          return;
        }
      } else {
        final credentials = await _auth0.credentialsManager.credentials();
        if (credentials != null) {
          await _storeToken(credentials.accessToken);
          debugPrint('Mobile auth token: ${credentials.accessToken}');
          emit(AuthAuthenticated(user: credentials.user));
          return;
        }
      }
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  Future<String?> getStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}

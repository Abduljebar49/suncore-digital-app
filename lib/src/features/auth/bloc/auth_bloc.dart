import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:auth0_flutter/auth0_flutter_web.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final Auth0 _auth0;
  late final Auth0Web _auth0Web;

  AuthBloc() : super(AuthInitial()) {
    // Initialize Auth0 instances
    _auth0 = Auth0(dotenv.env['AUTH0_DOMAIN']!, dotenv.env['AUTH0_CLIENT_ID']!);
    _auth0Web = Auth0Web(dotenv.env['AUTH0_DOMAIN']!, dotenv.env['AUTH0_CLIENT_ID']!);

    // Register event handlers first
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);

    // Then add the initial event
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
          .login(useHTTPS: true);

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
          emit(AuthAuthenticated(user: credentials.user));
          return;
        }
      } else {
        final credentials = await _auth0.credentialsManager.credentials();
        if (credentials != null) {
          emit(AuthAuthenticated(user: credentials.user));
          return;
        }
      }
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthUnauthenticated());
    }
  }
}
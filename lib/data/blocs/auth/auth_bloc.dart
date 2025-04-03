import 'package:bloc/bloc.dart';
import 'package:seeker_flutter/data/blocs/auth/auth_event.dart';
import 'package:seeker_flutter/data/blocs/auth/auth_state.dart';
import 'package:seeker_flutter/data/models/auth_models.dart';
import 'package:seeker_flutter/data/services/auth_service.dart';
import 'package:seeker_flutter/utils/logger.dart';

/// BLoC for managing authentication state
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;

  AuthBloc({required AuthService authService})
      : _authService = authService,
        super(const AuthInitial()) {
    // Register event handlers
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthOtpRequested>(_onAuthOtpRequested);
    on<AuthOtpVerified>(_onAuthOtpVerified);
    on<AuthGoogleRequested>(_onAuthGoogleRequested);
    on<AuthRegisterRequested>(_onAuthRegisterRequested);
    on<AuthPasswordResetRequested>(_onAuthPasswordResetRequested);
    on<AuthPasswordResetConfirmed>(_onAuthPasswordResetConfirmed);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    on<AuthTokenRefreshed>(_onAuthTokenRefreshed);
  }

  /// Check if the user is already authenticated
  Future<void> _onAuthCheckRequested(
      AuthCheckRequested event, Emitter<AuthState> emit) async {
    emit(const AuthCheckInProgress());
    try {
      final isAuthenticated = await _authService.isAuthenticated();
      if (isAuthenticated) {
        // Try to refresh token to ensure it's valid
        final isRefreshed = await _authService.refreshToken();
        if (isRefreshed) {
          // Here, we would typically fetch the user profile
          // Since we don't have a way to get user from token alone,
          // we're creating a dummy user. In a real app, you'd call a
          // user endpoint to get the full user profile.
          emit(AuthAuthenticated(
            user: const UserModel(
              id: 0, // Placeholder
              mobile: '', // Placeholder
              isActive: true,
              isVerified: true,
              createdAt: DateTime(2023),
              updatedAt: DateTime(2023),
            ),
            accessToken: (await _authService._apiClient.getAccessToken()) ?? '',
          ));
        } else {
          emit(const AuthUnauthenticated());
        }
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (e) {
      logError('Auth check failed', e);
      emit(AuthFailure(message: e.toString()));
    }
  }

  /// Request an OTP for login or registration
  Future<void> _onAuthOtpRequested(
      AuthOtpRequested event, Emitter<AuthState> emit) async {
    emit(const AuthOtpRequestInProgress());
    try {
      final success = await _authService.requestOtp(event.request);
      if (success) {
        emit(const AuthOtpRequestSuccess());
      } else {
        emit(const AuthFailure(message: 'OTP request failed'));
      }
    } catch (e) {
      logError('OTP request failed', e);
      emit(AuthFailure(message: e.toString()));
    }
  }

  /// Verify OTP to complete authentication
  Future<void> _onAuthOtpVerified(
      AuthOtpVerified event, Emitter<AuthState> emit) async {
    emit(const AuthOtpVerificationInProgress());
    try {
      final authResponse = await _authService.verifyOtp(event.request);
      emit(AuthAuthenticated(
        user: authResponse.user,
        accessToken: authResponse.accessToken,
      ));
    } catch (e) {
      logError('OTP verification failed', e);
      emit(AuthFailure(message: e.toString()));
    }
  }

  /// Authenticate with Google
  Future<void> _onAuthGoogleRequested(
      AuthGoogleRequested event, Emitter<AuthState> emit) async {
    emit(const AuthGoogleInProgress());
    try {
      final authResponse = await _authService.googleAuth(event.request);
      emit(AuthAuthenticated(
        user: authResponse.user,
        accessToken: authResponse.accessToken,
      ));
    } catch (e) {
      logError('Google auth failed', e);
      emit(AuthFailure(message: e.toString()));
    }
  }

  /// Register a new user
  Future<void> _onAuthRegisterRequested(
      AuthRegisterRequested event, Emitter<AuthState> emit) async {
    emit(const AuthRegistrationInProgress());
    try {
      final success = await _authService.register(event.request);
      if (success) {
        emit(const AuthRegistrationSuccess());
      } else {
        emit(const AuthFailure(message: 'Registration failed'));
      }
    } catch (e) {
      logError('Registration failed', e);
      emit(AuthFailure(message: e.toString()));
    }
  }

  /// Request a password reset
  Future<void> _onAuthPasswordResetRequested(
      AuthPasswordResetRequested event, Emitter<AuthState> emit) async {
    emit(const AuthPasswordResetInProgress());
    try {
      final success = await _authService.requestPasswordReset(event.request);
      if (success) {
        emit(const AuthPasswordResetSuccess());
      } else {
        emit(const AuthFailure(message: 'Password reset request failed'));
      }
    } catch (e) {
      logError('Password reset request failed', e);
      emit(AuthFailure(message: e.toString()));
    }
  }

  /// Confirm a password reset
  Future<void> _onAuthPasswordResetConfirmed(
      AuthPasswordResetConfirmed event, Emitter<AuthState> emit) async {
    emit(const AuthPasswordResetConfirmationInProgress());
    try {
      final success = await _authService.confirmPasswordReset(event.request);
      if (success) {
        emit(const AuthPasswordResetConfirmationSuccess());
      } else {
        emit(const AuthFailure(message: 'Password reset confirmation failed'));
      }
    } catch (e) {
      logError('Password reset confirmation failed', e);
      emit(AuthFailure(message: e.toString()));
    }
  }

  /// Logout the current user
  Future<void> _onAuthLogoutRequested(
      AuthLogoutRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLogoutInProgress());
    try {
      await _authService.logout();
      emit(const AuthUnauthenticated());
    } catch (e) {
      logError('Logout failed', e);
      // Even if logout fails on the server, we should still remove local authentication
      emit(const AuthUnauthenticated());
    }
  }

  /// Refresh the authentication token
  Future<void> _onAuthTokenRefreshed(
      AuthTokenRefreshed event, Emitter<AuthState> emit) async {
    if (state is AuthAuthenticated) {
      final authenticatedState = state as AuthAuthenticated;
      emit(const AuthTokenRefreshInProgress());
      try {
        final success = await _authService.refreshToken();
        if (success) {
          // Keep the existing user but update the token
          emit(AuthAuthenticated(
            user: authenticatedState.user,
            accessToken: (await _authService._apiClient.getAccessToken()) ?? '',
          ));
        } else {
          // If refresh fails, user should be logged out
          emit(const AuthUnauthenticated());
        }
      } catch (e) {
        logError('Token refresh failed', e);
        // If refresh fails, user should be logged out
        emit(const AuthUnauthenticated());
      }
    }
  }
}

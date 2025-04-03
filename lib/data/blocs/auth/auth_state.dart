import 'package:equatable/equatable.dart';
import 'package:seeker_flutter/data/models/auth_models.dart';

/// Base class for all authentication states
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any checks
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Checking authentication status
class AuthCheckInProgress extends AuthState {
  const AuthCheckInProgress();
}

/// User is not authenticated
class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

/// User is authenticated
class AuthAuthenticated extends AuthState {
  final UserModel user;
  final String accessToken;

  const AuthAuthenticated({
    required this.user,
    required this.accessToken,
  });

  @override
  List<Object?> get props => [user, accessToken];
}

/// OTP request in progress
class AuthOtpRequestInProgress extends AuthState {
  const AuthOtpRequestInProgress();
}

/// OTP request completed successfully
class AuthOtpRequestSuccess extends AuthState {
  const AuthOtpRequestSuccess();
}

/// OTP verification in progress
class AuthOtpVerificationInProgress extends AuthState {
  const AuthOtpVerificationInProgress();
}

/// Google authentication in progress
class AuthGoogleInProgress extends AuthState {
  const AuthGoogleInProgress();
}

/// Registration in progress
class AuthRegistrationInProgress extends AuthState {
  const AuthRegistrationInProgress();
}

/// Registration completed successfully
class AuthRegistrationSuccess extends AuthState {
  const AuthRegistrationSuccess();
}

/// Password reset request in progress
class AuthPasswordResetInProgress extends AuthState {
  const AuthPasswordResetInProgress();
}

/// Password reset request completed successfully
class AuthPasswordResetSuccess extends AuthState {
  const AuthPasswordResetSuccess();
}

/// Password reset confirmation in progress
class AuthPasswordResetConfirmationInProgress extends AuthState {
  const AuthPasswordResetConfirmationInProgress();
}

/// Password reset confirmation completed successfully
class AuthPasswordResetConfirmationSuccess extends AuthState {
  const AuthPasswordResetConfirmationSuccess();
}

/// Logout in progress
class AuthLogoutInProgress extends AuthState {
  const AuthLogoutInProgress();
}

/// Token refresh in progress
class AuthTokenRefreshInProgress extends AuthState {
  const AuthTokenRefreshInProgress();
}

/// Any authentication operation failed
class AuthFailure extends AuthState {
  final String message;
  final String? code;

  const AuthFailure({
    required this.message,
    this.code,
  });

  @override
  List<Object?> get props => [message, code];
}

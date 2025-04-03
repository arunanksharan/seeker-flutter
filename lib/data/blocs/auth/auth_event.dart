import 'package:equatable/equatable.dart';
import 'package:seeker_flutter/data/models/auth_models.dart';

/// Base class for all authentication events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Check if user is already authenticated (typically called on app start)
class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();
}

/// Request an OTP for login or registration
class AuthOtpRequested extends AuthEvent {
  final OtpRequestModel request;

  const AuthOtpRequested(this.request);

  @override
  List<Object?> get props => [request];
}

/// Verify OTP to complete authentication
class AuthOtpVerified extends AuthEvent {
  final OtpVerifyModel request;

  const AuthOtpVerified(this.request);

  @override
  List<Object?> get props => [request];
}

/// Authenticate with Google
class AuthGoogleRequested extends AuthEvent {
  final GoogleAuthRequestModel request;

  const AuthGoogleRequested(this.request);

  @override
  List<Object?> get props => [request];
}

/// Register a new user
class AuthRegisterRequested extends AuthEvent {
  final RegisterRequestModel request;

  const AuthRegisterRequested(this.request);

  @override
  List<Object?> get props => [request];
}

/// Request a password reset
class AuthPasswordResetRequested extends AuthEvent {
  final PasswordResetRequestModel request;

  const AuthPasswordResetRequested(this.request);

  @override
  List<Object?> get props => [request];
}

/// Confirm a password reset
class AuthPasswordResetConfirmed extends AuthEvent {
  final PasswordResetConfirmModel request;

  const AuthPasswordResetConfirmed(this.request);

  @override
  List<Object?> get props => [request];
}

/// Logout the current user
class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

/// Refresh the authentication token
class AuthTokenRefreshed extends AuthEvent {
  const AuthTokenRefreshed();
}

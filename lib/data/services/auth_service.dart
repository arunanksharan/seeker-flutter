import 'package:seeker_flutter/data/models/auth_models.dart';
import 'package:seeker_flutter/data/services/api_client.dart';
import 'package:seeker_flutter/utils/logger.dart';

/// Service for handling authentication operations
class AuthService {
  final ApiClient _apiClient;

  /// Endpoints for auth-related API calls
  static const _loginEndpoint = '/auth/login';
  static const _otpRequestEndpoint = '/auth/request-otp';
  static const _otpVerifyEndpoint = '/auth/verify-otp';
  static const _googleAuthEndpoint = '/auth/google';
  static const _logoutEndpoint = '/auth/logout';
  static const _registerEndpoint = '/auth/register';
  static const _passwordResetRequestEndpoint = '/auth/password/reset-request';
  static const _passwordResetConfirmEndpoint = '/auth/password/reset-confirm';

  AuthService(this._apiClient);

  /// Request an OTP code for login or registration
  Future<bool> requestOtp(OtpRequestModel request) async {
    try {
      final response = await _apiClient.post(
        _otpRequestEndpoint,
        body: request.toJson(),
        withAuth: false,
      );
      
      return response['success'] == true;
    } catch (e) {
      logError('Request OTP failed', e);
      rethrow;
    }
  }

  /// Verify an OTP code for authentication
  Future<AuthResponseModel> verifyOtp(OtpVerifyModel request) async {
    try {
      final response = await _apiClient.post(
        _otpVerifyEndpoint,
        body: request.toJson(),
        withAuth: false,
      );
      
      final authResponse = AuthResponseModel.fromJson(response);
      
      // Save tokens
      await _apiClient.saveTokens(
        authResponse.accessToken,
        authResponse.refreshToken,
      );
      
      return authResponse;
    } catch (e) {
      logError('OTP verification failed', e);
      rethrow;
    }
  }

  /// Authenticate with Google
  Future<AuthResponseModel> googleAuth(GoogleAuthRequestModel request) async {
    try {
      final response = await _apiClient.post(
        _googleAuthEndpoint,
        body: request.toJson(),
        withAuth: false,
      );
      
      final authResponse = AuthResponseModel.fromJson(response);
      
      // Save tokens
      await _apiClient.saveTokens(
        authResponse.accessToken,
        authResponse.refreshToken,
      );
      
      return authResponse;
    } catch (e) {
      logError('Google auth failed', e);
      rethrow;
    }
  }

  /// Register a new user
  Future<bool> register(RegisterRequestModel request) async {
    try {
      final response = await _apiClient.post(
        _registerEndpoint,
        body: request.toJson(),
        withAuth: false,
      );
      
      return response['success'] == true;
    } catch (e) {
      logError('Registration failed', e);
      rethrow;
    }
  }

  /// Request a password reset (sends OTP)
  Future<bool> requestPasswordReset(PasswordResetRequestModel request) async {
    try {
      final response = await _apiClient.post(
        _passwordResetRequestEndpoint,
        body: request.toJson(),
        withAuth: false,
      );
      
      return response['success'] == true;
    } catch (e) {
      logError('Password reset request failed', e);
      rethrow;
    }
  }

  /// Confirm password reset with OTP and new password
  Future<bool> confirmPasswordReset(PasswordResetConfirmModel request) async {
    try {
      final response = await _apiClient.post(
        _passwordResetConfirmEndpoint,
        body: request.toJson(),
        withAuth: false,
      );
      
      return response['success'] == true;
    } catch (e) {
      logError('Password reset confirmation failed', e);
      rethrow;
    }
  }

  /// Logout the current user
  Future<bool> logout() async {
    try {
      final response = await _apiClient.post(_logoutEndpoint);
      
      // Clear tokens regardless of response
      await _apiClient.clearTokens();
      
      return response['success'] == true;
    } catch (e) {
      // Still clear tokens on error
      await _apiClient.clearTokens();
      logError('Logout failed', e);
      return false;
    }
  }
  
  /// Check if the user is authenticated
  Future<bool> isAuthenticated() async {
    final token = await _apiClient.getAccessToken();
    return token != null;
  }
  
  /// Refresh the authentication token
  Future<bool> refreshToken() async {
    return await _apiClient.refreshToken();
  }
}

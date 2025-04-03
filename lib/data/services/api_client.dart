import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:seeker_flutter/utils/logger.dart';

/// Exception thrown when API requests fail
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final Map<String, dynamic>? response;

  ApiException(this.message, {this.statusCode, this.response});

  @override
  String toString() {
    return 'ApiException: $message${statusCode != null ? ' (Status code: $statusCode)' : ''}';
  }
}

/// A client for making API requests
class ApiClient {
  // Base URL for API
  static const String _baseUrl = 'https://api.example.com'; // Replace with your actual API URL
  
  // Storage for auth tokens
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  
  // Token storage keys
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  // Get stored access token
  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: _accessTokenKey);
  }

  // Get stored refresh token
  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: _refreshTokenKey);
  }

  // Store tokens
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _secureStorage.write(key: _accessTokenKey, value: accessToken);
    await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
    logInfo('Tokens saved to secure storage');
  }

  // Clear stored tokens
  Future<void> clearTokens() async {
    await _secureStorage.delete(key: _accessTokenKey);
    await _secureStorage.delete(key: _refreshTokenKey);
    logInfo('Tokens cleared from secure storage');
  }

  // Create HTTP headers, optionally with auth token
  Future<Map<String, String>> _createHeaders({bool withAuth = true}) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (withAuth) {
      final token = await getAccessToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    return headers;
  }

  // Handles response to check for errors
  dynamic _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    final responseBody = response.body;

    if (statusCode >= 200 && statusCode < 300) {
      if (responseBody.isEmpty) {
        return null;
      }
      try {
        return json.decode(responseBody);
      } catch (e) {
        logError('Failed to parse response body', e);
        throw ApiException('Failed to parse response body');
      }
    } else {
      Map<String, dynamic>? errorResponse;
      try {
        errorResponse = json.decode(responseBody) as Map<String, dynamic>;
      } catch (e) {
        // Ignore parsing errors for error responses
      }

      final errorMessage = errorResponse?['message'] as String? ??
          errorResponse?['error'] as String? ??
          'Request failed with status: $statusCode';

      logError('API Error', ApiException(errorMessage, statusCode: statusCode, response: errorResponse));
      throw ApiException(errorMessage, statusCode: statusCode, response: errorResponse);
    }
  }

  // GET request
  Future<dynamic> get(String endpoint, {Map<String, dynamic>? queryParams, bool withAuth = true}) async {
    try {
      final headers = await _createHeaders(withAuth: withAuth);
      final uri = Uri.parse('$_baseUrl$endpoint').replace(queryParameters: queryParams);
      
      logInfo('GET $uri');
      final response = await http.get(uri, headers: headers);
      return _handleResponse(response);
    } on SocketException {
      throw ApiException('No internet connection');
    } catch (e) {
      if (e is ApiException) rethrow;
      logError('GET request failed', e);
      throw ApiException('Failed to complete request: ${e.toString()}');
    }
  }

  // POST request
  Future<dynamic> post(String endpoint, {dynamic body, bool withAuth = true}) async {
    try {
      final headers = await _createHeaders(withAuth: withAuth);
      final uri = Uri.parse('$_baseUrl$endpoint');
      
      logInfo('POST $uri');
      final response = await http.post(
        uri,
        headers: headers,
        body: body != null ? json.encode(body) : null,
      );
      return _handleResponse(response);
    } on SocketException {
      throw ApiException('No internet connection');
    } catch (e) {
      if (e is ApiException) rethrow;
      logError('POST request failed', e);
      throw ApiException('Failed to complete request: ${e.toString()}');
    }
  }

  // PUT request
  Future<dynamic> put(String endpoint, {dynamic body, bool withAuth = true}) async {
    try {
      final headers = await _createHeaders(withAuth: withAuth);
      final uri = Uri.parse('$_baseUrl$endpoint');
      
      logInfo('PUT $uri');
      final response = await http.put(
        uri,
        headers: headers,
        body: body != null ? json.encode(body) : null,
      );
      return _handleResponse(response);
    } on SocketException {
      throw ApiException('No internet connection');
    } catch (e) {
      if (e is ApiException) rethrow;
      logError('PUT request failed', e);
      throw ApiException('Failed to complete request: ${e.toString()}');
    }
  }

  // DELETE request
  Future<dynamic> delete(String endpoint, {dynamic body, bool withAuth = true}) async {
    try {
      final headers = await _createHeaders(withAuth: withAuth);
      final uri = Uri.parse('$_baseUrl$endpoint');
      
      logInfo('DELETE $uri');
      final response = await http.delete(
        uri,
        headers: headers,
        body: body != null ? json.encode(body) : null,
      );
      return _handleResponse(response);
    } on SocketException {
      throw ApiException('No internet connection');
    } catch (e) {
      if (e is ApiException) rethrow;
      logError('DELETE request failed', e);
      throw ApiException('Failed to complete request: ${e.toString()}');
    }
  }

  // Refresh auth token
  Future<bool> refreshToken() async {
    try {
      final refreshToken = await getRefreshToken();
      if (refreshToken == null) {
        return false;
      }

      final response = await post(
        '/auth/refresh-token',
        body: {'refresh_token': refreshToken},
        withAuth: false,
      );

      if (response != null && 
          response['access_token'] != null && 
          response['refresh_token'] != null) {
        await saveTokens(
          response['access_token'],
          response['refresh_token'],
        );
        return true;
      }
      return false;
    } catch (e) {
      logError('Token refresh failed', e);
      return false;
    }
  }
}

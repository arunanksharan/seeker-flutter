import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.dart'; // Will create this next

// Note: AuthState is typically managed by a Bloc/Cubit state, not a separate model.
// We'll define the others first.

/// User profile model corresponding to the User interface in TypeScript.
@JsonSerializable(fieldRename: FieldRename.snake)
class UserModel extends Equatable {
  final int id;
  final String mobile;
  final String? email;
  final bool isActive;
  final bool isVerified;
  final DateTime createdAt; // Use DateTime for dates
  final DateTime updatedAt;

  const UserModel({
    required this.id,
    required this.mobile,
    this.email,
    required this.isActive,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        mobile,
        email,
        isActive,
        isVerified,
        createdAt,
        updatedAt,
      ];
}

/// Login request payload.
@JsonSerializable(fieldRename: FieldRename.snake)
class LoginRequestModel extends Equatable {
  final String mobile;

  const LoginRequestModel({required this.mobile});

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);

  @override
  List<Object?> get props => [mobile];
}

/// OTP request type enum.
enum OtpType { login, register }

/// OTP request payload.
@JsonSerializable(fieldRename: FieldRename.snake)
class OtpRequestModel extends Equatable {
  final String mobile;
  final OtpType? type; // Use enum for type safety

  const OtpRequestModel({required this.mobile, this.type});

  factory OtpRequestModel.fromJson(Map<String, dynamic> json) =>
      _$OtpRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$OtpRequestModelToJson(this);

  @override
  List<Object?> get props => [mobile, type];
}

/// OTP verification payload.
@JsonSerializable(fieldRename: FieldRename.snake)
class OtpVerifyModel extends Equatable {
  final String mobile;
  final String otp;

  const OtpVerifyModel({required this.mobile, required this.otp});

  factory OtpVerifyModel.fromJson(Map<String, dynamic> json) =>
      _$OtpVerifyModelFromJson(json);

  Map<String, dynamic> toJson() => _$OtpVerifyModelToJson(this);

  @override
  List<Object?> get props => [mobile, otp];
}

/// Google authentication request.
@JsonSerializable(fieldRename: FieldRename.snake)
class GoogleAuthRequestModel extends Equatable {
  final String token;

  const GoogleAuthRequestModel({required this.token});

  factory GoogleAuthRequestModel.fromJson(Map<String, dynamic> json) =>
      _$GoogleAuthRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleAuthRequestModelToJson(this);

  @override
  List<Object?> get props => [token];
}

/// Authentication response with tokens.
@JsonSerializable(fieldRename: FieldRename.snake)
class AuthResponseModel extends Equatable {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final int expiresIn; // Duration might be better if applicable
  final UserModel user;

  const AuthResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
    required this.user,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseModelToJson(this);

  @override
  List<Object?> get props =>
      [accessToken, refreshToken, tokenType, expiresIn, user];
}

/// Token refresh request.
@JsonSerializable(fieldRename: FieldRename.snake)
class RefreshTokenRequestModel extends Equatable {
  final String refreshToken;

  const RefreshTokenRequestModel({required this.refreshToken});

  factory RefreshTokenRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenRequestModelToJson(this);

  @override
  List<Object?> get props => [refreshToken];
}

// Note: TokenPayload might not be needed directly in the frontend models
// unless you are decoding JWTs client-side, which is often not recommended.
// We'll skip converting it for now.

/// Registration request payload.
@JsonSerializable(fieldRename: FieldRename.snake)
class RegisterRequestModel extends Equatable {
  final String mobile;
  final String? email;

  const RegisterRequestModel({required this.mobile, this.email});

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestModelToJson(this);

  @override
  List<Object?> get props => [mobile, email];
}

/// Password reset request.
@JsonSerializable(fieldRename: FieldRename.snake)
class PasswordResetRequestModel extends Equatable {
  final String mobile;

  const PasswordResetRequestModel({required this.mobile});

  factory PasswordResetRequestModel.fromJson(Map<String, dynamic> json) =>
      _$PasswordResetRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$PasswordResetRequestModelToJson(this);

  @override
  List<Object?> get props => [mobile];
}

/// Password reset confirmation.
@JsonSerializable(fieldRename: FieldRename.snake)
class PasswordResetConfirmModel extends Equatable {
  final String mobile;
  final String otp;
  final String newPassword;

  const PasswordResetConfirmModel({
    required this.mobile,
    required this.otp,
    required this.newPassword,
  });

  factory PasswordResetConfirmModel.fromJson(Map<String, dynamic> json) =>
      _$PasswordResetConfirmModelFromJson(json);

  Map<String, dynamic> toJson() => _$PasswordResetConfirmModelToJson(this);

  @override
  List<Object?> get props => [mobile, otp, newPassword];
}

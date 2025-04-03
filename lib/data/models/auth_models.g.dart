part of 'auth_models.dart';

// --- Serialization/Deserialization for UserModel ---
UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int,
      mobile: json['mobile'] as String,
      email: json['email'] as String?,
      isActive: json['is_active'] as bool,
      isVerified: json['is_verified'] as bool,
      // Assuming API returns ISO 8601 string dates
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'mobile': instance.mobile,
      'email': instance.email,
      'is_active': instance.isActive,
      'is_verified': instance.isVerified,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

// --- Serialization/Deserialization for LoginRequestModel ---
LoginRequestModel _$LoginRequestModelFromJson(Map<String, dynamic> json) =>
    LoginRequestModel(
      mobile: json['mobile'] as String,
    );

Map<String, dynamic> _$LoginRequestModelToJson(LoginRequestModel instance) =>
    <String, dynamic>{
      'mobile': instance.mobile,
    };

// --- Serialization/Deserialization for OtpRequestModel ---
OtpRequestModel _$OtpRequestModelFromJson(Map<String, dynamic> json) =>
    OtpRequestModel(
      mobile: json['mobile'] as String,
      type: $enumDecodeNullable(_$OtpTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$OtpRequestModelToJson(OtpRequestModel instance) =>
    <String, dynamic>{
      'mobile': instance.mobile,
      'type': _$OtpTypeEnumMap[instance.type],
    };

const _$OtpTypeEnumMap = {
  OtpType.login: 'login',
  OtpType.register: 'register',
};

// Helper for enum decoding (can be put in a utils file later)
T? $enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => throw ArgumentError('`$source` is not one of the supported values: ${enumValues.values.join(', ')}`))
      .key;
}

// --- Serialization/Deserialization for OtpVerifyModel ---
OtpVerifyModel _$OtpVerifyModelFromJson(Map<String, dynamic> json) =>
    OtpVerifyModel(
      mobile: json['mobile'] as String,
      otp: json['otp'] as String,
    );

Map<String, dynamic> _$OtpVerifyModelToJson(OtpVerifyModel instance) =>
    <String, dynamic>{
      'mobile': instance.mobile,
      'otp': instance.otp,
    };

// --- Serialization/Deserialization for GoogleAuthRequestModel ---
GoogleAuthRequestModel _$GoogleAuthRequestModelFromJson(
        Map<String, dynamic> json) =>
    GoogleAuthRequestModel(
      token: json['token'] as String,
    );

Map<String, dynamic> _$GoogleAuthRequestModelToJson(
        GoogleAuthRequestModel instance) =>
    <String, dynamic>{
      'token': instance.token,
    };

// --- Serialization/Deserialization for AuthResponseModel ---
AuthResponseModel _$AuthResponseModelFromJson(Map<String, dynamic> json) =>
    AuthResponseModel(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      tokenType: json['token_type'] as String,
      expiresIn: json['expires_in'] as int,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthResponseModelToJson(AuthResponseModel instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'token_type': instance.tokenType,
      'expires_in': instance.expiresIn,
      'user': instance.user.toJson(), // Use UserModel's toJson
    };

// --- Serialization/Deserialization for RefreshTokenRequestModel ---
RefreshTokenRequestModel _$RefreshTokenRequestModelFromJson(
        Map<String, dynamic> json) =>
    RefreshTokenRequestModel(
      refreshToken: json['refresh_token'] as String,
    );

Map<String, dynamic> _$RefreshTokenRequestModelToJson(
        RefreshTokenRequestModel instance) =>
    <String, dynamic>{
      'refresh_token': instance.refreshToken,
    };

// --- Serialization/Deserialization for RegisterRequestModel ---
RegisterRequestModel _$RegisterRequestModelFromJson(Map<String, dynamic> json) =>
    RegisterRequestModel(
      mobile: json['mobile'] as String,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$RegisterRequestModelToJson(
        RegisterRequestModel instance) =>
    <String, dynamic>{
      'mobile': instance.mobile,
      'email': instance.email,
    };

// --- Serialization/Deserialization for PasswordResetRequestModel ---
PasswordResetRequestModel _$PasswordResetRequestModelFromJson(
        Map<String, dynamic> json) =>
    PasswordResetRequestModel(
      mobile: json['mobile'] as String,
    );

Map<String, dynamic> _$PasswordResetRequestModelToJson(
        PasswordResetRequestModel instance) =>
    <String, dynamic>{
      'mobile': instance.mobile,
    };

// --- Serialization/Deserialization for PasswordResetConfirmModel ---
PasswordResetConfirmModel _$PasswordResetConfirmModelFromJson(
        Map<String, dynamic> json) =>
    PasswordResetConfirmModel(
      mobile: json['mobile'] as String,
      otp: json['otp'] as String,
      newPassword: json['new_password'] as String,
    );

Map<String, dynamic> _$PasswordResetConfirmModelToJson(
        PasswordResetConfirmModel instance) =>
    <String, dynamic>{
      'mobile': instance.mobile,
      'otp': instance.otp,
      'new_password': instance.newPassword,
    };

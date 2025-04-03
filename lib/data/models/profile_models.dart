import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_models.g.dart';

/// User verification status
enum VerificationStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('verified')
  verified,
  @JsonValue('rejected')
  rejected,
}

/// Education levels
enum EducationLevel {
  @JsonValue('10th')
  tenth,
  @JsonValue('12th')
  twelfth,
  @JsonValue('Diploma')
  diploma,
  @JsonValue('ITI')
  iti,
  @JsonValue('Graduate')
  graduate,
  @JsonValue('Post Graduate')
  postGraduate,
  @JsonValue('Doctorate')
  doctorate,
}

/// Language proficiency levels
enum ProficiencyLevel {
  @JsonValue('Basic')
  basic,
  @JsonValue('Intermediate')
  intermediate,
  @JsonValue('Fluent')
  fluent,
  @JsonValue('Native')
  native,
}

/// Seeker profile model
@JsonSerializable()
class SeekerProfileModel extends Equatable {
  final int? id;
  final PersonalDetailsModel personalDetails;
  final ContactDetailsModel contactDetails;
  final EducationDetailsModel? educationDetails;
  final List<WorkExperienceModel>? workExperience;
  final List<SkillModel>? skills;
  final List<LanguageProficiencyModel>? languages;
  final List<CertificationModel>? certifications;
  final JobPreferencesModel? jobPreferences;
  final String? createdAt;
  final String? updatedAt;

  const SeekerProfileModel({
    this.id,
    required this.personalDetails,
    required this.contactDetails,
    this.educationDetails,
    this.workExperience,
    this.skills,
    this.languages,
    this.certifications,
    this.jobPreferences,
    this.createdAt,
    this.updatedAt,
  });

  factory SeekerProfileModel.fromJson(Map<String, dynamic> json) =>
      _$SeekerProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$SeekerProfileModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        personalDetails,
        contactDetails,
        educationDetails,
        workExperience,
        skills,
        languages,
        certifications,
        jobPreferences,
        createdAt,
        updatedAt,
      ];
}

/// Personal details model
@JsonSerializable()
class PersonalDetailsModel extends Equatable {
  final String? name;
  final String? fatherName;
  final String? motherName;
  final String? gender;
  final DateTime? dob;
  final String? guardianName;
  final String? profilePictureUrl;

  const PersonalDetailsModel({
    this.name,
    this.fatherName,
    this.motherName,
    this.gender,
    this.dob,
    this.guardianName,
    this.profilePictureUrl,
  });

  factory PersonalDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$PersonalDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalDetailsModelToJson(this);

  @override
  List<Object?> get props => [
        name,
        fatherName,
        motherName,
        gender,
        dob,
        guardianName,
        profilePictureUrl,
      ];
      
  /// Get age from date of birth
  int? get age {
    if (dob == null) return null;
    final today = DateTime.now();
    int age = today.year - dob!.year;
    if (today.month < dob!.month ||
        (today.month == dob!.month && today.day < dob!.day)) {
      age--;
    }
    return age;
  }
  
  /// Create a copy with updated fields
  PersonalDetailsModel copyWith({
    String? name,
    String? fatherName,
    String? motherName,
    String? gender,
    DateTime? dob,
    String? guardianName,
    String? profilePictureUrl,
  }) {
    return PersonalDetailsModel(
      name: name ?? this.name,
      fatherName: fatherName ?? this.fatherName,
      motherName: motherName ?? this.motherName,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      guardianName: guardianName ?? this.guardianName,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
    );
  }
}

/// Contact details model
@JsonSerializable()
class ContactDetailsModel extends Equatable {
  final String primaryMobile;
  final String? secondaryMobile;
  final String? email;
  final AddressModel? currentAddress;
  final AddressModel? permanentAddress;

  const ContactDetailsModel({
    required this.primaryMobile,
    this.secondaryMobile,
    this.email,
    this.currentAddress,
    this.permanentAddress,
  });

  factory ContactDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$ContactDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContactDetailsModelToJson(this);

  @override
  List<Object?> get props => [
        primaryMobile,
        secondaryMobile,
        email,
        currentAddress,
        permanentAddress,
      ];
      
  /// Create a copy with updated fields
  ContactDetailsModel copyWith({
    String? primaryMobile,
    String? secondaryMobile,
    String? email,
    AddressModel? currentAddress,
    AddressModel? permanentAddress,
  }) {
    return ContactDetailsModel(
      primaryMobile: primaryMobile ?? this.primaryMobile,
      secondaryMobile: secondaryMobile ?? this.secondaryMobile,
      email: email ?? this.email,
      currentAddress: currentAddress ?? this.currentAddress,
      permanentAddress: permanentAddress ?? this.permanentAddress,
    );
  }
}

/// Address model
@JsonSerializable()
class AddressModel extends Equatable {
  final String? street;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? country;
  final bool? isCurrent;
  @JsonKey(name: 'verification_status')
  final VerificationStatus? verificationStatus;

  const AddressModel({
    this.street,
    this.city,
    this.state,
    this.postalCode,
    this.country,
    this.isCurrent,
    this.verificationStatus,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);

  @override
  List<Object?> get props => [
        street,
        city,
        state,
        postalCode,
        country,
        isCurrent,
        verificationStatus,
      ];
      
  /// Get formatted address
  String get formattedAddress {
    final parts = <String>[];
    if (street != null && street!.isNotEmpty) parts.add(street!);
    if (city != null && city!.isNotEmpty) parts.add(city!);
    if (state != null && state!.isNotEmpty) parts.add(state!);
    if (postalCode != null && postalCode!.isNotEmpty) parts.add(postalCode!);
    if (country != null && country!.isNotEmpty) parts.add(country!);
    
    return parts.join(', ');
  }
  
  /// Create a copy with updated fields
  AddressModel copyWith({
    String? street,
    String? city,
    String? state,
    String? postalCode,
    String? country,
    bool? isCurrent,
    VerificationStatus? verificationStatus,
  }) {
    return AddressModel(
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
      isCurrent: isCurrent ?? this.isCurrent,
      verificationStatus: verificationStatus ?? this.verificationStatus,
    );
  }
}

/// Education detail model for individual education entries
@JsonSerializable()
class EducationDetailModel extends Equatable {
  final int? id;
  final String? instituteName;
  final String? fieldOfStudy;
  final String? startDate;
  final String? endDate;
  final bool? isCurrentlyStudying;
  final String? grade;
  @JsonKey(name: 'verification_status')
  final VerificationStatus? verificationStatus;

  const EducationDetailModel({
    this.id,
    this.instituteName,
    this.fieldOfStudy,
    this.startDate,
    this.endDate,
    this.isCurrentlyStudying,
    this.grade,
    this.verificationStatus,
  });

  factory EducationDetailModel.fromJson(Map<String, dynamic> json) =>
      _$EducationDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$EducationDetailModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        instituteName,
        fieldOfStudy,
        startDate,
        endDate,
        isCurrentlyStudying,
        grade,
        verificationStatus,
      ];
      
  /// Create a copy with updated fields
  EducationDetailModel copyWith({
    int? id,
    String? instituteName,
    String? fieldOfStudy,
    String? startDate,
    String? endDate,
    bool? isCurrentlyStudying,
    String? grade,
    VerificationStatus? verificationStatus,
  }) {
    return EducationDetailModel(
      id: id ?? this.id,
      instituteName: instituteName ?? this.instituteName,
      fieldOfStudy: fieldOfStudy ?? this.fieldOfStudy,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isCurrentlyStudying: isCurrentlyStudying ?? this.isCurrentlyStudying,
      grade: grade ?? this.grade,
      verificationStatus: verificationStatus ?? this.verificationStatus,
    );
  }
}

/// Education details model (container for all education information)
@JsonSerializable()
class EducationDetailsModel extends Equatable {
  final String? highestLevel;
  final List<EducationDetailModel>? educationDetails;

  const EducationDetailsModel({
    this.highestLevel,
    this.educationDetails,
  });

  factory EducationDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$EducationDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$EducationDetailsModelToJson(this);

  @override
  List<Object?> get props => [highestLevel, educationDetails];
  
  /// Create a copy with updated fields
  EducationDetailsModel copyWith({
    String? highestLevel,
    List<EducationDetailModel>? educationDetails,
  }) {
    return EducationDetailsModel(
      highestLevel: highestLevel ?? this.highestLevel,
      educationDetails: educationDetails ?? this.educationDetails,
    );
  }
}

/// Work experience model
@JsonSerializable()
class WorkExperienceModel extends Equatable {
  final int? id;
  final String? companyName;
  final String? position;
  final String? location;
  final String? startDate;
  final String? endDate;
  final bool? isCurrentlyWorking;
  final String? description;
  @JsonKey(name: 'verification_status')
  final VerificationStatus? verificationStatus;

  const WorkExperienceModel({
    this.id,
    this.companyName,
    this.position,
    this.location,
    this.startDate,
    this.endDate,
    this.isCurrentlyWorking,
    this.description,
    this.verificationStatus,
  });

  factory WorkExperienceModel.fromJson(Map<String, dynamic> json) =>
      _$WorkExperienceModelFromJson(json);

  Map<String, dynamic> toJson() => _$WorkExperienceModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        companyName,
        position,
        location,
        startDate,
        endDate,
        isCurrentlyWorking,
        description,
        verificationStatus,
      ];
      
  /// Create a copy with updated fields
  WorkExperienceModel copyWith({
    int? id,
    String? companyName,
    String? position,
    String? location,
    String? startDate,
    String? endDate,
    bool? isCurrentlyWorking,
    String? description,
    VerificationStatus? verificationStatus,
  }) {
    return WorkExperienceModel(
      id: id ?? this.id,
      companyName: companyName ?? this.companyName,
      position: position ?? this.position,
      location: location ?? this.location,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isCurrentlyWorking: isCurrentlyWorking ?? this.isCurrentlyWorking,
      description: description ?? this.description,
      verificationStatus: verificationStatus ?? this.verificationStatus,
    );
  }
}

/// Skill model
@JsonSerializable()
class SkillModel extends Equatable {
  final int? id;
  final String name;
  final int? yearsOfExperience;

  const SkillModel({
    this.id,
    required this.name,
    this.yearsOfExperience,
  });

  factory SkillModel.fromJson(Map<String, dynamic> json) =>
      _$SkillModelFromJson(json);

  Map<String, dynamic> toJson() => _$SkillModelToJson(this);

  @override
  List<Object?> get props => [id, name, yearsOfExperience];
  
  /// Create a copy with updated fields
  SkillModel copyWith({
    int? id,
    String? name,
    int? yearsOfExperience,
  }) {
    return SkillModel(
      id: id ?? this.id,
      name: name ?? this.name,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
    );
  }
}

/// Certification model
@JsonSerializable()
class CertificationModel extends Equatable {
  final int? id;
  final String? name;
  final String? issuingOrganization;
  final String? issueDate;
  final String? expiryDate;
  final String? credentialId;
  final String? credentialUrl;
  @JsonKey(name: 'verification_status')
  final VerificationStatus? verificationStatus;

  const CertificationModel({
    this.id,
    this.name,
    this.issuingOrganization,
    this.issueDate,
    this.expiryDate,
    this.credentialId,
    this.credentialUrl,
    this.verificationStatus,
  });

  factory CertificationModel.fromJson(Map<String, dynamic> json) =>
      _$CertificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$CertificationModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        issuingOrganization,
        issueDate,
        expiryDate,
        credentialId,
        credentialUrl,
        verificationStatus,
      ];
      
  /// Create a copy with updated fields
  CertificationModel copyWith({
    int? id,
    String? name,
    String? issuingOrganization,
    String? issueDate,
    String? expiryDate,
    String? credentialId,
    String? credentialUrl,
    VerificationStatus? verificationStatus,
  }) {
    return CertificationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      issuingOrganization: issuingOrganization ?? this.issuingOrganization,
      issueDate: issueDate ?? this.issueDate,
      expiryDate: expiryDate ?? this.expiryDate,
      credentialId: credentialId ?? this.credentialId,
      credentialUrl: credentialUrl ?? this.credentialUrl,
      verificationStatus: verificationStatus ?? this.verificationStatus,
    );
  }
}

/// Language proficiency model
@JsonSerializable()
class LanguageProficiencyModel extends Equatable {
  final int? id;
  final String? language;
  @JsonKey(name: 'reading_proficiency')
  final ProficiencyLevel? readingProficiency;
  @JsonKey(name: 'writing_proficiency')
  final ProficiencyLevel? writingProficiency;
  @JsonKey(name: 'speaking_proficiency')
  final ProficiencyLevel? speakingProficiency;

  const LanguageProficiencyModel({
    this.id,
    this.language,
    this.readingProficiency,
    this.writingProficiency,
    this.speakingProficiency,
  });

  factory LanguageProficiencyModel.fromJson(Map<String, dynamic> json) =>
      _$LanguageProficiencyModelFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageProficiencyModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        language,
        readingProficiency,
        writingProficiency,
        speakingProficiency,
      ];
      
  /// Create a copy with updated fields
  LanguageProficiencyModel copyWith({
    int? id,
    String? language,
    ProficiencyLevel? readingProficiency,
    ProficiencyLevel? writingProficiency,
    ProficiencyLevel? speakingProficiency,
  }) {
    return LanguageProficiencyModel(
      id: id ?? this.id,
      language: language ?? this.language,
      readingProficiency: readingProficiency ?? this.readingProficiency,
      writingProficiency: writingProficiency ?? this.writingProficiency,
      speakingProficiency: speakingProficiency ?? this.speakingProficiency,
    );
  }
}

/// Job preferences model
@JsonSerializable()
class JobPreferencesModel extends Equatable {
  final List<String>? desiredJobTitles;
  final List<String>? desiredLocations;
  final int? minSalaryExpectation;
  final String? employmentTypes; // Full-time, Part-time, Contract, etc.
  final bool? isRemoteWork;
  final bool? isRelocationPreferred;
  final String? noticePeriod;

  const JobPreferencesModel({
    this.desiredJobTitles,
    this.desiredLocations,
    this.minSalaryExpectation,
    this.employmentTypes,
    this.isRemoteWork,
    this.isRelocationPreferred,
    this.noticePeriod,
  });

  factory JobPreferencesModel.fromJson(Map<String, dynamic> json) =>
      _$JobPreferencesModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobPreferencesModelToJson(this);

  @override
  List<Object?> get props => [
        desiredJobTitles,
        desiredLocations,
        minSalaryExpectation,
        employmentTypes,
        isRemoteWork,
        isRelocationPreferred,
        noticePeriod,
      ];
      
  /// Create a copy with updated fields
  JobPreferencesModel copyWith({
    List<String>? desiredJobTitles,
    List<String>? desiredLocations,
    int? minSalaryExpectation,
    String? employmentTypes,
    bool? isRemoteWork,
    bool? isRelocationPreferred,
    String? noticePeriod,
  }) {
    return JobPreferencesModel(
      desiredJobTitles: desiredJobTitles ?? this.desiredJobTitles,
      desiredLocations: desiredLocations ?? this.desiredLocations,
      minSalaryExpectation: minSalaryExpectation ?? this.minSalaryExpectation,
      employmentTypes: employmentTypes ?? this.employmentTypes,
      isRemoteWork: isRemoteWork ?? this.isRemoteWork,
      isRelocationPreferred: isRelocationPreferred ?? this.isRelocationPreferred,
      noticePeriod: noticePeriod ?? this.noticePeriod,
    );
  }
}

/// API request model for creating a seeker profile
@JsonSerializable()
class SeekerProfileAPICreateRequestModel extends Equatable {
  final PersonalDetailsModel personalDetails;
  final ContactDetailsModel contactDetails;
  final EducationDetailsModel? educationDetails;
  final List<WorkExperienceModel>? workExperience;
  final List<SkillModel>? skills;
  final List<LanguageProficiencyModel>? languages;
  final List<CertificationModel>? certifications;
  final JobPreferencesModel? jobPreferences;

  const SeekerProfileAPICreateRequestModel({
    required this.personalDetails,
    required this.contactDetails,
    this.educationDetails,
    this.workExperience,
    this.skills,
    this.languages,
    this.certifications,
    this.jobPreferences,
  });

  factory SeekerProfileAPICreateRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SeekerProfileAPICreateRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$SeekerProfileAPICreateRequestModelToJson(this);

  @override
  List<Object?> get props => [
        personalDetails,
        contactDetails,
        educationDetails,
        workExperience,
        skills,
        languages,
        certifications,
        jobPreferences,
      ];
}

/// API response model for profile operations
@JsonSerializable()
class APIResponseModel<T> extends Equatable {
  final bool success;
  final String? message;
  final T? data;

  const APIResponseModel({
    required this.success,
    this.message,
    this.data,
  });

  factory APIResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return APIResponseModel<T>(
      success: json['success'] as bool,
      message: json['message'] as String?,
      data: json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    return {
      'success': success,
      'message': message,
      if (data != null) 'data': toJsonT(data as T),
    };
  }

  @override
  List<Object?> get props => [success, message, data];
}

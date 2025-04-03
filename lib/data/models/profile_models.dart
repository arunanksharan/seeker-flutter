import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_models.g.dart';

// --- Enums --- //

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

enum Gender {
  @JsonValue('Male')
  male,
  @JsonValue('Female')
  female,
  @JsonValue('Other')
  other,
}

enum ProficiencyLevel {
  @JsonValue('Beginner')
  beginner,
  @JsonValue('Intermediate')
  intermediate,
  @JsonValue('Advanced')
  advanced,
  @JsonValue('Native')
  native,
}

enum VerificationStatus {
  @JsonValue('Pending')
  pending,
  @JsonValue('Verified')
  verified,
  @JsonValue('Rejected')
  rejected,
}

enum JobType {
  @JsonValue('Full-time')
  fullTime,
  @JsonValue('Part-time')
  partTime,
  @JsonValue('Contract')
  contract,
  @JsonValue('Internship')
  internship,
  @JsonValue('Freelance')
  freelance,
}

enum WorkLocationType {
  @JsonValue('Onsite')
  onsite,
  @JsonValue('Remote')
  remote,
  @JsonValue('Hybrid')
  hybrid,
}

// --- Interfaces as Classes --- //

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class AddressModel extends Equatable {
  final String? street;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? country;
  final bool? isCurrent;

  const AddressModel({
    this.street,
    this.city,
    this.state,
    this.postalCode,
    this.country,
    this.isCurrent,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddressModelToJson(this);

  @override
  List<Object?> get props =>
      [street, city, state, postalCode, country, isCurrent];
}

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class PersonalDetailsModel extends Equatable {
  final String? name;
  final String? fatherName;
  final String? motherName;
  final String? gender; // Could use Gender enum if API guarantees values
  final DateTime? dob; // Use DateTime for dates
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
}

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class ContactDetailsModel extends Equatable {
  final String? primaryMobile;
  final String? secondaryMobile;
  final String? email;
  final AddressModel? permanentAddress;
  final AddressModel? currentAddress;

  const ContactDetailsModel({
    this.primaryMobile,
    this.secondaryMobile,
    this.email,
    this.permanentAddress,
    this.currentAddress,
  });

  factory ContactDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$ContactDetailsModelFromJson(json);
  Map<String, dynamic> toJson() => _$ContactDetailsModelToJson(this);

  @override
  List<Object?> get props => [
        primaryMobile,
        secondaryMobile,
        email,
        permanentAddress,
        currentAddress,
      ];
}

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class EducationDetailModel extends Equatable {
  final String? instituteName;
  final String? fieldOfStudy;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? yearOfPassing;
  final double? gradePercentageCgpa; // Use double for numerical grades
  final bool? isCurrent;
  final List<String>? marksheetUrl;
  final List<String>? certificateUrl;
  final VerificationStatus? verificationStatus;

  const EducationDetailModel({
    this.instituteName,
    this.fieldOfStudy,
    this.startDate,
    this.endDate,
    this.yearOfPassing,
    this.gradePercentageCgpa,
    this.isCurrent,
    this.marksheetUrl,
    this.certificateUrl,
    this.verificationStatus,
  });

  factory EducationDetailModel.fromJson(Map<String, dynamic> json) =>
      _$EducationDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$EducationDetailModelToJson(this);

  @override
  List<Object?> get props => [
        instituteName,
        fieldOfStudy,
        startDate,
        endDate,
        yearOfPassing,
        gradePercentageCgpa,
        isCurrent,
        marksheetUrl,
        certificateUrl,
        verificationStatus,
      ];
}

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class EducationDetailsModel extends Equatable {
  final String? highestLevel; // Consider using EducationLevel enum if applicable
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
}

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class WorkExperienceModel extends Equatable {
  final String? companyName;
  final String? designation;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool? isCurrent;
  final String? description;
  final List<String>? experienceLetterUrl;
  final List<String>? payslipUrls;

  const WorkExperienceModel({
    this.companyName,
    this.designation,
    this.startDate,
    this.endDate,
    this.isCurrent,
    this.description,
    this.experienceLetterUrl,
    this.payslipUrls,
  });

  factory WorkExperienceModel.fromJson(Map<String, dynamic> json) =>
      _$WorkExperienceModelFromJson(json);
  Map<String, dynamic> toJson() => _$WorkExperienceModelToJson(this);

  @override
  List<Object?> get props => [
        companyName,
        designation,
        startDate,
        endDate,
        isCurrent,
        description,
        experienceLetterUrl,
        payslipUrls,
      ];
}

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class SkillModel extends Equatable {
  final String? name;
  final String? proficiencyLevel; // Consider using ProficiencyLevel enum
  final String? experience; // e.g., "2 years", might need parsing

  const SkillModel({
    this.name,
    this.proficiencyLevel,
    this.experience,
  });

  factory SkillModel.fromJson(Map<String, dynamic> json) =>
      _$SkillModelFromJson(json);
  Map<String, dynamic> toJson() => _$SkillModelToJson(this);

  @override
  List<Object?> get props => [name, proficiencyLevel, experience];
}

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class CertificationModel extends Equatable {
  final String name;
  final String? issuingOrganization;
  final DateTime? issueDate;
  final DateTime? expiryDate;
  final String? credentialId;
  final String? credentialUrl;
  final String? certificateUrl;
  final VerificationStatus? verificationStatus;

  const CertificationModel({
    required this.name,
    this.issuingOrganization,
    this.issueDate,
    this.expiryDate,
    this.credentialId,
    this.credentialUrl,
    this.certificateUrl,
    this.verificationStatus,
  });

  factory CertificationModel.fromJson(Map<String, dynamic> json) =>
      _$CertificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$CertificationModelToJson(this);

  @override
  List<Object?> get props => [
        name,
        issuingOrganization,
        issueDate,
        expiryDate,
        credentialId,
        credentialUrl,
        certificateUrl,
        verificationStatus,
      ];
}

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class LanguageProficiencyModel extends Equatable {
  final String language;
  final ProficiencyLevel? spoken;
  final ProficiencyLevel? written;
  final ProficiencyLevel? reading;

  const LanguageProficiencyModel({
    required this.language,
    this.spoken,
    this.written,
    this.reading,
  });

  factory LanguageProficiencyModel.fromJson(Map<String, dynamic> json) =>
      _$LanguageProficiencyModelFromJson(json);
  Map<String, dynamic> toJson() => _$LanguageProficiencyModelToJson(this);

  @override
  List<Object?> get props => [language, spoken, written, reading];
}

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class ItiDetailModel extends Equatable {
  final String? instituteName;
  final String? trade;
  final String? trainingDuration;
  final int? passingYear;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool? isCurrent;
  final List<String>? certificateUrls;
  final String? grade;
  final String? rollNumber;
  final String? certificateNumber;
  final VerificationStatus? verificationStatus;

  const ItiDetailModel({
    this.instituteName,
    this.trade,
    this.trainingDuration,
    this.passingYear,
    this.startDate,
    this.endDate,
    this.isCurrent,
    this.certificateUrls,
    this.grade,
    this.rollNumber,
    this.certificateNumber,
    this.verificationStatus,
  });

  factory ItiDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ItiDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$ItiDetailModelToJson(this);

  @override
  List<Object?> get props => [
        instituteName,
        trade,
        trainingDuration,
        passingYear,
        startDate,
        endDate,
        isCurrent,
        certificateUrls,
        grade,
        rollNumber,
        certificateNumber,
        verificationStatus,
      ];
}

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class IdentificationDocModel extends Equatable {
  final String? docType;
  final String? docNumber;
  final String? name;
  final List<String>? urls;

  const IdentificationDocModel({
    this.docType,
    this.docNumber,
    this.name,
    this.urls,
  });

  factory IdentificationDocModel.fromJson(Map<String, dynamic> json) =>
      _$IdentificationDocModelFromJson(json);
  Map<String, dynamic> toJson() => _$IdentificationDocModelToJson(this);

  @override
  List<Object?> get props => [docType, docNumber, name, urls];
}

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class BankDetailModel extends Equatable {
  final String? accountNumber;
  final String? ifscCode;
  final String? bankName;
  final String? branchName;
  final String? accountHolderName;

  const BankDetailModel({
    this.accountNumber,
    this.ifscCode,
    this.bankName,
    this.branchName,
    this.accountHolderName,
  });

  factory BankDetailModel.fromJson(Map<String, dynamic> json) =>
      _$BankDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$BankDetailModelToJson(this);

  @override
  List<Object?> get props =>
      [accountNumber, ifscCode, bankName, branchName, accountHolderName];
}

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class JobPreferencesModel extends Equatable {
  final List<JobType>? jobTypes; // Use enum
  final List<WorkLocationType>? workLocationTypes; // Use enum
  final List<String>? jobRoles;
  final List<String>? industries;
  final String? minSalaryExpectation; // Consider using num/double if API provides
  final String? maxSalaryExpectation; // Consider using num/double if API provides
  final int? noticePeriodDays;
  final bool? isWillingToRelocate;
  final bool? isActivelyLooking;
  final String? preferredJobLocations;
  final String? currentLocation;
  final String? totalExperienceYears; // Consider parsing to double/num
  final String? currentMonthlySalary; // Consider using num/double if API provides

  const JobPreferencesModel({
    this.jobTypes,
    this.workLocationTypes,
    this.jobRoles,
    this.industries,
    this.minSalaryExpectation,
    this.maxSalaryExpectation,
    this.noticePeriodDays,
    this.isWillingToRelocate,
    this.isActivelyLooking,
    this.preferredJobLocations,
    this.currentLocation,
    this.totalExperienceYears,
    this.currentMonthlySalary,
  });

  factory JobPreferencesModel.fromJson(Map<String, dynamic> json) =>
      _$JobPreferencesModelFromJson(json);
  Map<String, dynamic> toJson() => _$JobPreferencesModelToJson(this);

  @override
  List<Object?> get props => [
        jobTypes,
        workLocationTypes,
        jobRoles,
        industries,
        minSalaryExpectation,
        maxSalaryExpectation,
        noticePeriodDays,
        isWillingToRelocate,
        isActivelyLooking,
        preferredJobLocations,
        currentLocation,
        totalExperienceYears,
        currentMonthlySalary,
      ];
}

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class ReviewModel extends Equatable {
  final String reviewerName;
  final String? reviewerDesignation;
  final String? reviewerCompany;
  final double rating; // Use double for rating
  final String? comments;
  final DateTime? reviewDate;

  const ReviewModel({
    required this.reviewerName,
    this.reviewerDesignation,
    this.reviewerCompany,
    required this.rating,
    this.comments,
    this.reviewDate,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);

  @override
  List<Object?> get props => [
        reviewerName,
        reviewerDesignation,
        reviewerCompany,
        rating,
        comments,
        reviewDate,
      ];
}

// Representing the Blob type simply as a Map
// typedef CurrentProfileBlob = Map<String, dynamic>;

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class SeekerProfileBaseModel extends Equatable {
  final PersonalDetailsModel? personalDetails;
  final ContactDetailsModel? contactDetails;
  final List<IdentificationDocModel>? identificationDocs;
  final List<BankDetailModel>? bankDetails;
  final EducationDetailsModel? educationDetails;
  final List<WorkExperienceModel>? workExperiences;
  final List<CertificationModel>? certifications;
  final List<LanguageProficiencyModel>? languageProficiencies;
  final JobPreferencesModel? jobPreferences;
  final List<ItiDetailModel>? itiDetails;
  final List<SkillModel>? skills;
  final double? assessmentScore;
  final List<ReviewModel>? reviews;
  final List<Map<String, dynamic>>? callMetadataHistory; // Using Map for Blob
  final Map<String, dynamic>? currentProfile; // Using Map for Blob

  const SeekerProfileBaseModel({
    this.personalDetails,
    this.contactDetails,
    this.identificationDocs,
    this.bankDetails,
    this.educationDetails,
    this.workExperiences,
    this.certifications,
    this.languageProficiencies,
    this.jobPreferences,
    this.itiDetails,
    this.skills,
    this.assessmentScore,
    this.reviews,
    this.callMetadataHistory,
    this.currentProfile,
  });

  @override
  List<Object?> get props => [
        personalDetails,
        contactDetails,
        identificationDocs,
        bankDetails,
        educationDetails,
        workExperiences,
        certifications,
        languageProficiencies,
        jobPreferences,
        itiDetails,
        skills,
        assessmentScore,
        reviews,
        callMetadataHistory,
        currentProfile,
      ];
}

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class SeekerProfileAPICreateRequestModel extends SeekerProfileBaseModel {
  const SeekerProfileAPICreateRequestModel({
    super.personalDetails,
    super.contactDetails,
    super.identificationDocs,
    super.bankDetails,
    super.educationDetails,
    super.workExperiences,
    super.certifications,
    super.languageProficiencies,
    super.jobPreferences,
    super.itiDetails,
    super.skills,
    super.assessmentScore,
    super.reviews,
    super.callMetadataHistory,
    super.currentProfile,
  });

  factory SeekerProfileAPICreateRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SeekerProfileAPICreateRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$SeekerProfileAPICreateRequestModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class SeekerProfileAPIResponseModel extends SeekerProfileBaseModel {
  final String id;
  final String seekerId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const SeekerProfileAPIResponseModel({
    required this.id,
    required this.seekerId,
    this.createdAt,
    this.updatedAt,
    super.personalDetails,
    super.contactDetails,
    super.identificationDocs,
    super.bankDetails,
    super.educationDetails,
    super.workExperiences,
    super.certifications,
    super.languageProficiencies,
    super.jobPreferences,
    super.itiDetails,
    super.skills,
    super.assessmentScore,
    super.reviews,
    super.callMetadataHistory,
    super.currentProfile,
  });

  factory SeekerProfileAPIResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SeekerProfileAPIResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$SeekerProfileAPIResponseModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        seekerId,
        createdAt,
        updatedAt,
        ...super.props // Include props from the base class
      ];
}

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class SeekerProfileAPIUpdateRequestModel extends SeekerProfileBaseModel {
  const SeekerProfileAPIUpdateRequestModel({
    super.personalDetails,
    super.contactDetails,
    super.identificationDocs,
    super.bankDetails,
    super.educationDetails,
    super.workExperiences,
    super.certifications,
    super.languageProficiencies,
    super.jobPreferences,
    super.itiDetails,
    super.skills,
    super.assessmentScore,
    super.reviews,
    super.callMetadataHistory,
    super.currentProfile,
  });

  factory SeekerProfileAPIUpdateRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SeekerProfileAPIUpdateRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$SeekerProfileAPIUpdateRequestModelToJson(this);
}

import 'package:equatable/equatable.dart';
import 'package:seeker_flutter/data/models/profile_models.dart';

/// Base class for all profile events
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

/// Fetch the current user's profile
class ProfileFetched extends ProfileEvent {
  const ProfileFetched();
}

/// Check if a profile exists for the current user
class ProfileExistenceChecked extends ProfileEvent {
  const ProfileExistenceChecked();
}

/// Create a new profile
class ProfileCreated extends ProfileEvent {
  final SeekerProfileAPICreateRequestModel profile;

  const ProfileCreated(this.profile);

  @override
  List<Object?> get props => [profile];
}

/// Update an existing profile
class ProfileUpdated extends ProfileEvent {
  final SeekerProfileAPIUpdateRequestModel profile;

  const ProfileUpdated(this.profile);

  @override
  List<Object?> get props => [profile];
}

/// Update personal details section of the profile
class ProfilePersonalDetailsUpdated extends ProfileEvent {
  final PersonalDetailsModel personalDetails;

  const ProfilePersonalDetailsUpdated(this.personalDetails);

  @override
  List<Object?> get props => [personalDetails];
}

/// Update contact details section of the profile
class ProfileContactDetailsUpdated extends ProfileEvent {
  final ContactDetailsModel contactDetails;

  const ProfileContactDetailsUpdated(this.contactDetails);

  @override
  List<Object?> get props => [contactDetails];
}

/// Update education details section of the profile
class ProfileEducationDetailsUpdated extends ProfileEvent {
  final EducationDetailsModel educationDetails;

  const ProfileEducationDetailsUpdated(this.educationDetails);

  @override
  List<Object?> get props => [educationDetails];
}

/// Update job preferences section of the profile
class ProfileJobPreferencesUpdated extends ProfileEvent {
  final JobPreferencesModel jobPreferences;

  const ProfileJobPreferencesUpdated(this.jobPreferences);

  @override
  List<Object?> get props => [jobPreferences];
}

/// Update work experiences section of the profile
class ProfileWorkExperiencesUpdated extends ProfileEvent {
  final List<WorkExperienceModel> workExperiences;

  const ProfileWorkExperiencesUpdated(this.workExperiences);

  @override
  List<Object?> get props => [workExperiences];
}

/// Update certifications section of the profile
class ProfileCertificationsUpdated extends ProfileEvent {
  final List<CertificationModel> certifications;

  const ProfileCertificationsUpdated(this.certifications);

  @override
  List<Object?> get props => [certifications];
}

/// Update language proficiencies section of the profile
class ProfileLanguageProficienciesUpdated extends ProfileEvent {
  final List<LanguageProficiencyModel> languageProficiencies;

  const ProfileLanguageProficienciesUpdated(this.languageProficiencies);

  @override
  List<Object?> get props => [languageProficiencies];
}

/// Update skills section of the profile
class ProfileSkillsUpdated extends ProfileEvent {
  final List<SkillModel> skills;

  const ProfileSkillsUpdated(this.skills);

  @override
  List<Object?> get props => [skills];
}

/// Update ITI details section of the profile
class ProfileItiDetailsUpdated extends ProfileEvent {
  final List<ItiDetailModel> itiDetails;

  const ProfileItiDetailsUpdated(this.itiDetails);

  @override
  List<Object?> get props => [itiDetails];
}

/// Upload a document
class ProfileDocumentUploaded extends ProfileEvent {
  final String documentType;
  final List<int> fileBytes;
  final String fileName;

  const ProfileDocumentUploaded({
    required this.documentType,
    required this.fileBytes,
    required this.fileName,
  });

  @override
  List<Object?> get props => [documentType, fileBytes, fileName];
}

/// Delete the current profile
class ProfileDeleted extends ProfileEvent {
  const ProfileDeleted();
}

/// Reset profile state (e.g., after logout)
class ProfileReset extends ProfileEvent {
  const ProfileReset();
}

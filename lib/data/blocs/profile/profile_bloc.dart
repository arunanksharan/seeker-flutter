import 'package:bloc/bloc.dart';
import 'package:seeker_flutter/data/blocs/profile/profile_event.dart';
import 'package:seeker_flutter/data/blocs/profile/profile_state.dart';
import 'package:seeker_flutter/data/services/profile_service.dart';
import 'package:seeker_flutter/utils/logger.dart';

/// BLoC for managing profile state
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileService _profileService;

  ProfileBloc({required ProfileService profileService})
      : _profileService = profileService,
        super(const ProfileInitial()) {
    // Register event handlers
    on<ProfileFetched>(_onProfileFetched);
    on<ProfileExistenceChecked>(_onProfileExistenceChecked);
    on<ProfileCreated>(_onProfileCreated);
    on<ProfileUpdated>(_onProfileUpdated);
    on<ProfilePersonalDetailsUpdated>(_onProfilePersonalDetailsUpdated);
    on<ProfileContactDetailsUpdated>(_onProfileContactDetailsUpdated);
    on<ProfileEducationDetailsUpdated>(_onProfileEducationDetailsUpdated);
    on<ProfileJobPreferencesUpdated>(_onProfileJobPreferencesUpdated);
    on<ProfileWorkExperiencesUpdated>(_onProfileWorkExperiencesUpdated);
    on<ProfileCertificationsUpdated>(_onProfileCertificationsUpdated);
    on<ProfileLanguageProficienciesUpdated>(_onProfileLanguageProficienciesUpdated);
    on<ProfileSkillsUpdated>(_onProfileSkillsUpdated);
    on<ProfileItiDetailsUpdated>(_onProfileItiDetailsUpdated);
    on<ProfileDocumentUploaded>(_onProfileDocumentUploaded);
    on<ProfileDeleted>(_onProfileDeleted);
    on<ProfileReset>(_onProfileReset);
  }

  /// Fetch the current user's profile
  Future<void> _onProfileFetched(
      ProfileFetched event, Emitter<ProfileState> emit) async {
    emit(const ProfileLoading());
    try {
      final profile = await _profileService.getProfile();
      emit(ProfileLoaded(profile));
    } catch (e) {
      logError('Fetching profile failed', e);
      emit(ProfileFailure(message: e.toString()));
    }
  }

  /// Check if a profile exists for the current user
  Future<void> _onProfileExistenceChecked(
      ProfileExistenceChecked event, Emitter<ProfileState> emit) async {
    emit(const ProfileLoading());
    try {
      final exists = await _profileService.hasProfile();
      if (exists) {
        emit(const ProfileExists());
      } else {
        emit(const ProfileNotExists());
      }
    } catch (e) {
      logError('Checking profile existence failed', e);
      emit(ProfileFailure(message: e.toString()));
    }
  }

  /// Create a new profile
  Future<void> _onProfileCreated(
      ProfileCreated event, Emitter<ProfileState> emit) async {
    emit(const ProfileCreationInProgress());
    try {
      final profile = await _profileService.createProfile(event.profile);
      emit(ProfileCreationSuccess(profile));
    } catch (e) {
      logError('Creating profile failed', e);
      emit(ProfileFailure(message: e.toString()));
    }
  }

  /// Update an existing profile
  Future<void> _onProfileUpdated(
      ProfileUpdated event, Emitter<ProfileState> emit) async {
    emit(const ProfileUpdateInProgress());
    try {
      final profile = await _profileService.updateProfile(event.profile);
      emit(ProfileUpdateSuccess(profile));
    } catch (e) {
      logError('Updating profile failed', e);
      emit(ProfileFailure(message: e.toString()));
    }
  }

  /// Update personal details section of the profile
  Future<void> _onProfilePersonalDetailsUpdated(
      ProfilePersonalDetailsUpdated event, Emitter<ProfileState> emit) async {
    emit(const ProfileUpdateInProgress());
    try {
      final profile = await _profileService.updateProfileSection(
        personalDetails: event.personalDetails,
      );
      emit(ProfileSectionUpdateSuccess(
        profile: profile,
        sectionName: 'personalDetails',
      ));
    } catch (e) {
      logError('Updating personal details failed', e);
      emit(ProfileFailure(message: e.toString()));
    }
  }

  /// Update contact details section of the profile
  Future<void> _onProfileContactDetailsUpdated(
      ProfileContactDetailsUpdated event, Emitter<ProfileState> emit) async {
    emit(const ProfileUpdateInProgress());
    try {
      final profile = await _profileService.updateProfileSection(
        contactDetails: event.contactDetails,
      );
      emit(ProfileSectionUpdateSuccess(
        profile: profile,
        sectionName: 'contactDetails',
      ));
    } catch (e) {
      logError('Updating contact details failed', e);
      emit(ProfileFailure(message: e.toString()));
    }
  }

  /// Update education details section of the profile
  Future<void> _onProfileEducationDetailsUpdated(
      ProfileEducationDetailsUpdated event, Emitter<ProfileState> emit) async {
    emit(const ProfileUpdateInProgress());
    try {
      final profile = await _profileService.updateProfileSection(
        educationDetails: event.educationDetails,
      );
      emit(ProfileSectionUpdateSuccess(
        profile: profile,
        sectionName: 'educationDetails',
      ));
    } catch (e) {
      logError('Updating education details failed', e);
      emit(ProfileFailure(message: e.toString()));
    }
  }

  /// Update job preferences section of the profile
  Future<void> _onProfileJobPreferencesUpdated(
      ProfileJobPreferencesUpdated event, Emitter<ProfileState> emit) async {
    emit(const ProfileUpdateInProgress());
    try {
      final profile = await _profileService.updateProfileSection(
        jobPreferences: event.jobPreferences,
      );
      emit(ProfileSectionUpdateSuccess(
        profile: profile,
        sectionName: 'jobPreferences',
      ));
    } catch (e) {
      logError('Updating job preferences failed', e);
      emit(ProfileFailure(message: e.toString()));
    }
  }

  /// Update work experiences section of the profile
  Future<void> _onProfileWorkExperiencesUpdated(
      ProfileWorkExperiencesUpdated event, Emitter<ProfileState> emit) async {
    emit(const ProfileUpdateInProgress());
    try {
      final profile = await _profileService.updateProfileSection(
        workExperiences: event.workExperiences,
      );
      emit(ProfileSectionUpdateSuccess(
        profile: profile,
        sectionName: 'workExperiences',
      ));
    } catch (e) {
      logError('Updating work experiences failed', e);
      emit(ProfileFailure(message: e.toString()));
    }
  }

  /// Update certifications section of the profile
  Future<void> _onProfileCertificationsUpdated(
      ProfileCertificationsUpdated event, Emitter<ProfileState> emit) async {
    emit(const ProfileUpdateInProgress());
    try {
      final profile = await _profileService.updateProfileSection(
        certifications: event.certifications,
      );
      emit(ProfileSectionUpdateSuccess(
        profile: profile,
        sectionName: 'certifications',
      ));
    } catch (e) {
      logError('Updating certifications failed', e);
      emit(ProfileFailure(message: e.toString()));
    }
  }

  /// Update language proficiencies section of the profile
  Future<void> _onProfileLanguageProficienciesUpdated(
      ProfileLanguageProficienciesUpdated event,
      Emitter<ProfileState> emit) async {
    emit(const ProfileUpdateInProgress());
    try {
      final profile = await _profileService.updateProfileSection(
        languageProficiencies: event.languageProficiencies,
      );
      emit(ProfileSectionUpdateSuccess(
        profile: profile,
        sectionName: 'languageProficiencies',
      ));
    } catch (e) {
      logError('Updating language proficiencies failed', e);
      emit(ProfileFailure(message: e.toString()));
    }
  }

  /// Update skills section of the profile
  Future<void> _onProfileSkillsUpdated(
      ProfileSkillsUpdated event, Emitter<ProfileState> emit) async {
    emit(const ProfileUpdateInProgress());
    try {
      final profile = await _profileService.updateProfileSection(
        skills: event.skills,
      );
      emit(ProfileSectionUpdateSuccess(
        profile: profile,
        sectionName: 'skills',
      ));
    } catch (e) {
      logError('Updating skills failed', e);
      emit(ProfileFailure(message: e.toString()));
    }
  }

  /// Update ITI details section of the profile
  Future<void> _onProfileItiDetailsUpdated(
      ProfileItiDetailsUpdated event, Emitter<ProfileState> emit) async {
    emit(const ProfileUpdateInProgress());
    try {
      final profile = await _profileService.updateProfileSection(
        itiDetails: event.itiDetails,
      );
      emit(ProfileSectionUpdateSuccess(
        profile: profile,
        sectionName: 'itiDetails',
      ));
    } catch (e) {
      logError('Updating ITI details failed', e);
      emit(ProfileFailure(message: e.toString()));
    }
  }

  /// Upload a document
  Future<void> _onProfileDocumentUploaded(
      ProfileDocumentUploaded event, Emitter<ProfileState> emit) async {
    emit(const ProfileDocumentUploadInProgress());
    try {
      final documentUrl = await _profileService.uploadDocument(
        event.documentType,
        event.fileBytes,
        event.fileName,
      );
      emit(ProfileDocumentUploadSuccess(documentUrl));
    } catch (e) {
      logError('Uploading document failed', e);
      emit(ProfileFailure(message: e.toString()));
    }
  }

  /// Delete the current profile
  Future<void> _onProfileDeleted(
      ProfileDeleted event, Emitter<ProfileState> emit) async {
    emit(const ProfileDeletionInProgress());
    try {
      final success = await _profileService.deleteProfile();
      if (success) {
        emit(const ProfileDeletionSuccess());
      } else {
        emit(const ProfileFailure(message: 'Profile deletion failed'));
      }
    } catch (e) {
      logError('Deleting profile failed', e);
      emit(ProfileFailure(message: e.toString()));
    }
  }

  /// Reset profile state
  void _onProfileReset(ProfileReset event, Emitter<ProfileState> emit) {
    emit(const ProfileInitial());
  }
}

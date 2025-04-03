import 'package:seeker_flutter/data/models/profile_models.dart';
import 'package:seeker_flutter/data/services/api_client.dart';
import 'package:seeker_flutter/utils/logger.dart';

/// Service for handling profile operations
class ProfileService {
  final ApiClient _apiClient;

  /// Endpoints for profile-related API calls
  static const _profileEndpoint = '/profile';
  static const _uploadDocumentEndpoint = '/profile/document';

  ProfileService(this._apiClient);

  /// Get the current user's profile
  Future<SeekerProfileAPIResponseModel> getProfile() async {
    try {
      final response = await _apiClient.get(_profileEndpoint);
      return SeekerProfileAPIResponseModel.fromJson(response);
    } catch (e) {
      logError('Get profile failed', e);
      rethrow;
    }
  }

  /// Create a new profile
  Future<SeekerProfileAPIResponseModel> createProfile(
      SeekerProfileAPICreateRequestModel profileData) async {
    try {
      final response = await _apiClient.post(
        _profileEndpoint,
        body: profileData.toJson(),
      );
      return SeekerProfileAPIResponseModel.fromJson(response);
    } catch (e) {
      logError('Create profile failed', e);
      rethrow;
    }
  }

  /// Update an existing profile
  Future<SeekerProfileAPIResponseModel> updateProfile(
      SeekerProfileAPIUpdateRequestModel profileData) async {
    try {
      final response = await _apiClient.put(
        _profileEndpoint,
        body: profileData.toJson(),
      );
      return SeekerProfileAPIResponseModel.fromJson(response);
    } catch (e) {
      logError('Update profile failed', e);
      rethrow;
    }
  }

  /// Helper method to update a specific section of the profile
  Future<SeekerProfileAPIResponseModel> updateProfileSection({
    PersonalDetailsModel? personalDetails,
    ContactDetailsModel? contactDetails,
    EducationDetailsModel? educationDetails,
    JobPreferencesModel? jobPreferences,
    List<WorkExperienceModel>? workExperiences,
    List<CertificationModel>? certifications,
    List<LanguageProficiencyModel>? languageProficiencies,
    List<SkillModel>? skills,
    List<ItiDetailModel>? itiDetails,
    List<IdentificationDocModel>? identificationDocs,
    List<BankDetailModel>? bankDetails,
  }) async {
    try {
      // Create a request with only the specified section
      final updateRequest = SeekerProfileAPIUpdateRequestModel(
        personalDetails: personalDetails,
        contactDetails: contactDetails,
        educationDetails: educationDetails,
        jobPreferences: jobPreferences,
        workExperiences: workExperiences,
        certifications: certifications,
        languageProficiencies: languageProficiencies,
        skills: skills,
        itiDetails: itiDetails,
        identificationDocs: identificationDocs,
        bankDetails: bankDetails,
      );

      return await updateProfile(updateRequest);
    } catch (e) {
      logError('Update profile section failed', e);
      rethrow;
    }
  }

  /// Upload a document (profile picture, certificate, etc.)
  /// Note: This is a simplified version. In a real implementation, you would use a
  /// multipart/form-data request with a file upload.
  Future<String> uploadDocument(String documentType, List<int> fileBytes, String fileName) async {
    try {
      // In a real implementation, you would use http.MultipartRequest
      // This is a placeholder implementation
      final response = await _apiClient.post(
        _uploadDocumentEndpoint,
        body: {
          'document_type': documentType,
          'file_name': fileName,
          // In a real implementation, you would not convert file bytes to base64 in the body
          // Instead, you would use MultipartFile.fromBytes
          'file_data': fileBytes,
        },
      );
      
      if (response['url'] != null) {
        return response['url'] as String;
      } else {
        throw ApiException('Document upload did not return a URL');
      }
    } catch (e) {
      logError('Document upload failed', e);
      rethrow;
    }
  }

  /// Delete a profile (rarely used, but included for completeness)
  Future<bool> deleteProfile() async {
    try {
      final response = await _apiClient.delete(_profileEndpoint);
      return response['success'] == true;
    } catch (e) {
      logError('Delete profile failed', e);
      rethrow;
    }
  }

  /// Verify if a profile exists for the current user
  Future<bool> hasProfile() async {
    try {
      final response = await _apiClient.get('$_profileEndpoint/exists');
      return response['exists'] == true;
    } catch (e) {
      logError('Check profile existence failed', e);
      return false; // Assume no profile exists if check fails
    }
  }

  /// Get a specific profile by ID (for admins or special cases)
  Future<SeekerProfileAPIResponseModel> getProfileById(String profileId) async {
    try {
      final response = await _apiClient.get('$_profileEndpoint/$profileId');
      return SeekerProfileAPIResponseModel.fromJson(response);
    } catch (e) {
      logError('Get profile by ID failed', e);
      rethrow;
    }
  }
}

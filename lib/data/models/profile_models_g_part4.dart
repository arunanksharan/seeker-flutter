// File will be combined into profile_models.g.dart
// This is part 4 of the serialization code

// SeekerProfileBaseModel
// Note: This is an abstract base class, so no direct fromJson/toJson methods needed

// SeekerProfileAPICreateRequestModel
SeekerProfileAPICreateRequestModel _$SeekerProfileAPICreateRequestModelFromJson(
        Map<String, dynamic> json) =>
    SeekerProfileAPICreateRequestModel(
      personalDetails: json['personal_details'] == null
          ? null
          : PersonalDetailsModel.fromJson(
              json['personal_details'] as Map<String, dynamic>),
      contactDetails: json['contact_details'] == null
          ? null
          : ContactDetailsModel.fromJson(
              json['contact_details'] as Map<String, dynamic>),
      identificationDocs: (json['identification_docs'] as List<dynamic>?)
          ?.map((e) => IdentificationDocModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      bankDetails: (json['bank_details'] as List<dynamic>?)
          ?.map((e) => BankDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      educationDetails: json['education_details'] == null
          ? null
          : EducationDetailsModel.fromJson(
              json['education_details'] as Map<String, dynamic>),
      workExperiences: (json['work_experiences'] as List<dynamic>?)
          ?.map((e) => WorkExperienceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      certifications: (json['certifications'] as List<dynamic>?)
          ?.map((e) => CertificationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      languageProficiencies: (json['language_proficiencies'] as List<dynamic>?)
          ?.map((e) => LanguageProficiencyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      jobPreferences: json['job_preferences'] == null
          ? null
          : JobPreferencesModel.fromJson(
              json['job_preferences'] as Map<String, dynamic>),
      itiDetails: (json['iti_details'] as List<dynamic>?)
          ?.map((e) => ItiDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      skills: (json['skills'] as List<dynamic>?)
          ?.map((e) => SkillModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      assessmentScore: (json['assessment_score'] as num?)?.toDouble(),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      callMetadataHistory: (json['call_metadata_history'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      currentProfile: json['current_profile'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$SeekerProfileAPICreateRequestModelToJson(
    SeekerProfileAPICreateRequestModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('personal_details', instance.personalDetails?.toJson());
  writeNotNull('contact_details', instance.contactDetails?.toJson());
  writeNotNull('identification_docs',
      instance.identificationDocs?.map((e) => e.toJson()).toList());
  writeNotNull('bank_details',
      instance.bankDetails?.map((e) => e.toJson()).toList());
  writeNotNull('education_details', instance.educationDetails?.toJson());
  writeNotNull('work_experiences',
      instance.workExperiences?.map((e) => e.toJson()).toList());
  writeNotNull('certifications',
      instance.certifications?.map((e) => e.toJson()).toList());
  writeNotNull('language_proficiencies',
      instance.languageProficiencies?.map((e) => e.toJson()).toList());
  writeNotNull('job_preferences', instance.jobPreferences?.toJson());
  writeNotNull(
      'iti_details', instance.itiDetails?.map((e) => e.toJson()).toList());
  writeNotNull('skills', instance.skills?.map((e) => e.toJson()).toList());
  writeNotNull('assessment_score', instance.assessmentScore);
  writeNotNull('reviews', instance.reviews?.map((e) => e.toJson()).toList());
  writeNotNull('call_metadata_history', instance.callMetadataHistory);
  writeNotNull('current_profile', instance.currentProfile);
  return val;
}

// SeekerProfileAPIResponseModel
SeekerProfileAPIResponseModel _$SeekerProfileAPIResponseModelFromJson(
        Map<String, dynamic> json) =>
    SeekerProfileAPIResponseModel(
      id: json['id'] as String,
      seekerId: json['seeker_id'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      personalDetails: json['personal_details'] == null
          ? null
          : PersonalDetailsModel.fromJson(
              json['personal_details'] as Map<String, dynamic>),
      contactDetails: json['contact_details'] == null
          ? null
          : ContactDetailsModel.fromJson(
              json['contact_details'] as Map<String, dynamic>),
      identificationDocs: (json['identification_docs'] as List<dynamic>?)
          ?.map((e) => IdentificationDocModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      bankDetails: (json['bank_details'] as List<dynamic>?)
          ?.map((e) => BankDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      educationDetails: json['education_details'] == null
          ? null
          : EducationDetailsModel.fromJson(
              json['education_details'] as Map<String, dynamic>),
      workExperiences: (json['work_experiences'] as List<dynamic>?)
          ?.map((e) => WorkExperienceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      certifications: (json['certifications'] as List<dynamic>?)
          ?.map((e) => CertificationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      languageProficiencies: (json['language_proficiencies'] as List<dynamic>?)
          ?.map((e) => LanguageProficiencyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      jobPreferences: json['job_preferences'] == null
          ? null
          : JobPreferencesModel.fromJson(
              json['job_preferences'] as Map<String, dynamic>),
      itiDetails: (json['iti_details'] as List<dynamic>?)
          ?.map((e) => ItiDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      skills: (json['skills'] as List<dynamic>?)
          ?.map((e) => SkillModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      assessmentScore: (json['assessment_score'] as num?)?.toDouble(),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      callMetadataHistory: (json['call_metadata_history'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      currentProfile: json['current_profile'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$SeekerProfileAPIResponseModelToJson(
    SeekerProfileAPIResponseModel instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'seeker_id': instance.seekerId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  writeNotNull('updated_at', instance.updatedAt?.toIso8601String());
  writeNotNull('personal_details', instance.personalDetails?.toJson());
  writeNotNull('contact_details', instance.contactDetails?.toJson());
  writeNotNull('identification_docs',
      instance.identificationDocs?.map((e) => e.toJson()).toList());
  writeNotNull('bank_details',
      instance.bankDetails?.map((e) => e.toJson()).toList());
  writeNotNull('education_details', instance.educationDetails?.toJson());
  writeNotNull('work_experiences',
      instance.workExperiences?.map((e) => e.toJson()).toList());
  writeNotNull('certifications',
      instance.certifications?.map((e) => e.toJson()).toList());
  writeNotNull('language_proficiencies',
      instance.languageProficiencies?.map((e) => e.toJson()).toList());
  writeNotNull('job_preferences', instance.jobPreferences?.toJson());
  writeNotNull(
      'iti_details', instance.itiDetails?.map((e) => e.toJson()).toList());
  writeNotNull('skills', instance.skills?.map((e) => e.toJson()).toList());
  writeNotNull('assessment_score', instance.assessmentScore);
  writeNotNull('reviews', instance.reviews?.map((e) => e.toJson()).toList());
  writeNotNull('call_metadata_history', instance.callMetadataHistory);
  writeNotNull('current_profile', instance.currentProfile);
  return val;
}

// SeekerProfileAPIUpdateRequestModel
SeekerProfileAPIUpdateRequestModel _$SeekerProfileAPIUpdateRequestModelFromJson(
        Map<String, dynamic> json) =>
    SeekerProfileAPIUpdateRequestModel(
      personalDetails: json['personal_details'] == null
          ? null
          : PersonalDetailsModel.fromJson(
              json['personal_details'] as Map<String, dynamic>),
      contactDetails: json['contact_details'] == null
          ? null
          : ContactDetailsModel.fromJson(
              json['contact_details'] as Map<String, dynamic>),
      identificationDocs: (json['identification_docs'] as List<dynamic>?)
          ?.map((e) => IdentificationDocModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      bankDetails: (json['bank_details'] as List<dynamic>?)
          ?.map((e) => BankDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      educationDetails: json['education_details'] == null
          ? null
          : EducationDetailsModel.fromJson(
              json['education_details'] as Map<String, dynamic>),
      workExperiences: (json['work_experiences'] as List<dynamic>?)
          ?.map((e) => WorkExperienceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      certifications: (json['certifications'] as List<dynamic>?)
          ?.map((e) => CertificationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      languageProficiencies: (json['language_proficiencies'] as List<dynamic>?)
          ?.map((e) => LanguageProficiencyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      jobPreferences: json['job_preferences'] == null
          ? null
          : JobPreferencesModel.fromJson(
              json['job_preferences'] as Map<String, dynamic>),
      itiDetails: (json['iti_details'] as List<dynamic>?)
          ?.map((e) => ItiDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      skills: (json['skills'] as List<dynamic>?)
          ?.map((e) => SkillModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      assessmentScore: (json['assessment_score'] as num?)?.toDouble(),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      callMetadataHistory: (json['call_metadata_history'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      currentProfile: json['current_profile'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$SeekerProfileAPIUpdateRequestModelToJson(
    SeekerProfileAPIUpdateRequestModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('personal_details', instance.personalDetails?.toJson());
  writeNotNull('contact_details', instance.contactDetails?.toJson());
  writeNotNull('identification_docs',
      instance.identificationDocs?.map((e) => e.toJson()).toList());
  writeNotNull('bank_details',
      instance.bankDetails?.map((e) => e.toJson()).toList());
  writeNotNull('education_details', instance.educationDetails?.toJson());
  writeNotNull('work_experiences',
      instance.workExperiences?.map((e) => e.toJson()).toList());
  writeNotNull('certifications',
      instance.certifications?.map((e) => e.toJson()).toList());
  writeNotNull('language_proficiencies',
      instance.languageProficiencies?.map((e) => e.toJson()).toList());
  writeNotNull('job_preferences', instance.jobPreferences?.toJson());
  writeNotNull(
      'iti_details', instance.itiDetails?.map((e) => e.toJson()).toList());
  writeNotNull('skills', instance.skills?.map((e) => e.toJson()).toList());
  writeNotNull('assessment_score', instance.assessmentScore);
  writeNotNull('reviews', instance.reviews?.map((e) => e.toJson()).toList());
  writeNotNull('call_metadata_history', instance.callMetadataHistory);
  writeNotNull('current_profile', instance.currentProfile);
  return val;
}

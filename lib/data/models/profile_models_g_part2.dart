// File will be combined into profile_models.g.dart
// This is part 2 of the serialization code

// Education Detail Model
EducationDetailModel _$EducationDetailModelFromJson(
        Map<String, dynamic> json) =>
    EducationDetailModel(
      instituteName: json['institute_name'] as String?,
      fieldOfStudy: json['field_of_study'] as String?,
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
      yearOfPassing: json['year_of_passing'] as int?,
      gradePercentageCgpa: (json['grade_percentage_cgpa'] as num?)?.toDouble(),
      isCurrent: json['is_current'] as bool?,
      marksheetUrl: (json['marksheet_url'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      certificateUrl: (json['certificate_url'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      verificationStatus: _$enumDecodeNullable(
          _$VerificationStatusEnumMap, json['verification_status']),
    );

Map<String, dynamic> _$EducationDetailModelToJson(
    EducationDetailModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('institute_name', instance.instituteName);
  writeNotNull('field_of_study', instance.fieldOfStudy);
  writeNotNull('start_date', instance.startDate?.toIso8601String());
  writeNotNull('end_date', instance.endDate?.toIso8601String());
  writeNotNull('year_of_passing', instance.yearOfPassing);
  writeNotNull('grade_percentage_cgpa', instance.gradePercentageCgpa);
  writeNotNull('is_current', instance.isCurrent);
  writeNotNull('marksheet_url', instance.marksheetUrl);
  writeNotNull('certificate_url', instance.certificateUrl);
  writeNotNull('verification_status',
      _$VerificationStatusEnumMap[instance.verificationStatus]);
  return val;
}

// Education Details Model
EducationDetailsModel _$EducationDetailsModelFromJson(
        Map<String, dynamic> json) =>
    EducationDetailsModel(
      highestLevel: json['highest_level'] as String?,
      educationDetails: (json['education_details'] as List<dynamic>?)
          ?.map((e) => EducationDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EducationDetailsModelToJson(
    EducationDetailsModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('highest_level', instance.highestLevel);
  writeNotNull('education_details',
      instance.educationDetails?.map((e) => e.toJson()).toList());
  return val;
}

// Work Experience Model
WorkExperienceModel _$WorkExperienceModelFromJson(Map<String, dynamic> json) =>
    WorkExperienceModel(
      companyName: json['company_name'] as String?,
      designation: json['designation'] as String?,
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
      isCurrent: json['is_current'] as bool?,
      description: json['description'] as String?,
      experienceLetterUrl: (json['experience_letter_url'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      payslipUrls: (json['payslip_urls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$WorkExperienceModelToJson(WorkExperienceModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('company_name', instance.companyName);
  writeNotNull('designation', instance.designation);
  writeNotNull('start_date', instance.startDate?.toIso8601String());
  writeNotNull('end_date', instance.endDate?.toIso8601String());
  writeNotNull('is_current', instance.isCurrent);
  writeNotNull('description', instance.description);
  writeNotNull('experience_letter_url', instance.experienceLetterUrl);
  writeNotNull('payslip_urls', instance.payslipUrls);
  return val;
}

// Skill Model
SkillModel _$SkillModelFromJson(Map<String, dynamic> json) => SkillModel(
      name: json['name'] as String?,
      proficiencyLevel: json['proficiency_level'] as String?,
      experience: json['experience'] as String?,
    );

Map<String, dynamic> _$SkillModelToJson(SkillModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('proficiency_level', instance.proficiencyLevel);
  writeNotNull('experience', instance.experience);
  return val;
}

// Certification Model
CertificationModel _$CertificationModelFromJson(Map<String, dynamic> json) =>
    CertificationModel(
      name: json['name'] as String,
      issuingOrganization: json['issuing_organization'] as String?,
      issueDate: json['issue_date'] == null
          ? null
          : DateTime.parse(json['issue_date'] as String),
      expiryDate: json['expiry_date'] == null
          ? null
          : DateTime.parse(json['expiry_date'] as String),
      credentialId: json['credential_id'] as String?,
      credentialUrl: json['credential_url'] as String?,
      certificateUrl: json['certificate_url'] as String?,
      verificationStatus: _$enumDecodeNullable(
          _$VerificationStatusEnumMap, json['verification_status']),
    );

Map<String, dynamic> _$CertificationModelToJson(CertificationModel instance) {
  final val = <String, dynamic>{
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('issuing_organization', instance.issuingOrganization);
  writeNotNull('issue_date', instance.issueDate?.toIso8601String());
  writeNotNull('expiry_date', instance.expiryDate?.toIso8601String());
  writeNotNull('credential_id', instance.credentialId);
  writeNotNull('credential_url', instance.credentialUrl);
  writeNotNull('certificate_url', instance.certificateUrl);
  writeNotNull('verification_status',
      _$VerificationStatusEnumMap[instance.verificationStatus]);
  return val;
}

// Language Proficiency Model
LanguageProficiencyModel _$LanguageProficiencyModelFromJson(
        Map<String, dynamic> json) =>
    LanguageProficiencyModel(
      language: json['language'] as String,
      spoken: _$enumDecodeNullable(_$ProficiencyLevelEnumMap, json['spoken']),
      written: _$enumDecodeNullable(_$ProficiencyLevelEnumMap, json['written']),
      reading: _$enumDecodeNullable(_$ProficiencyLevelEnumMap, json['reading']),
    );

Map<String, dynamic> _$LanguageProficiencyModelToJson(
    LanguageProficiencyModel instance) {
  final val = <String, dynamic>{
    'language': instance.language,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('spoken', _$ProficiencyLevelEnumMap[instance.spoken]);
  writeNotNull('written', _$ProficiencyLevelEnumMap[instance.written]);
  writeNotNull('reading', _$ProficiencyLevelEnumMap[instance.reading]);
  return val;
}

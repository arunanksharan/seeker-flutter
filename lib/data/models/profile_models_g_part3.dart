// File will be combined into profile_models.g.dart
// This is part 3 of the serialization code

// ITI Detail Model
ItiDetailModel _$ItiDetailModelFromJson(Map<String, dynamic> json) =>
    ItiDetailModel(
      instituteName: json['institute_name'] as String?,
      trade: json['trade'] as String?,
      trainingDuration: json['training_duration'] as String?,
      passingYear: json['passing_year'] as int?,
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
      isCurrent: json['is_current'] as bool?,
      certificateUrls: (json['certificate_urls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      grade: json['grade'] as String?,
      rollNumber: json['roll_number'] as String?,
      certificateNumber: json['certificate_number'] as String?,
      verificationStatus: _$enumDecodeNullable(
          _$VerificationStatusEnumMap, json['verification_status']),
    );

Map<String, dynamic> _$ItiDetailModelToJson(ItiDetailModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('institute_name', instance.instituteName);
  writeNotNull('trade', instance.trade);
  writeNotNull('training_duration', instance.trainingDuration);
  writeNotNull('passing_year', instance.passingYear);
  writeNotNull('start_date', instance.startDate?.toIso8601String());
  writeNotNull('end_date', instance.endDate?.toIso8601String());
  writeNotNull('is_current', instance.isCurrent);
  writeNotNull('certificate_urls', instance.certificateUrls);
  writeNotNull('grade', instance.grade);
  writeNotNull('roll_number', instance.rollNumber);
  writeNotNull('certificate_number', instance.certificateNumber);
  writeNotNull('verification_status',
      _$VerificationStatusEnumMap[instance.verificationStatus]);
  return val;
}

// Identification Doc Model
IdentificationDocModel _$IdentificationDocModelFromJson(
        Map<String, dynamic> json) =>
    IdentificationDocModel(
      docType: json['doc_type'] as String?,
      docNumber: json['doc_number'] as String?,
      name: json['name'] as String?,
      urls:
          (json['urls'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$IdentificationDocModelToJson(
    IdentificationDocModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('doc_type', instance.docType);
  writeNotNull('doc_number', instance.docNumber);
  writeNotNull('name', instance.name);
  writeNotNull('urls', instance.urls);
  return val;
}

// Bank Detail Model
BankDetailModel _$BankDetailModelFromJson(Map<String, dynamic> json) =>
    BankDetailModel(
      accountNumber: json['account_number'] as String?,
      ifscCode: json['ifsc_code'] as String?,
      bankName: json['bank_name'] as String?,
      branchName: json['branch_name'] as String?,
      accountHolderName: json['account_holder_name'] as String?,
    );

Map<String, dynamic> _$BankDetailModelToJson(BankDetailModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('account_number', instance.accountNumber);
  writeNotNull('ifsc_code', instance.ifscCode);
  writeNotNull('bank_name', instance.bankName);
  writeNotNull('branch_name', instance.branchName);
  writeNotNull('account_holder_name', instance.accountHolderName);
  return val;
}

// Job Preferences Model
JobPreferencesModel _$JobPreferencesModelFromJson(Map<String, dynamic> json) =>
    JobPreferencesModel(
      jobTypes: (json['job_types'] as List<dynamic>?)
          ?.map((e) => _$enumDecode(_$JobTypeEnumMap, e))
          .toList(),
      workLocationTypes: (json['work_location_types'] as List<dynamic>?)
          ?.map((e) => _$enumDecode(_$WorkLocationTypeEnumMap, e))
          .toList(),
      jobRoles: (json['job_roles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      industries: (json['industries'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      minSalaryExpectation: json['min_salary_expectation'] as String?,
      maxSalaryExpectation: json['max_salary_expectation'] as String?,
      noticePeriodDays: json['notice_period_days'] as int?,
      isWillingToRelocate: json['is_willing_to_relocate'] as bool?,
      isActivelyLooking: json['is_actively_looking'] as bool?,
      preferredJobLocations: json['preferred_job_locations'] as String?,
      currentLocation: json['current_location'] as String?,
      totalExperienceYears: json['total_experience_years'] as String?,
      currentMonthlySalary: json['current_monthly_salary'] as String?,
    );

Map<String, dynamic> _$JobPreferencesModelToJson(JobPreferencesModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('job_types',
      instance.jobTypes?.map((e) => _$JobTypeEnumMap[e]).toList());
  writeNotNull(
      'work_location_types',
      instance.workLocationTypes
          ?.map((e) => _$WorkLocationTypeEnumMap[e])
          .toList());
  writeNotNull('job_roles', instance.jobRoles);
  writeNotNull('industries', instance.industries);
  writeNotNull('min_salary_expectation', instance.minSalaryExpectation);
  writeNotNull('max_salary_expectation', instance.maxSalaryExpectation);
  writeNotNull('notice_period_days', instance.noticePeriodDays);
  writeNotNull('is_willing_to_relocate', instance.isWillingToRelocate);
  writeNotNull('is_actively_looking', instance.isActivelyLooking);
  writeNotNull('preferred_job_locations', instance.preferredJobLocations);
  writeNotNull('current_location', instance.currentLocation);
  writeNotNull('total_experience_years', instance.totalExperienceYears);
  writeNotNull('current_monthly_salary', instance.currentMonthlySalary);
  return val;
}

// Review Model
ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
      reviewerName: json['reviewer_name'] as String,
      reviewerDesignation: json['reviewer_designation'] as String?,
      reviewerCompany: json['reviewer_company'] as String?,
      rating: (json['rating'] as num).toDouble(),
      comments: json['comments'] as String?,
      reviewDate: json['review_date'] == null
          ? null
          : DateTime.parse(json['review_date'] as String),
    );

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) {
  final val = <String, dynamic>{
    'reviewer_name': instance.reviewerName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('reviewer_designation', instance.reviewerDesignation);
  writeNotNull('reviewer_company', instance.reviewerCompany);
  val['rating'] = instance.rating;
  writeNotNull('comments', instance.comments);
  writeNotNull('review_date', instance.reviewDate?.toIso8601String());
  return val;
}

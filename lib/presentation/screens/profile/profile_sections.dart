import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seeker_flutter/data/blocs/profile/profile_bloc.dart';
import 'package:seeker_flutter/data/blocs/profile/profile_event.dart';
import 'package:seeker_flutter/data/models/profile_models.dart';
import 'package:seeker_flutter/theme/colors.dart';
import 'package:seeker_flutter/theme/spacing.dart';
import 'package:seeker_flutter/theme/typography.dart';
import 'package:intl/intl.dart';

/// Personal Details Section
class _PersonalDetailsSection extends StatelessWidget {
  final PersonalDetailsModel? personalDetails;
  final bool isEditing;

  const _PersonalDetailsSection({
    required this.personalDetails,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: AppSpacing.all3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isEditing)
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.edit, color: AppColors.primary),
                  onPressed: () {
                    // Navigate to personal details edit screen
                  },
                  tooltip: 'Edit Personal Details',
                ),
              ),
            
            // Info items
            _InfoItem(
              label: 'Name',
              value: personalDetails?.name ?? 'Not specified',
              icon: Icons.person,
            ),
            _InfoItem(
              label: 'Father\'s Name',
              value: personalDetails?.fatherName ?? 'Not specified',
              icon: Icons.person_outline,
            ),
            _InfoItem(
              label: 'Mother\'s Name',
              value: personalDetails?.motherName ?? 'Not specified',
              icon: Icons.person_outline,
            ),
            _InfoItem(
              label: 'Gender',
              value: personalDetails?.gender ?? 'Not specified',
              icon: Icons.wc,
            ),
            _InfoItem(
              label: 'Date of Birth',
              value: personalDetails?.dob != null
                  ? DateFormat('dd MMM, yyyy').format(personalDetails!.dob!)
                  : 'Not specified',
              icon: Icons.cake,
            ),
            _InfoItem(
              label: 'Guardian\'s Name',
              value: personalDetails?.guardianName ?? 'Not specified',
              icon: Icons.family_restroom,
            ),
          ],
        ),
      ),
    );
  }
}

/// Contact Details Section
class _ContactDetailsSection extends StatelessWidget {
  final ContactDetailsModel? contactDetails;
  final bool isEditing;

  const _ContactDetailsSection({
    required this.contactDetails,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: AppSpacing.all3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isEditing)
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.edit, color: AppColors.primary),
                  onPressed: () {
                    // Navigate to contact details edit screen
                  },
                  tooltip: 'Edit Contact Details',
                ),
              ),
            
            // Info items
            _InfoItem(
              label: 'Primary Mobile',
              value: contactDetails?.primaryMobile ?? 'Not specified',
              icon: Icons.phone,
            ),
            _InfoItem(
              label: 'Secondary Mobile',
              value: contactDetails?.secondaryMobile ?? 'Not specified',
              icon: Icons.phone_iphone,
            ),
            _InfoItem(
              label: 'Email',
              value: contactDetails?.email ?? 'Not specified',
              icon: Icons.email,
            ),
            
            // Permanent Address
            const SizedBox(height: 16),
            Text(
              'Permanent Address',
              style: AppTypography.subtitle1.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _AddressItem(address: contactDetails?.permanentAddress),
            
            // Current Address
            const SizedBox(height: 16),
            Text(
              'Current Address',
              style: AppTypography.subtitle1.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _AddressItem(address: contactDetails?.currentAddress),
          ],
        ),
      ),
    );
  }
}

/// Education Section
class _EducationSection extends StatelessWidget {
  final EducationDetailsModel? educationDetails;
  final List<ItiDetailModel>? itiDetails;
  final bool isEditing;

  const _EducationSection({
    required this.educationDetails,
    required this.itiDetails,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: AppSpacing.all3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isEditing)
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.edit, color: AppColors.primary),
                  onPressed: () {
                    // Navigate to education details edit screen
                  },
                  tooltip: 'Edit Education Details',
                ),
              ),
            
            // Highest Education Level
            _InfoItem(
              label: 'Highest Education Level',
              value: educationDetails?.highestLevel ?? 'Not specified',
              icon: Icons.school,
            ),
            
            // Education Details
            if (educationDetails?.educationDetails?.isNotEmpty ?? false) ...[
              const SizedBox(height: 16),
              Text(
                'Education History',
                style: AppTypography.subtitle1.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ...educationDetails!.educationDetails!.map((education) => 
                _EducationItem(education: education)
              ).toList(),
            ],
            
            // ITI Details
            if (itiDetails?.isNotEmpty ?? false) ...[
              const SizedBox(height: 16),
              Text(
                'ITI Details',
                style: AppTypography.subtitle1.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ...itiDetails!.map((iti) => 
                _ItiEducationItem(iti: iti)
              ).toList(),
            ],
            
            // If no education details
            if ((educationDetails?.educationDetails?.isEmpty ?? true) && 
                (itiDetails?.isEmpty ?? true))
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'No education details added',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Work Experience Section
class _WorkExperienceSection extends StatelessWidget {
  final List<WorkExperienceModel>? workExperiences;
  final bool isEditing;

  const _WorkExperienceSection({
    required this.workExperiences,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: AppSpacing.all3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isEditing)
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.edit, color: AppColors.primary),
                  onPressed: () {
                    // Navigate to work experience edit screen
                  },
                  tooltip: 'Edit Work Experience',
                ),
              ),
            
            if (workExperiences?.isNotEmpty ?? false)
              ...workExperiences!.map((experience) => 
                _WorkExperienceItem(experience: experience)
              ).toList()
            else
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'No work experience added',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Skills Section
class _SkillsSection extends StatelessWidget {
  final List<SkillModel>? skills;
  final bool isEditing;

  const _SkillsSection({
    required this.skills,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: AppSpacing.all3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isEditing)
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.edit, color: AppColors.primary),
                  onPressed: () {
                    // Navigate to skills edit screen
                  },
                  tooltip: 'Edit Skills',
                ),
              ),
            
            if (skills?.isNotEmpty ?? false)
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: skills!.map((skill) => 
                  Chip(
                    label: Text(skill.name ?? ''),
                    backgroundColor: AppColors.backgroundLight,
                    labelStyle: TextStyle(
                      color: AppColors.textPrimary,
                    ),
                  )
                ).toList(),
              )
            else
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'No skills added',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Languages Section
class _LanguagesSection extends StatelessWidget {
  final List<LanguageProficiencyModel>? languageProficiencies;
  final bool isEditing;

  const _LanguagesSection({
    required this.languageProficiencies,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: AppSpacing.all3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isEditing)
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.edit, color: AppColors.primary),
                  onPressed: () {
                    // Navigate to language proficiency edit screen
                  },
                  tooltip: 'Edit Languages',
                ),
              ),
            
            if (languageProficiencies?.isNotEmpty ?? false)
              ...languageProficiencies!.map((language) => 
                _LanguageItem(language: language)
              ).toList()
            else
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'No languages added',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Certifications Section
class _CertificationsSection extends StatelessWidget {
  final List<CertificationModel>? certifications;
  final bool isEditing;

  const _CertificationsSection({
    required this.certifications,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: AppSpacing.all3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isEditing)
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.edit, color: AppColors.primary),
                  onPressed: () {
                    // Navigate to certifications edit screen
                  },
                  tooltip: 'Edit Certifications',
                ),
              ),
            
            if (certifications?.isNotEmpty ?? false)
              ...certifications!.map((certification) => 
                _CertificationItem(certification: certification)
              ).toList()
            else
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'No certifications added',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Job Preferences Section
class _JobPreferencesSection extends StatelessWidget {
  final JobPreferencesModel? jobPreferences;
  final bool isEditing;

  const _JobPreferencesSection({
    required this.jobPreferences,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: AppSpacing.all3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isEditing)
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.edit, color: AppColors.primary),
                  onPressed: () {
                    // Navigate to job preferences edit screen
                  },
                  tooltip: 'Edit Job Preferences',
                ),
              ),
            
            // Job Roles
            if (jobPreferences?.jobRoles?.isNotEmpty ?? false) ...[
              _InfoItem(
                label: 'Job Roles',
                value: jobPreferences!.jobRoles!.join(', '),
                icon: Icons.work,
              ),
            ],
            
            // Job Types
            if (jobPreferences?.jobTypes?.isNotEmpty ?? false) ...[
              _InfoItem(
                label: 'Job Types',
                value: jobPreferences!.jobTypes!
                    .map((type) => type.toString().split('.').last)
                    .join(', '),
                icon: Icons.category,
              ),
            ],
            
            // Work Location Types
            if (jobPreferences?.workLocationTypes?.isNotEmpty ?? false) ...[
              _InfoItem(
                label: 'Work Location Types',
                value: jobPreferences!.workLocationTypes!
                    .map((type) => type.toString().split('.').last)
                    .join(', '),
                icon: Icons.location_on,
              ),
            ],
            
            // Industries
            if (jobPreferences?.industries?.isNotEmpty ?? false) ...[
              _InfoItem(
                label: 'Industries',
                value: jobPreferences!.industries!.join(', '),
                icon: Icons.business,
              ),
            ],
            
            // Salary Expectation
            if (jobPreferences?.minSalaryExpectation != null ||
                jobPreferences?.maxSalaryExpectation != null) {
              _InfoItem(
                label: 'Salary Expectation',
                value: '${jobPreferences?.minSalaryExpectation ?? ''} - ${jobPreferences?.maxSalaryExpectation ?? ''}',
                icon: Icons.money,
              ),
            },
            
            // Notice Period
            if (jobPreferences?.noticePeriodDays != null) {
              _InfoItem(
                label: 'Notice Period',
                value: '${jobPreferences?.noticePeriodDays} days',
                icon: Icons.timelapse,
              ),
            },
            
            // Other preferences
            _InfoItem(
              label: 'Willing to Relocate',
              value: jobPreferences?.isWillingToRelocate == true ? 'Yes' : 'No',
              icon: Icons.location_city,
            ),
            
            _InfoItem(
              label: 'Actively Looking',
              value: jobPreferences?.isActivelyLooking == true ? 'Yes' : 'No',
              icon: Icons.search,
            ),
            
            _InfoItem(
              label: 'Current Location',
              value: jobPreferences?.currentLocation ?? 'Not specified',
              icon: Icons.place,
            ),
            
            _InfoItem(
              label: 'Preferred Locations',
              value: jobPreferences?.preferredJobLocations ?? 'Not specified',
              icon: Icons.favorite_border,
            ),
            
            _InfoItem(
              label: 'Total Experience',
              value: jobPreferences?.totalExperienceYears ?? 'Not specified',
              icon: Icons.timer,
            ),
            
            _InfoItem(
              label: 'Current Monthly Salary',
              value: jobPreferences?.currentMonthlySalary ?? 'Not specified',
              icon: Icons.account_balance_wallet,
            ),
          ],
        ),
      ),
    );
  }
}

/// Documents Section
class _DocumentsSection extends StatelessWidget {
  final List<IdentificationDocModel>? identificationDocs;
  final bool isEditing;

  const _DocumentsSection({
    required this.identificationDocs,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: AppSpacing.all3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isEditing)
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.edit, color: AppColors.primary),
                  onPressed: () {
                    // Navigate to documents edit screen
                  },
                  tooltip: 'Edit Documents',
                ),
              ),
            
            if (identificationDocs?.isNotEmpty ?? false)
              ...identificationDocs!.map((doc) => 
                _DocumentItem(document: doc)
              ).toList()
            else
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'No documents added',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

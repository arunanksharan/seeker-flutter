import 'package:flutter/material.dart';
import 'package:seeker_flutter/data/models/profile_models.dart';
import 'package:seeker_flutter/theme/colors.dart';
import 'package:seeker_flutter/theme/spacing.dart';
import 'package:seeker_flutter/theme/typography.dart';
import 'package:intl/intl.dart';

/// Basic information item with label, value, and icon
class _InfoItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _InfoItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: AppColors.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  value,
                  style: AppTypography.body1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Address item for displaying address details
class _AddressItem extends StatelessWidget {
  final AddressModel? address;

  const _AddressItem({
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    if (address == null) {
      return const Text(
        'Address not specified',
        style: TextStyle(
          fontStyle: FontStyle.italic,
          color: AppColors.textSecondary,
        ),
      );
    }

    // Build address parts
    List<String> addressParts = [];
    if (address!.street != null && address!.street!.isNotEmpty) {
      addressParts.add(address!.street!);
    }
    if (address!.city != null && address!.city!.isNotEmpty) {
      addressParts.add(address!.city!);
    }
    if (address!.state != null && address!.state!.isNotEmpty) {
      addressParts.add(address!.state!);
    }
    if (address!.postalCode != null && address!.postalCode!.isNotEmpty) {
      addressParts.add(address!.postalCode!);
    }
    if (address!.country != null && address!.country!.isNotEmpty) {
      addressParts.add(address!.country!);
    }

    if (addressParts.isEmpty) {
      return const Text(
        'Address not specified',
        style: TextStyle(
          fontStyle: FontStyle.italic,
          color: AppColors.textSecondary,
        ),
      );
    }

    return Text(
      addressParts.join(', '),
      style: AppTypography.body1,
    );
  }
}

/// Education item for displaying education details
class _EducationItem extends StatelessWidget {
  final EducationDetailModel education;

  const _EducationItem({
    required this.education,
  });

  @override
  Widget build(BuildContext context) {
    // Date range
    String dateRange = '';
    if (education.startDate != null && education.endDate != null) {
      final startYear = DateFormat('yyyy').format(education.startDate!);
      final endYear = education.isCurrent == true
          ? 'Present'
          : DateFormat('yyyy').format(education.endDate!);
      dateRange = '$startYear - $endYear';
    } else if (education.yearOfPassing != null) {
      dateRange = 'Passed in ${education.yearOfPassing}';
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: AppColors.backgroundLight,
      elevation: 0,
      child: Padding(
        padding: AppSpacing.all2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    education.instituteName ?? 'Unknown Institution',
                    style: AppTypography.subtitle1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (dateRange.isNotEmpty)
                  Text(
                    dateRange,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
              ],
            ),
            if (education.fieldOfStudy != null && education.fieldOfStudy!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  education.fieldOfStudy!,
                  style: AppTypography.body2,
                ),
              ),
            if (education.gradePercentageCgpa != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'Grade: ${education.gradePercentageCgpa}',
                  style: AppTypography.body2.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            if (education.verificationStatus != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Icon(
                      _getVerificationIcon(education.verificationStatus!),
                      size: 16,
                      color: _getVerificationColor(education.verificationStatus!),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _getVerificationText(education.verificationStatus!),
                      style: AppTypography.caption.copyWith(
                        color: _getVerificationColor(education.verificationStatus!),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  IconData _getVerificationIcon(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.verified:
        return Icons.verified;
      case VerificationStatus.pending:
        return Icons.pending;
      case VerificationStatus.rejected:
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }

  Color _getVerificationColor(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.verified:
        return Colors.green;
      case VerificationStatus.pending:
        return Colors.orange;
      case VerificationStatus.rejected:
        return Colors.red;
      default:
        return AppColors.textSecondary;
    }
  }

  String _getVerificationText(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.verified:
        return 'Verified';
      case VerificationStatus.pending:
        return 'Verification Pending';
      case VerificationStatus.rejected:
        return 'Verification Rejected';
      default:
        return 'Not Verified';
    }
  }
}

/// ITI Education item for displaying ITI details
class _ItiEducationItem extends StatelessWidget {
  final ItiDetailModel iti;

  const _ItiEducationItem({
    required this.iti,
  });

  @override
  Widget build(BuildContext context) {
    // Date range
    String dateRange = '';
    if (iti.startDate != null && iti.endDate != null) {
      final startYear = DateFormat('yyyy').format(iti.startDate!);
      final endYear = iti.isCurrent == true
          ? 'Present'
          : DateFormat('yyyy').format(iti.endDate!);
      dateRange = '$startYear - $endYear';
    } else if (iti.passingYear != null) {
      dateRange = 'Passed in ${iti.passingYear}';
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: AppColors.backgroundLight,
      elevation: 0,
      child: Padding(
        padding: AppSpacing.all2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    iti.instituteName ?? 'Unknown ITI Institution',
                    style: AppTypography.subtitle1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (dateRange.isNotEmpty)
                  Text(
                    dateRange,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
              ],
            ),
            if (iti.trade != null && iti.trade!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'Trade: ${iti.trade}',
                  style: AppTypography.body2,
                ),
              ),
            if (iti.trainingDuration != null && iti.trainingDuration!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'Duration: ${iti.trainingDuration}',
                  style: AppTypography.body2.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            if (iti.grade != null && iti.grade!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'Grade: ${iti.grade}',
                  style: AppTypography.body2.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            if (iti.verificationStatus != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Icon(
                      _getVerificationIcon(iti.verificationStatus!),
                      size: 16,
                      color: _getVerificationColor(iti.verificationStatus!),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _getVerificationText(iti.verificationStatus!),
                      style: AppTypography.caption.copyWith(
                        color: _getVerificationColor(iti.verificationStatus!),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  IconData _getVerificationIcon(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.verified:
        return Icons.verified;
      case VerificationStatus.pending:
        return Icons.pending;
      case VerificationStatus.rejected:
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }

  Color _getVerificationColor(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.verified:
        return Colors.green;
      case VerificationStatus.pending:
        return Colors.orange;
      case VerificationStatus.rejected:
        return Colors.red;
      default:
        return AppColors.textSecondary;
    }
  }

  String _getVerificationText(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.verified:
        return 'Verified';
      case VerificationStatus.pending:
        return 'Verification Pending';
      case VerificationStatus.rejected:
        return 'Verification Rejected';
      default:
        return 'Not Verified';
    }
  }
}

/// Work Experience item
class _WorkExperienceItem extends StatelessWidget {
  final WorkExperienceModel experience;

  const _WorkExperienceItem({
    required this.experience,
  });

  @override
  Widget build(BuildContext context) {
    // Date range
    String dateRange = '';
    if (experience.startDate != null) {
      final startDate = DateFormat('MMM yyyy').format(experience.startDate!);
      final endDate = experience.isCurrent == true
          ? 'Present'
          : experience.endDate != null
              ? DateFormat('MMM yyyy').format(experience.endDate!)
              : 'Unknown';
      dateRange = '$startDate - $endDate';
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: AppColors.backgroundLight,
      elevation: 0,
      child: Padding(
        padding: AppSpacing.all2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    experience.companyName ?? 'Unknown Company',
                    style: AppTypography.subtitle1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (dateRange.isNotEmpty)
                  Text(
                    dateRange,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
              ],
            ),
            if (experience.designation != null && experience.designation!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  experience.designation!,
                  style: AppTypography.body2,
                ),
              ),
            if (experience.description != null && experience.description!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  experience.description!,
                  style: AppTypography.body2.copyWith(
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

/// Language Proficiency item
class _LanguageItem extends StatelessWidget {
  final LanguageProficiencyModel language;

  const _LanguageItem({
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: AppColors.backgroundLight,
      elevation: 0,
      child: Padding(
        padding: AppSpacing.all2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              language.language,
              style: AppTypography.subtitle1.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                if (language.spoken != null) ...[
                  _ProficiencyBadge(
                    label: 'Speaking',
                    level: language.spoken!,
                  ),
                  const SizedBox(width: 8),
                ],
                if (language.written != null) ...[
                  _ProficiencyBadge(
                    label: 'Writing',
                    level: language.written!,
                  ),
                  const SizedBox(width: 8),
                ],
                if (language.reading != null)
                  _ProficiencyBadge(
                    label: 'Reading',
                    level: language.reading!,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Proficiency level badge
class _ProficiencyBadge extends StatelessWidget {
  final String label;
  final ProficiencyLevel level;

  const _ProficiencyBadge({
    required this.label,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    // Get color based on proficiency level
    Color color;
    switch (level) {
      case ProficiencyLevel.beginner:
        color = Colors.blue.shade200;
        break;
      case ProficiencyLevel.intermediate:
        color = Colors.blue.shade400;
        break;
      case ProficiencyLevel.advanced:
        color = Colors.blue.shade600;
        break;
      case ProficiencyLevel.native:
        color = Colors.blue.shade800;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color, width: 1),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            _getProficiencyLevelText(level),
            style: AppTypography.caption.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  String _getProficiencyLevelText(ProficiencyLevel level) {
    switch (level) {
      case ProficiencyLevel.beginner:
        return 'Beginner';
      case ProficiencyLevel.intermediate:
        return 'Intermediate';
      case ProficiencyLevel.advanced:
        return 'Advanced';
      case ProficiencyLevel.native:
        return 'Native';
    }
  }
}

/// Certification item
class _CertificationItem extends StatelessWidget {
  final CertificationModel certification;

  const _CertificationItem({
    required this.certification,
  });

  @override
  Widget build(BuildContext context) {
    // Date information
    String dateInfo = '';
    if (certification.issueDate != null) {
      final issueDate = DateFormat('MMM yyyy').format(certification.issueDate!);
      if (certification.expiryDate != null) {
        final expiryDate = DateFormat('MMM yyyy').format(certification.expiryDate!);
        dateInfo = 'Issued: $issueDate · Expires: $expiryDate';
      } else {
        dateInfo = 'Issued: $issueDate';
      }
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: AppColors.backgroundLight,
      elevation: 0,
      child: Padding(
        padding: AppSpacing.all2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              certification.name,
              style: AppTypography.subtitle1.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (certification.issuingOrganization != null && certification.issuingOrganization!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  certification.issuingOrganization!,
                  style: AppTypography.body2,
                ),
              ),
            if (dateInfo.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  dateInfo,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            if (certification.credentialId != null && certification.credentialId!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'Credential ID: ${certification.credentialId}',
                  style: AppTypography.caption,
                ),
              ),
            if (certification.verificationStatus != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Icon(
                      _getVerificationIcon(certification.verificationStatus!),
                      size: 16,
                      color: _getVerificationColor(certification.verificationStatus!),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _getVerificationText(certification.verificationStatus!),
                      style: AppTypography.caption.copyWith(
                        color: _getVerificationColor(certification.verificationStatus!),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  IconData _getVerificationIcon(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.verified:
        return Icons.verified;
      case VerificationStatus.pending:
        return Icons.pending;
      case VerificationStatus.rejected:
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }

  Color _getVerificationColor(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.verified:
        return Colors.green;
      case VerificationStatus.pending:
        return Colors.orange;
      case VerificationStatus.rejected:
        return Colors.red;
      default:
        return AppColors.textSecondary;
    }
  }

  String _getVerificationText(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.verified:
        return 'Verified';
      case VerificationStatus.pending:
        return 'Verification Pending';
      case VerificationStatus.rejected:
        return 'Verification Rejected';
      default:
        return 'Not Verified';
    }
  }
}

/// Document item
class _DocumentItem extends StatelessWidget {
  final IdentificationDocModel document;

  const _DocumentItem({
    required this.document,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: AppColors.backgroundLight,
      elevation: 0,
      child: Padding(
        padding: AppSpacing.all2,
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(
                Icons.description,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    document.docType ?? 'Unknown Document',
                    style: AppTypography.subtitle1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (document.docNumber != null && document.docNumber!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        'Document Number: ${document.docNumber}',
                        style: AppTypography.body2,
                      ),
                    ),
                ],
              ),
            ),
            if (document.urls?.isNotEmpty ?? false)
              IconButton(
                icon: const Icon(
                  Icons.visibility,
                  color: AppColors.primary,
                ),
                onPressed: () {
                  // Open document
                },
                tooltip: 'View Document',
              ),
          ],
        ),
      ),
    );
  }
}

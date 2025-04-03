import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seeker_flutter/data/blocs/profile/profile_bloc.dart';
import 'package:seeker_flutter/data/blocs/profile/profile_event.dart';
import 'package:seeker_flutter/data/blocs/profile/profile_state.dart';
import 'package:seeker_flutter/data/models/profile_models.dart';
import 'package:seeker_flutter/theme/colors.dart';
import 'package:seeker_flutter/theme/spacing.dart';
import 'package:seeker_flutter/theme/typography.dart';
import 'package:seeker_flutter/utils/logger.dart';

/// Profile screen
class ProfileScreen extends StatefulWidget {
  final bool isEditing;

  const ProfileScreen({
    super.key,
    this.isEditing = false,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch profile data when screen is loaded
    context.read<ProfileBloc>().add(const ProfileFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Edit Profile' : 'Profile'),
        actions: [
          if (!widget.isEditing)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => context.go('/profile/edit'),
              tooltip: 'Edit Profile',
            ),
        ],
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProfileLoaded || state is ProfileSectionUpdateSuccess) {
            // Get profile data from state
            final profile = state is ProfileLoaded 
                ? state.profile 
                : (state as ProfileSectionUpdateSuccess).profile;
            
            return _buildProfileContent(context, profile);
          } else if (state is ProfileFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppColors.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to load profile',
                    style: AppTypography.h5,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: AppTypography.body2,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ProfileBloc>().add(const ProfileFetched());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('No profile data found'),
            );
          }
        },
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, SeekerProfileAPIResponseModel profile) {
    return SingleChildScrollView(
      padding: AppSpacing.all3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile header with photo
          _ProfileHeader(profile: profile, isEditing: widget.isEditing),
          const SizedBox(height: 24),
          
          // Personal Details Section
          _SectionTitle(title: 'Personal Details'),
          _PersonalDetailsSection(
            personalDetails: profile.personalDetails,
            isEditing: widget.isEditing,
          ),
          const SizedBox(height: 24),
          
          // Contact Details Section
          _SectionTitle(title: 'Contact Details'),
          _ContactDetailsSection(
            contactDetails: profile.contactDetails,
            isEditing: widget.isEditing,
          ),
          const SizedBox(height: 24),
          
          // Education Section
          _SectionTitle(title: 'Education'),
          _EducationSection(
            educationDetails: profile.educationDetails,
            itiDetails: profile.itiDetails,
            isEditing: widget.isEditing,
          ),
          const SizedBox(height: 24),
          
          // Work Experience Section
          _SectionTitle(title: 'Work Experience'),
          _WorkExperienceSection(
            workExperiences: profile.workExperiences,
            isEditing: widget.isEditing,
          ),
          const SizedBox(height: 24),
          
          // Skills Section
          _SectionTitle(title: 'Skills'),
          _SkillsSection(
            skills: profile.skills,
            isEditing: widget.isEditing,
          ),
          const SizedBox(height: 24),
          
          // Languages Section
          _SectionTitle(title: 'Languages'),
          _LanguagesSection(
            languageProficiencies: profile.languageProficiencies,
            isEditing: widget.isEditing,
          ),
          const SizedBox(height: 24),
          
          // Certifications Section
          _SectionTitle(title: 'Certifications'),
          _CertificationsSection(
            certifications: profile.certifications,
            isEditing: widget.isEditing,
          ),
          const SizedBox(height: 24),
          
          // Job Preferences Section
          _SectionTitle(title: 'Job Preferences'),
          _JobPreferencesSection(
            jobPreferences: profile.jobPreferences,
            isEditing: widget.isEditing,
          ),
          const SizedBox(height: 24),
          
          // Documents Section
          _SectionTitle(title: 'Documents'),
          _DocumentsSection(
            identificationDocs: profile.identificationDocs,
            isEditing: widget.isEditing,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

/// Section title widget
class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            title,
            style: AppTypography.h5.copyWith(
              color: AppColors.primary[700],
            ),
          ),
          Expanded(
            child: Container(
              height: 1,
              margin: const EdgeInsets.only(left: 8),
              color: AppColors.borderLight,
            ),
          ),
        ],
      ),
    );
  }
}

/// Profile header widget with photo
class _ProfileHeader extends StatelessWidget {
  final SeekerProfileAPIResponseModel profile;
  final bool isEditing;

  const _ProfileHeader({
    required this.profile,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // Profile picture
          Stack(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: AppColors.backgroundLight,
                backgroundImage: profile.personalDetails?.profilePictureUrl != null
                    ? NetworkImage(profile.personalDetails!.profilePictureUrl!)
                    : null,
                child: profile.personalDetails?.profilePictureUrl == null
                    ? Icon(
                        Icons.person,
                        size: 60,
                        color: AppColors.textSecondary,
                      )
                    : null,
              ),
              if (isEditing)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.primary,
                    child: IconButton(
                      icon: const Icon(
                        Icons.camera_alt,
                        size: 18,
                        color: AppColors.white,
                      ),
                      onPressed: () {
                        // Handle profile picture update
                      },
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          // Name
          Text(
            profile.personalDetails?.name ?? 'Add Your Name',
            style: AppTypography.h4,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          // Brief detail like current job role or location
          Text(
            profile.jobPreferences?.currentLocation ?? 'Location not specified',
            style: AppTypography.body1.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          if (profile.jobPreferences?.jobRoles?.isNotEmpty ?? false)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                profile.jobPreferences!.jobRoles!.first,
                style: AppTypography.body2.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

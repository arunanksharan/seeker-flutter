import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seeker_flutter/data/blocs/auth/auth_bloc.dart';
import 'package:seeker_flutter/data/blocs/auth/auth_event.dart';
import 'package:seeker_flutter/data/blocs/profile/profile_bloc.dart';
import 'package:seeker_flutter/data/blocs/profile/profile_event.dart';
import 'package:seeker_flutter/data/blocs/profile/profile_state.dart';
import 'package:seeker_flutter/theme/colors.dart';
import 'package:seeker_flutter/theme/spacing.dart';
import 'package:seeker_flutter/theme/typography.dart';
import 'package:seeker_flutter/utils/logger.dart';

/// Home screen of the app
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch profile on initial load if it exists
    context.read<ProfileBloc>().add(const ProfileFetched());
  }

  // Sign out the user
  void _signOut() {
    context.read<AuthBloc>().add(const AuthLogoutRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => context.go('/profile'),
            tooltip: 'Profile',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _signOut,
            tooltip: 'Sign Out',
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
            
            // Display profile summary
            return SingleChildScrollView(
              padding: AppSpacing.all4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome message
                  Text(
                    'Welcome, ${profile.personalDetails?.name ?? 'User'}!',
                    style: AppTypography.h3,
                  ),
                  const SizedBox(height: 24),
                  
                  // Dashboard
                  const _DashboardSection(),
                  const SizedBox(height: 32),
                  
                  // Profile completion status
                  _ProfileCompletionCard(profile: profile),
                  const SizedBox(height: 32),
                  
                  // Recent activities or notifications
                  const _RecentActivitiesSection(),
                ],
              ),
            );
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
            // Default or initial state
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.home,
                    size: 64,
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Welcome to Seeker',
                    style: AppTypography.h4,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your job search companion',
                    style: AppTypography.body1,
                  ),
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Alerts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
        ],
      ),
    );
  }
}

/// Dashboard section widget
class _DashboardSection extends StatelessWidget {
  const _DashboardSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: AppSpacing.all3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard',
              style: AppTypography.h5,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    icon: Icons.visibility,
                    title: 'Profile Views',
                    value: '18',
                    color: Colors.blue,
                  ),
                ),
                Expanded(
                  child: _StatCard(
                    icon: Icons.work,
                    title: 'Job Matches',
                    value: '7',
                    color: Colors.green,
                  ),
                ),
                Expanded(
                  child: _StatCard(
                    icon: Icons.star,
                    title: 'Saved Jobs',
                    value: '3',
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Stat card widget for dashboard
class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: color.withOpacity(0.1),
      child: Padding(
        padding: AppSpacing.all2,
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: AppTypography.h4.copyWith(
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: AppTypography.caption,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Profile completion card widget
class _ProfileCompletionCard extends StatelessWidget {
  final dynamic profile;

  const _ProfileCompletionCard({required this.profile});

  // Calculate profile completion percentage
  double _calculateCompletionPercentage() {
    int completed = 0;
    int total = 9; // Total number of sections

    if (profile.personalDetails != null) completed++;
    if (profile.contactDetails != null) completed++;
    if (profile.educationDetails != null) completed++;
    if (profile.workExperiences != null && profile.workExperiences.isNotEmpty) completed++;
    if (profile.skills != null && profile.skills.isNotEmpty) completed++;
    if (profile.languageProficiencies != null && profile.languageProficiencies.isNotEmpty) completed++;
    if (profile.jobPreferences != null) completed++;
    if (profile.certifications != null && profile.certifications.isNotEmpty) completed++;
    if (profile.identificationDocs != null && profile.identificationDocs.isNotEmpty) completed++;

    return (completed / total) * 100;
  }

  @override
  Widget build(BuildContext context) {
    final completionPercentage = _calculateCompletionPercentage();

    return Card(
      elevation: 2,
      child: Padding(
        padding: AppSpacing.all3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Profile Completion',
                  style: AppTypography.h5,
                ),
                Text(
                  '${completionPercentage.toInt()}%',
                  style: AppTypography.h5.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: completionPercentage / 100,
                minHeight: 8,
                backgroundColor: AppColors.borderLight,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => context.go('/profile/edit'),
              icon: const Icon(Icons.edit),
              label: const Text('Complete Your Profile'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Recent activities section widget
class _RecentActivitiesSection extends StatelessWidget {
  const _RecentActivitiesSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: AppSpacing.all3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Activities',
              style: AppTypography.h5,
            ),
            const SizedBox(height: 16),
            _ActivityItem(
              title: 'New job recommendation',
              description: 'A new job matches your skills',
              icon: Icons.work,
              time: '2h ago',
              color: Colors.green,
            ),
            _ActivityItem(
              title: 'Profile view',
              description: 'ABC Company viewed your profile',
              icon: Icons.visibility,
              time: '1d ago',
              color: Colors.blue,
            ),
            _ActivityItem(
              title: 'Skill assessment',
              description: 'Complete assessment to improve profile',
              icon: Icons.assignment,
              time: '2d ago',
              color: Colors.orange,
            ),
            // See all button
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text('See All Activities'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Activity item widget for recent activities
class _ActivityItem extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final String time;
  final Color color;

  const _ActivityItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.time,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.subtitle1,
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppTypography.body2,
                ),
              ],
            ),
          ),
          Text(
            time,
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

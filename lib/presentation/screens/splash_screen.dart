import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seeker_flutter/data/blocs/auth/auth_bloc.dart';
import 'package:seeker_flutter/data/blocs/auth/auth_event.dart';
import 'package:seeker_flutter/data/blocs/auth/auth_state.dart';
import 'package:seeker_flutter/data/blocs/profile/profile_bloc.dart';
import 'package:seeker_flutter/data/blocs/profile/profile_event.dart';
import 'package:seeker_flutter/theme/app_theme.dart';
import 'package:seeker_flutter/theme/colors.dart';
import 'package:seeker_flutter/utils/logger.dart';

/// Splash screen for the app
/// This is the entry point for the app
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Dispatch events to check auth status and profile existence
    _checkAuthStatus();
  }

  /// Check if user is authenticated
  void _checkAuthStatus() {
    logInfo('Checking authentication status');
    context.read<AuthBloc>().add(const AuthCheckRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary[500],
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            // User is authenticated, check if profile exists
            logInfo('User is authenticated, checking profile existence');
            context.read<ProfileBloc>().add(const ProfileExistenceChecked());
          } else if (state is AuthUnauthenticated) {
            // User is not authenticated, navigate to login
            logInfo('User is not authenticated, navigating to login');
            context.go('/auth/login');
          } else if (state is AuthFailure) {
            // Auth check failed, show error and navigate to login
            logError('Auth check failed: ${state.message}');
            // Show error snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.message}'),
                backgroundColor: AppColors.error,
              ),
            );
            // Navigate to login
            context.go('/auth/login');
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo placeholder
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.search,
                    size: 60,
                    color: AppColors.primary[500],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Seeker',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Find your perfect match',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 48),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

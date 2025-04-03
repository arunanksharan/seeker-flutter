import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seeker_flutter/data/blocs/auth/auth_bloc.dart';
import 'package:seeker_flutter/data/blocs/auth/auth_event.dart';
import 'package:seeker_flutter/data/blocs/auth/auth_state.dart';
import 'package:seeker_flutter/data/models/auth_models.dart';
import 'package:seeker_flutter/theme/colors.dart';
import 'package:seeker_flutter/theme/spacing.dart';
import 'package:seeker_flutter/theme/typography.dart';
import 'package:seeker_flutter/utils/logger.dart';
import 'package:seeker_flutter/presentation/widgets/auth/google_sign_in_button.dart';

/// Registration screen for new users
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _mobileController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // Request OTP for registration
  void _register() {
    if (_formKey.currentState?.validate() ?? false) {
      // Dispatch registration event
      context.read<AuthBloc>().add(
            AuthRegisterRequested(
              RegisterRequestModel(
                mobile: _mobileController.text,
                email: _emailController.text.isNotEmpty
                    ? _emailController.text
                    : null,
              ),
            ),
          );
    }
  }

  // Handle Google sign-in
  void _signInWithGoogle() {
    // In a real implementation, you would integrate with Google Sign-In SDK
    // and get the token from there
    logInfo('Google sign-in button pressed (registration)');
    // After getting the token, you would dispatch:
    // context.read<AuthBloc>().add(
    //       AuthGoogleRequested(
    //         GoogleAuthRequestModel(token: googleToken),
    //       ),
    //     );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          setState(() {
            _isLoading = state is AuthRegistrationInProgress || 
                        state is AuthGoogleInProgress;
          });

          if (state is AuthRegistrationSuccess) {
            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Registration successful! Verify your OTP.'),
                backgroundColor: AppColors.success,
              ),
            );
            
            // Navigate to OTP verification screen
            context.go(
              '/auth/verify-otp?mobile=${_mobileController.text}&type=register',
            );
          } else if (state is AuthAuthenticated) {
            // User authenticated, router will handle redirection
            logInfo('User authenticated via Google, router will redirect');
          } else if (state is AuthFailure) {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.message}'),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: AppSpacing.all4,
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 40),
                      // Header
                      Center(
                        child: Text(
                          'Create Account',
                          style: AppTypography.h3,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: Text(
                          'Register to get started',
                          style: AppTypography.body1,
                        ),
                      ),
                      const SizedBox(height: 48),
                      
                      // Mobile number input
                      TextFormField(
                        controller: _mobileController,
                        decoration: const InputDecoration(
                          labelText: 'Mobile Number',
                          hintText: 'Enter your mobile number',
                          prefixIcon: Icon(Icons.phone_android),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your mobile number';
                          }
                          if (value.length < 10) {
                            return 'Please enter a valid mobile number';
                          }
                          return null;
                        },
                        enabled: !_isLoading,
                      ),
                      const SizedBox(height: 16),
                      
                      // Email input (optional)
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email (Optional)',
                          hintText: 'Enter your email address',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            // Simple email validation
                            bool emailValid = RegExp(
                                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                .hasMatch(value);
                            if (!emailValid) {
                              return 'Please enter a valid email address';
                            }
                          }
                          return null;
                        },
                        enabled: !_isLoading,
                      ),
                      const SizedBox(height: 24),
                      
                      // Register button
                      ElevatedButton(
                        onPressed: _isLoading ? null : _register,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: _isLoading && state is AuthRegistrationInProgress
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.white,
                                ),
                              )
                            : const Text('Register'),
                      ),
                      const SizedBox(height: 16),
                      
                      // Divider with "or" text
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              height: 1,
                              color: AppColors.borderLight,
                            ),
                          ),
                          Text(
                            'or',
                            style: AppTypography.body2.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              height: 1,
                              color: AppColors.borderLight,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      // Google Sign-In button
                      GoogleSignInButton(
                        onPressed: _isLoading ? null : _signInWithGoogle,
                        isLoading: _isLoading && state is AuthGoogleInProgress,
                      ),
                      const SizedBox(height: 24),
                      
                      // Login link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: AppTypography.body2,
                          ),
                          TextButton(
                            onPressed: _isLoading
                                ? null
                                : () => context.go('/auth/login'),
                            child: const Text('Login'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

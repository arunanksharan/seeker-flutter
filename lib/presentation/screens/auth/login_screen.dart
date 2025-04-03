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

/// Login screen
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _mobileController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  // Request OTP for login
  void _requestOtp() {
    if (_formKey.currentState?.validate() ?? false) {
      // Dispatch OTP request event
      context.read<AuthBloc>().add(
            AuthOtpRequested(
              OtpRequestModel(
                mobile: _mobileController.text,
                type: OtpType.login,
              ),
            ),
          );
    }
  }

  // Handle Google sign-in
  void _signInWithGoogle() {
    // In a real implementation, you would integrate with Google Sign-In SDK
    // and get the token from there
    logInfo('Google sign-in button pressed');
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
        title: const Text('Login'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          setState(() {
            _isLoading = state is AuthOtpRequestInProgress || 
                          state is AuthGoogleInProgress;
          });

          if (state is AuthOtpRequestSuccess) {
            // Navigate to OTP verification screen
            context.go(
              '/auth/verify-otp?mobile=${_mobileController.text}&type=login',
            );
          } else if (state is AuthAuthenticated) {
            // User authenticated, router will handle redirection
            logInfo('User authenticated, router will redirect');
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
                      // Logo or app name
                      Center(
                        child: Text(
                          'Seeker',
                          style: AppTypography.h1.copyWith(
                            color: AppColors.primary[500],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: Text(
                          'Login to continue',
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
                      const SizedBox(height: 24),
                      
                      // Login button
                      ElevatedButton(
                        onPressed: _isLoading ? null : _requestOtp,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: _isLoading && state is AuthOtpRequestInProgress
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.white,
                                ),
                              )
                            : const Text('Send OTP'),
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
                      
                      // Register link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: AppTypography.body2,
                          ),
                          TextButton(
                            onPressed: _isLoading
                                ? null
                                : () => context.go('/auth/register'),
                            child: const Text('Register'),
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

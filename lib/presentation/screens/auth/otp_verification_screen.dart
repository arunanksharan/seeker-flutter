import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seeker_flutter/data/blocs/auth/auth_bloc.dart';
import 'package:seeker_flutter/data/blocs/auth/auth_event.dart';
import 'package:seeker_flutter/data/blocs/auth/auth_state.dart';
import 'package:seeker_flutter/data/models/auth_models.dart';
import 'package:seeker_flutter/theme/colors.dart';
import 'package:seeker_flutter/theme/spacing.dart';
import 'package:seeker_flutter/theme/typography.dart';
import 'package:seeker_flutter/utils/logger.dart';

/// OTP verification screen for login and registration
class OtpVerificationScreen extends StatefulWidget {
  final String mobile;
  final String type; // 'login' or 'register'

  const OtpVerificationScreen({
    super.key,
    required this.mobile,
    required this.type,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _otpLength = 6; // Number of OTP digits
  final List<TextEditingController> _otpControllers = [];
  final List<FocusNode> _focusNodes = [];
  bool _isLoading = false;

  // Resend OTP timer
  Timer? _timer;
  int _timerSeconds = 30;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    
    // Initialize controllers and focus nodes
    for (int i = 0; i < _otpLength; i++) {
      _otpControllers.add(TextEditingController());
      _focusNodes.add(FocusNode());
    }
    
    // Start the resend timer
    _startTimer();
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes
    for (int i = 0; i < _otpLength; i++) {
      _otpControllers[i].dispose();
      _focusNodes[i].dispose();
    }
    
    // Cancel timer
    _timer?.cancel();
    
    super.dispose();
  }

  // Start the resend OTP timer
  void _startTimer() {
    setState(() {
      _timerSeconds = 30;
      _canResend = false;
    });
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerSeconds > 0) {
          _timerSeconds--;
        } else {
          _canResend = true;
          _timer?.cancel();
        }
      });
    });
  }

  // Resend OTP
  void _resendOtp() {
    if (!_canResend) return;
    
    // Clear OTP fields
    for (var controller in _otpControllers) {
      controller.clear();
    }
    
    // Request a new OTP
    context.read<AuthBloc>().add(
          AuthOtpRequested(
            OtpRequestModel(
              mobile: widget.mobile,
              type: widget.type == 'login' ? OtpType.login : OtpType.register,
            ),
          ),
        );
    
    // Restart timer
    _startTimer();
  }

  // Verify OTP
  void _verifyOtp() {
    // Combine OTP digits
    String otp = '';
    for (var controller in _otpControllers) {
      otp += controller.text;
    }
    
    // Validate OTP
    if (otp.length != _otpLength) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid OTP'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    
    // Dispatch OTP verification event
    context.read<AuthBloc>().add(
          AuthOtpVerified(
            OtpVerifyModel(
              mobile: widget.mobile,
              otp: otp,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          setState(() {
            _isLoading = state is AuthOtpVerificationInProgress;
          });

          if (state is AuthAuthenticated) {
            // User authenticated, router will handle redirection
            logInfo('OTP verified, user authenticated');
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),
                  
                  // Title and description
                  Text(
                    'Verification Code',
                    style: AppTypography.h4,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'We\'ve sent a verification code to ${widget.mobile}',
                    style: AppTypography.body1,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  
                  // OTP input fields
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _otpLength,
                      (index) => Container(
                        width: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        child: TextField(
                          controller: _otpControllers[index],
                          focusNode: _focusNodes[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: const InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.zero,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          enabled: !_isLoading,
                          onChanged: (value) {
                            // Move to next or previous field based on input
                            if (value.isNotEmpty && index < _otpLength - 1) {
                              _focusNodes[index + 1].requestFocus();
                            } else if (value.isEmpty && index > 0) {
                              _focusNodes[index - 1].requestFocus();
                            }
                            
                            // Auto-verify when all digits are entered
                            if (index == _otpLength - 1 && value.isNotEmpty) {
                              // Check if all fields have a value
                              bool isComplete = _otpControllers
                                  .every((controller) => controller.text.isNotEmpty);
                              
                              if (isComplete) {
                                _verifyOtp();
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // Verify button
                  ElevatedButton(
                    onPressed: _isLoading ? null : _verifyOtp,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.white,
                            ),
                          )
                        : const Text('Verify OTP'),
                  ),
                  const SizedBox(height: 24),
                  
                  // Resend OTP section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Didn\'t receive the code?',
                        style: AppTypography.body2,
                      ),
                      TextButton(
                        onPressed: _canResend && !_isLoading ? _resendOtp : null,
                        child: Text(
                          _canResend
                              ? 'Resend'
                              : 'Resend in $_timerSeconds seconds',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

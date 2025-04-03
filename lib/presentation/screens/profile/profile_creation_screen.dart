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

/// Profile creation screen for new users
class ProfileCreationScreen extends StatefulWidget {
  const ProfileCreationScreen({super.key});

  @override
  State<ProfileCreationScreen> createState() => _ProfileCreationScreenState();
}

class _ProfileCreationScreenState extends State<ProfileCreationScreen> {
  final _formKey = GlobalKey<FormState>();

  // Step management
  int _currentStep = 0;
  final int _totalSteps = 3;

  // Form controllers
  final _nameController = TextEditingController();
  final _fatherNameController = TextEditingController();
  final _genderController = TextEditingController();
  final _dobController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressLineController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _pinCodeController = TextEditingController();
  final _countryController = TextEditingController();
  final _educationLevelController = TextEditingController();
  final _instituteNameController = TextEditingController();
  final _fieldOfStudyController = TextEditingController();

  // Selected date of birth
  DateTime? _selectedDob;

  // Loading state
  bool _isLoading = false;

  @override
  void dispose() {
    // Dispose controllers
    _nameController.dispose();
    _fatherNameController.dispose();
    _genderController.dispose();
    _dobController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _addressLineController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _pinCodeController.dispose();
    _countryController.dispose();
    _educationLevelController.dispose();
    _instituteNameController.dispose();
    _fieldOfStudyController.dispose();
    super.dispose();
  }

  // Handle date of birth selection
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDob ?? DateTime.now().subtract(const Duration(days: 365 * 18)), // Default to 18 years ago
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.white,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null && picked != _selectedDob) {
      setState(() {
        _selectedDob = picked;
        _dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  // Create profile with the form data
  void _createProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      // Build personal details
      final personalDetails = PersonalDetailsModel(
        name: _nameController.text,
        fatherName: _fatherNameController.text.isNotEmpty ? _fatherNameController.text : null,
        gender: _genderController.text,
        dob: _selectedDob,
      );

      // Build contact details
      final contactDetails = ContactDetailsModel(
        primaryMobile: _mobileController.text,
        email: _emailController.text.isNotEmpty ? _emailController.text : null,
        currentAddress: _addressLineController.text.isNotEmpty
            ? AddressModel(
                street: _addressLineController.text,
                city: _cityController.text,
                state: _stateController.text,
                postalCode: _pinCodeController.text,
                country: _countryController.text,
                isCurrent: true,
              )
            : null,
      );

      // Build education details
      final educationDetails = _educationLevelController.text.isNotEmpty
          ? EducationDetailsModel(
              highestLevel: _educationLevelController.text,
              educationDetails: _instituteNameController.text.isNotEmpty
                  ? [
                      EducationDetailModel(
                        instituteName: _instituteNameController.text,
                        fieldOfStudy: _fieldOfStudyController.text.isNotEmpty
                            ? _fieldOfStudyController.text
                            : null,
                      ),
                    ]
                  : null,
            )
          : null;

      // Create profile request
      final profileRequest = SeekerProfileAPICreateRequestModel(
        personalDetails: personalDetails,
        contactDetails: contactDetails,
        educationDetails: educationDetails,
      );

      // Dispatch profile creation event
      context.read<ProfileBloc>().add(ProfileCreated(profileRequest));
    } else {
      // If validation fails, show a message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  // Move to next step
  void _nextStep() {
    // Validate current step
    bool isValid = true;
    
    if (_currentStep == 0) {
      // Validate personal details
      isValid = _nameController.text.isNotEmpty &&
                _genderController.text.isNotEmpty &&
                _selectedDob != null;
    } else if (_currentStep == 1) {
      // Validate contact details
      isValid = _mobileController.text.isNotEmpty;
      
      // Validate email if provided
      if (_emailController.text.isNotEmpty) {
        final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
        isValid = isValid && emailRegex.hasMatch(_emailController.text);
      }
    }
    
    if (isValid) {
      setState(() {
        if (_currentStep < _totalSteps - 1) {
          _currentStep++;
        } else {
          // Submit form if on last step
          _createProfile();
        }
      });
    } else {
      // Show validation error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields correctly'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  // Move to previous step
  void _previousStep() {
    setState(() {
      if (_currentStep > 0) {
        _currentStep--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Profile'),
        leading: _currentStep > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _previousStep,
              )
            : null,
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          setState(() {
            _isLoading = state is ProfileCreationInProgress;
          });

          if (state is ProfileCreationSuccess) {
            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile created successfully!'),
                backgroundColor: AppColors.success,
              ),
            );
            
            // Navigate to home
            context.go('/home');
          } else if (state is ProfileFailure) {
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
          return _isLoading
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Creating your profile...'),
                    ],
                  ),
                )
              : Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Step indicator
                      Padding(
                        padding: AppSpacing.all3,
                        child: Row(
                          children: List.generate(_totalSteps, (index) {
                            return Expanded(
                              child: Container(
                                height: 4,
                                margin: const EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                  color: index <= _currentStep
                                      ? AppColors.primary
                                      : AppColors.borderLight,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      
                      // Step counter text
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Step ${_currentStep + 1}/$_totalSteps',
                              style: AppTypography.body2.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            Text(
                              _getStepTitle(_currentStep),
                              style: AppTypography.body2.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Step content
                      Expanded(
                        child: SingleChildScrollView(
                          padding: AppSpacing.all3,
                          child: _buildStepContent(_currentStep),
                        ),
                      ),
                      
                      // Navigation buttons
                      Padding(
                        padding: AppSpacing.all3,
                        child: Row(
                          children: [
                            if (_currentStep > 0)
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: _previousStep,
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                  child: const Text('Back'),
                                ),
                              ),
                            if (_currentStep > 0)
                              const SizedBox(width: 16),
                            Expanded(
                              flex: 2,
                              child: ElevatedButton(
                                onPressed: _nextStep,
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                                child: Text(
                                  _currentStep < _totalSteps - 1 ? 'Continue' : 'Create Profile',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }

  // Get title for the current step
  String _getStepTitle(int step) {
    switch (step) {
      case 0:
        return 'Personal Details';
      case 1:
        return 'Contact Details';
      case 2:
        return 'Education Details';
      default:
        return '';
    }
  }

  // Build content for the current step
  Widget _buildStepContent(int step) {
    switch (step) {
      case 0:
        return _buildPersonalDetailsStep();
      case 1:
        return _buildContactDetailsStep();
      case 2:
        return _buildEducationDetailsStep();
      default:
        return const SizedBox();
    }
  }

  // Step 1: Personal Details
  Widget _buildPersonalDetailsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Let\'s set up your basic information',
          style: AppTypography.body1,
        ),
        const SizedBox(height: 24),
        
        // Name
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'Full Name*',
            hintText: 'Enter your full name',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        
        // Father's Name
        TextFormField(
          controller: _fatherNameController,
          decoration: const InputDecoration(
            labelText: 'Father\'s Name',
            hintText: 'Enter your father\'s name',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        
        // Gender
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: 'Gender*',
            border: OutlineInputBorder(),
          ),
          hint: const Text('Select your gender'),
          value: _genderController.text.isEmpty ? null : _genderController.text,
          onChanged: (value) {
            if (value != null) {
              _genderController.text = value;
            }
          },
          items: const [
            DropdownMenuItem(
              value: 'Male',
              child: Text('Male'),
            ),
            DropdownMenuItem(
              value: 'Female',
              child: Text('Female'),
            ),
            DropdownMenuItem(
              value: 'Other',
              child: Text('Other'),
            ),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select your gender';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        
        // Date of Birth
        TextFormField(
          controller: _dobController,
          decoration: const InputDecoration(
            labelText: 'Date of Birth*',
            hintText: 'Select your date of birth',
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.calendar_month),
          ),
          readOnly: true,
          onTap: () => _selectDate(context),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select your date of birth';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        
        // Note
        const Text(
          '* Required fields',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  // Step 2: Contact Details
  Widget _buildContactDetailsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add your contact information',
          style: AppTypography.body1,
        ),
        const SizedBox(height: 24),
        
        // Mobile Number
        TextFormField(
          controller: _mobileController,
          decoration: const InputDecoration(
            labelText: 'Mobile Number*',
            hintText: 'Enter your mobile number',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.phone_android),
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
        ),
        const SizedBox(height: 16),
        
        // Email
        TextFormField(
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
            hintText: 'Enter your email address',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.email),
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
        ),
        const SizedBox(height: 24),
        
        // Address section
        const Text(
          'Current Address',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        
        // Address Line
        TextFormField(
          controller: _addressLineController,
          decoration: const InputDecoration(
            labelText: 'Address Line',
            hintText: 'Enter your street address',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        
        // City
        TextFormField(
          controller: _cityController,
          decoration: const InputDecoration(
            labelText: 'City',
            hintText: 'Enter your city',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        
        // State
        TextFormField(
          controller: _stateController,
          decoration: const InputDecoration(
            labelText: 'State',
            hintText: 'Enter your state',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        
        // PIN Code
        TextFormField(
          controller: _pinCodeController,
          decoration: const InputDecoration(
            labelText: 'PIN Code',
            hintText: 'Enter your PIN code',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        
        // Country
        TextFormField(
          controller: _countryController,
          decoration: const InputDecoration(
            labelText: 'Country',
            hintText: 'Enter your country',
            border: OutlineInputBorder(),
          ),
          initialValue: 'India', // Default value
        ),
        const SizedBox(height: 16),
        
        // Note
        const Text(
          '* Required fields',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  // Step 3: Education Details
  Widget _buildEducationDetailsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Let\'s add your education details',
          style: AppTypography.body1,
        ),
        const SizedBox(height: 24),
        
        // Highest Education Level
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: 'Highest Education Level',
            border: OutlineInputBorder(),
          ),
          hint: const Text('Select your highest education level'),
          value: _educationLevelController.text.isEmpty ? null : _educationLevelController.text,
          onChanged: (value) {
            if (value != null) {
              _educationLevelController.text = value;
            }
          },
          items: const [
            DropdownMenuItem(
              value: '10th',
              child: Text('10th'),
            ),
            DropdownMenuItem(
              value: '12th',
              child: Text('12th'),
            ),
            DropdownMenuItem(
              value: 'Diploma',
              child: Text('Diploma'),
            ),
            DropdownMenuItem(
              value: 'ITI',
              child: Text('ITI'),
            ),
            DropdownMenuItem(
              value: 'Graduate',
              child: Text('Graduate'),
            ),
            DropdownMenuItem(
              value: 'Post Graduate',
              child: Text('Post Graduate'),
            ),
            DropdownMenuItem(
              value: 'Doctorate',
              child: Text('Doctorate'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        
        // Education Details
        const Text(
          'Latest Education',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        
        // Institute Name
        TextFormField(
          controller: _instituteNameController,
          decoration: const InputDecoration(
            labelText: 'Institute Name',
            hintText: 'Enter your institute name',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        
        // Field of Study
        TextFormField(
          controller: _fieldOfStudyController,
          decoration: const InputDecoration(
            labelText: 'Field of Study',
            hintText: 'E.g., Computer Science, Mechanical Engineering',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 24),
        
        // Note
        const Text(
          'You can add more education details later',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}

import 'package:equatable/equatable.dart';
import 'package:seeker_flutter/data/models/profile_models.dart';

/// Base class for all profile states
abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any profile operations
class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

/// Loading state for profile operations
class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

/// Profile loaded successfully
class ProfileLoaded extends ProfileState {
  final SeekerProfileAPIResponseModel profile;

  const ProfileLoaded(this.profile);

  @override
  List<Object?> get props => [profile];
}

/// Profile does not exist
class ProfileNotExists extends ProfileState {
  const ProfileNotExists();
}

/// Profile exists
class ProfileExists extends ProfileState {
  const ProfileExists();
}

/// Profile creation in progress
class ProfileCreationInProgress extends ProfileState {
  const ProfileCreationInProgress();
}

/// Profile update in progress
class ProfileUpdateInProgress extends ProfileState {
  const ProfileUpdateInProgress();
}

/// Document upload in progress
class ProfileDocumentUploadInProgress extends ProfileState {
  const ProfileDocumentUploadInProgress();
}

/// Document upload succeeded
class ProfileDocumentUploadSuccess extends ProfileState {
  final String documentUrl;

  const ProfileDocumentUploadSuccess(this.documentUrl);

  @override
  List<Object?> get props => [documentUrl];
}

/// Profile operation failed
class ProfileFailure extends ProfileState {
  final String message;
  final String? code;

  const ProfileFailure({
    required this.message,
    this.code,
  });

  @override
  List<Object?> get props => [message, code];
}

/// Profile section update succeeded
class ProfileSectionUpdateSuccess extends ProfileState {
  final SeekerProfileAPIResponseModel profile;
  final String sectionName;

  const ProfileSectionUpdateSuccess({
    required this.profile,
    required this.sectionName,
  });

  @override
  List<Object?> get props => [profile, sectionName];
}

/// Profile creation succeeded
class ProfileCreationSuccess extends ProfileState {
  final SeekerProfileAPIResponseModel profile;

  const ProfileCreationSuccess(this.profile);

  @override
  List<Object?> get props => [profile];
}

/// Profile update succeeded
class ProfileUpdateSuccess extends ProfileState {
  final SeekerProfileAPIResponseModel profile;

  const ProfileUpdateSuccess(this.profile);

  @override
  List<Object?> get props => [profile];
}

/// Profile deletion in progress
class ProfileDeletionInProgress extends ProfileState {
  const ProfileDeletionInProgress();
}

/// Profile deletion succeeded
class ProfileDeletionSuccess extends ProfileState {
  const ProfileDeletionSuccess();
}

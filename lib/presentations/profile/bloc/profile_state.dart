part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  @override
  List<Object?> get props => [user, message, isLoading];

  final UserStore? user;
  final String message;
  final bool isLoading;

  const ProfileState({
    this.user,
    this.message = "",
    this.isLoading = true,
  });

  ProfileState copyWith({
    UserStore? user,
    String? message,
    bool? isLoading,
  }) {
    return ProfileState(
      user: user ?? this.user,
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

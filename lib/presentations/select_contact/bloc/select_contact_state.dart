part of 'select_contact_bloc.dart';

class SelectContactState extends Equatable {
  final List<UserStore> users;
  final bool isLoading;
  final String message;

  const SelectContactState({
    this.users = const <UserStore>[],
    this.isLoading = true,
    this.message = "",
  });

  SelectContactState copyWith({
    List<UserStore>? users,
    bool? isLoading,
    String? message,
  }) {
    return SelectContactState(
      users: users ?? this.users,
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [
        users,
        isLoading,
        message,
      ];
}

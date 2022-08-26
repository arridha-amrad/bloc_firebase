part of 'select_contact_bloc.dart';

class SelectContactState extends Equatable {
  final List<UserStore> users;
  final bool isLoading;
  final String message;
  final bool isSearch;
  final String search;

  const SelectContactState({
    this.users = const <UserStore>[],
    this.isLoading = true,
    this.message = "",
    this.isSearch = false,
    this.search = "",
  });

  SelectContactState copyWith({
    List<UserStore>? users,
    bool? isLoading,
    String? message,
    bool? isSearch,
    String? search,
  }) {
    return SelectContactState(
      users: users ?? this.users,
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
      isSearch: isSearch ?? this.isSearch,
      search: search ?? this.search,
    );
  }

  @override
  List<Object> get props => [users, isLoading, message, isSearch, search];
}

part of 'select_contact_bloc.dart';

class SelectContactEvent extends Equatable {
  const SelectContactEvent();

  @override
  List<Object> get props => [];
}

class LoadUsers extends SelectContactEvent {}

class SetUsers extends SelectContactEvent {
  final List<UserStore> users;
  const SetUsers(this.users);
  @override
  List<Object> get props => [users];
}

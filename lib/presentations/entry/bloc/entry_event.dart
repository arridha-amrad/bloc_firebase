part of 'entry_bloc.dart';

abstract class EntryEvent extends Equatable {
  const EntryEvent();

  @override
  List<Object> get props => [];
}

class SetIndex extends EntryEvent {
  final int index;
  const SetIndex(this.index);

  @override
  List<Object> get props => [index];
}

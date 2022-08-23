part of 'entry_bloc.dart';

class EntryState extends Equatable {
  final int index;

  const EntryState({
    this.index = 0,
  });

  EntryState copyWith({int? index}) {
    return EntryState(
      index: index ?? this.index,
    );
  }

  @override
  List<Object> get props => [index];
}

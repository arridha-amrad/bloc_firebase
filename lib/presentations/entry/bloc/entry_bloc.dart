import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'entry_event.dart';
part 'entry_state.dart';

class EntryBloc extends HydratedBloc<EntryEvent, EntryState> {
  EntryBloc() : super(const EntryState()) {
    on<SetIndex>(_onSetIndex);
  }

  void _onSetIndex(SetIndex event, Emitter<EntryState> emit) {
    emit(state.copyWith(index: event.index));
  }

  @override
  EntryState? fromJson(Map<String, dynamic> json) {
    return EntryState(index: json["index"] as int);
  }

  @override
  Map<String, dynamic>? toJson(EntryState state) {
    return {
      "index": state.index,
    };
  }
}

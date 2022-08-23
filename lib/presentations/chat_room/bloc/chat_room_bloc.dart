import 'package:bloc/bloc.dart';
import 'package:bloc_firebase/presentations/chat_room/model_validator/text.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'chat_room_event.dart';
part 'chat_room_state.dart';

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  ChatRoomBloc() : super(const ChatRoomState()) {
    on<TextChanged>(_onTextChanged);
    on<Send>(_onSend);
  }

  void _onTextChanged(TextChanged event, Emitter<ChatRoomState> emit) {
    emit(state.copyWith(
        text: Text.dirty(event.text), status: Formz.validate([state.text])));
  }

  Future<void> _onSend(Send event, Emitter<ChatRoomState> emit) async {
    print("text : ${state.text.value}");
  }
}

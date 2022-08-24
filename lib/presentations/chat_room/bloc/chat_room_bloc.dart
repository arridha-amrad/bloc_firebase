import 'package:bloc/bloc.dart';
import 'package:bloc_firebase/domain/abstracts/abstracts.dart';
import 'package:bloc_firebase/presentations/chat_room/model_validator/text.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'chat_room_event.dart';
part 'chat_room_state.dart';

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  final AuthenticationRepository _authenticationRepository;
  ChatRoomBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const ChatRoomState()) {
    on<TextChanged>(_onTextChanged);
    on<Send>(_onSend);
    on<InitRoom>(_onInitRoom);
  }

  void _onInitRoom(InitRoom event, Emitter<ChatRoomState> emit) {
    final authUserId = _authenticationRepository.getAuthUser()!.uid;
    emit(state.copyWith(authUserId: authUserId));
  }

  void _onTextChanged(TextChanged event, Emitter<ChatRoomState> emit) {
    emit(state.copyWith(
        text: Text.dirty(event.text), status: Formz.validate([state.text])));
  }

  Future<void> _onSend(Send event, Emitter<ChatRoomState> emit) async {
    print("text : ${state.text.value}");
  }
}

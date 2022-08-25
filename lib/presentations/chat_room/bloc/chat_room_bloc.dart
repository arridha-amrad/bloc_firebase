import 'package:bloc/bloc.dart';
import 'package:bloc_firebase/domain/abstracts/abstracts.dart';
import 'package:bloc_firebase/domain/models/message.dart';
import 'package:bloc_firebase/presentations/chat_room/model_validator/text.dart';
import 'package:bloc_firebase/presentations/chats/models/chat_extend.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:uuid/uuid.dart';

part 'chat_room_event.dart';
part 'chat_room_state.dart';

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  final AuthenticationRepository _authenticationRepository;
  final ChatRepository _chatRepository;
  ChatRoomBloc({
    required AuthenticationRepository authenticationRepository,
    required ChatRepository chatRepository,
  })  : _authenticationRepository = authenticationRepository,
        _chatRepository = chatRepository,
        super(const ChatRoomState()) {
    on<TextChanged>(_onTextChanged);
    on<Send>(_onSend);
    on<InitRoom>(_onInitRoom);
  }

  Future<void> _onInitRoom(InitRoom event, Emitter<ChatRoomState> emit) async {
    final authUserId = _authenticationRepository.getAuthUser()!.uid;
    final ChatExtend chat = event.chat;
    final receiverId =
        chat.members.where((userId) => userId != authUserId).first;
    await emit.forEach(
      _chatRepository.getMessages(chat.id),
      onData: (List<Message> data) => state.copyWith(
        authUserId: authUserId,
        messages: data,
        receiverId: receiverId,
      ),
    );
  }

  void _onTextChanged(TextChanged event, Emitter<ChatRoomState> emit) {
    emit(state.copyWith(
        text: Text.dirty(event.text), status: Formz.validate([state.text])));
  }

  Future<void> _onSend(Send event, Emitter<ChatRoomState> emit) async {
    final chatId = event.chatId;
    final id = const Uuid().v4();
    final Message message = Message(
      id: id,
      body: state.text.value,
      createdAt: DateTime.now(),
      isRead: false,
      sender: state.authUserId,
      receiver: state.receiverId,
    );
    await _chatRepository.create(message, chatId);
    emit(state.copyWith(
      status: FormzStatus.submissionSuccess,
      text: const Text.pure(),
    ));
  }
}

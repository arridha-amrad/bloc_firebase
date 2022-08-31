import 'package:bloc/bloc.dart';
import 'package:bloc_firebase/domain/abstracts/abstracts.dart';
import 'package:bloc_firebase/domain/models/message.dart';
import 'package:bloc_firebase/presentations/chat_room/model/chat_room.dart';
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
    on<ReadMessage>(_onReadMessage);
    on<ToggleEmojiPicker>(_onToggleEmojiPicker);
    on<HideEmojiPicker>(_onHideEmojiPicker);
  }

  void _onHideEmojiPicker(HideEmojiPicker event, Emitter<ChatRoomState> emit) {
    emit(state.copyWith(isHideEmojiPicker: true));
  }

  void _onToggleEmojiPicker(
      ToggleEmojiPicker event, Emitter<ChatRoomState> emit) {
    emit(state.copyWith(isHideEmojiPicker: !state.isHideEmojiPicker));
  }

  Future<void> _onReadMessage(
      ReadMessage event, Emitter<ChatRoomState> emit) async {
    final List<Message> messages = List.from(state.messages);
    final messagesFromOther =
        messages.where((msg) => msg.receiver == state.authUserId);
    await _chatRepository.update(messagesFromOther.toList(), state.chatId!);
  }

  Future<void> _onInitRoom(InitRoom event, Emitter<ChatRoomState> emit) async {
    final authUserId = _authenticationRepository.getAuthUser()!.uid;
    final ChatRoom chatRoom = event.chat;
    final receiverId = chatRoom.userId;
    if (chatRoom.chatId != null) {
      await emit.forEach(
        _chatRepository.getMessages(chatRoom.chatId!),
        onData: (List<Message> data) => state.copyWith(
          authUserId: authUserId,
          messages: data,
          receiverId: receiverId,
          chatId: chatRoom.chatId,
        ),
      );
    } else {
      emit(state.copyWith(
        authUserId: authUserId,
        receiverId: receiverId,
      ));
    }
  }

  void _onTextChanged(TextChanged event, Emitter<ChatRoomState> emit) {
    emit(state.copyWith(text: event.text));
  }

  Future<void> _onSend(Send event, Emitter<ChatRoomState> emit) async {
    final chatId = state.chatId;
    final Message message = Message(
      id: const Uuid().v4(),
      body: event.text.replaceAll(RegExp(r'(?:[\t ]*(?:\r?\n|\r))+'), '\n'),
      createdAt: DateTime.now(),
      isRead: false,
      sender: state.authUserId,
      receiver: state.receiverId,
    );
    final roomId = await _chatRepository.create(message, chatId);
    emit(state.copyWith(status: FormzStatus.submissionSuccess, text: ""));
    if (chatId == null) {
      await emit.forEach(
        _chatRepository.getMessages(roomId),
        onData: (List<Message> data) => state.copyWith(
          messages: data,
          chatId: roomId,
        ),
      );
    }
  }
}

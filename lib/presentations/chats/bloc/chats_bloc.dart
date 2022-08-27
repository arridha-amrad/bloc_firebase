import 'package:bloc/bloc.dart';
import 'package:bloc_firebase/domain/domain.dart';
import 'package:bloc_firebase/presentations/chats/models/chat_extend.dart';
import 'package:equatable/equatable.dart';

part 'chats_event.dart';
part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  final ChatRepository _chatRepository;
  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  ChatsBloc({
    required ChatRepository chatRepository,
    required UserRepository userRepository,
    required AuthenticationRepository authenticationRepository,
  })  : _chatRepository = chatRepository,
        _userRepository = userRepository,
        _authenticationRepository = authenticationRepository,
        super(const ChatsState()) {
    on<LoadChats>(_onLoad);
    on<LoadExtendChats>(_onLoadExtendChats);
  }

  Future<void> _onLoadExtendChats(
      LoadExtendChats event, Emitter<ChatsState> emit) async {
    final chats = state.chats;
    final authUserId = state.authUserId;
    List<ChatExtend> extendChats = [];
    for (var chat in chats) {
      final userId = chat.members.where((userId) => userId != authUserId).first;
      final user = await _userRepository.show(userId);

      Message? myMessage;

      final message = _chatRepository
          .getMessage(chat.latestMessageId, chat.id)
          .listen((event) {});

      message.onData((data) => myMessage = data);

      final myChat = ChatExtend(
        id: chat.id,
        latestDate: chat.latestDate,
        latestMessageId: chat.latestMessageId,
        members: chat.members,
        partner: user,
      );
      extendChats.add(myChat);
    }
    emit(state.copyWith(myChats: extendChats, isLoading: false));
  }

  Future<void> _onLoad(LoadChats event, Emitter<ChatsState> emit) async {
    final authUserId = _authenticationRepository.getAuthUser()!.uid;
    await emit.forEach(
      _chatRepository.getChats(),
      onData: (List<Chat> data) {
        return state.copyWith(chats: data, authUserId: authUserId);
      },
    );
  }
}

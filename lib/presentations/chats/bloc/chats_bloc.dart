import 'package:bloc/bloc.dart';
import 'package:bloc_firebase/domain/domain.dart';
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

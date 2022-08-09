import 'package:bloc/bloc.dart';
import 'package:bloc_firebase/abstracts/authentication_repository.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthenticationRepository _authenticationRepository;
  HomeBloc(AuthenticationRepository authenticationRepository)
      : _authenticationRepository = authenticationRepository,
        super(const HomeState()) {
    on<Logout>(_onLogout);
  }

  Future<void> _onLogout(Logout event, Emitter<HomeState> emit) async {
    try {
      await _authenticationRepository.logout();
    } catch (e) {
      rethrow;
    }
  }
}

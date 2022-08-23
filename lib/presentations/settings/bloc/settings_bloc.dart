import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<ChangeTheme>(_onChangeTheme);
  }

  void _onChangeTheme(ChangeTheme event, Emitter<SettingsState> emit) {
    emit(state.copyWith(
      isDarkMode: event.isDarkMode,
    ));
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    return SettingsState(
      isDarkMode: json["isDarkMode"] as bool,
    );
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    return {"isDarkMode": state.isDarkMode};
  }
}

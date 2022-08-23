part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class ChangeTheme extends SettingsEvent {
  final bool isDarkMode;
  const ChangeTheme(this.isDarkMode);
  @override
  List<Object> get props => [isDarkMode];
}

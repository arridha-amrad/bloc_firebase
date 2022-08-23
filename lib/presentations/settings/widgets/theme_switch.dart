import 'package:bloc_firebase/presentations/settings/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen: (previous, current) =>
          previous.isDarkMode != current.isDarkMode,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Dark mode"),
            Switch(
                value: state.isDarkMode,
                onChanged: (val) {
                  context
                      .read<SettingsBloc>()
                      .add(ChangeTheme(!state.isDarkMode));
                }),
          ],
        );
      },
    );
  }
}

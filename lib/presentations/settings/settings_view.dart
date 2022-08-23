import 'package:bloc_firebase/presentations/settings/bloc/settings_bloc.dart';
import 'package:bloc_firebase/presentations/settings/widgets/theme_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: BlocProvider.value(
        value: BlocProvider.of<SettingsBloc>(context),
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: const [
            ThemeSwitch(),
          ],
        ),
      ),
    );
  }
}

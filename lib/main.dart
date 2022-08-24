import 'package:bloc_firebase/presentations/entry/entry_view.dart';
import 'package:bloc_firebase/presentations/login/login_view.dart';
import 'package:bloc_firebase/presentations/settings/bloc/settings_bloc.dart';
import 'package:bloc_firebase/routes.dart';
import 'package:bloc_firebase/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final directory = await getApplicationDocumentsDirectory();
  final storage = await HydratedStorage.build(
    storageDirectory: directory,
  );
  HydratedBlocOverrides.runZoned(
    () => runApp(const MyApp()),
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: AppRoutes.all,
            themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            darkTheme: MyTheme.dark,
            theme: MyTheme.light,
            home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                      body: Center(
                    child: CircularProgressIndicator(),
                  ));
                }
                final user = snapshot.data;
                if (user == null) {
                  return const LoginView();
                }
                return EntryView();
              },
            ),
          );
        },
      ),
    );
  }
}

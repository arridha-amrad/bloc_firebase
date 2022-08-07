import 'package:bloc_firebase/abstracts/authentication_repository.dart';
import 'package:bloc_firebase/repository/auth_repo_impl.dart';
import 'package:bloc_firebase/signup/bloc/signup_bloc.dart';
import 'package:bloc_firebase/signup/signup_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(authenticationRepository),
      child: MaterialApp(
        theme: ThemeData(appBarTheme: const AppBarTheme(elevation: 0)),
        home: const SignUpView(),
      ),
    );
  }
}

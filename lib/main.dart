import 'package:bloc_firebase/abstracts/authentication_repository.dart';
import 'package:bloc_firebase/presentations/home/bloc/home_bloc.dart';
import 'package:bloc_firebase/presentations/home/home_view.dart';
import 'package:bloc_firebase/presentations/login/login_view.dart';
import 'package:bloc_firebase/repository/auth_repo_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(authenticationRepository),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(appBarTheme: const AppBarTheme(elevation: 0)),
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
            return const HomeView();
          },
        ),
      ),
    );
  }
}

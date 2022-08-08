import 'package:bloc_firebase/login/bloc/login_bloc.dart';
import 'package:bloc_firebase/login/widgets/login_form.dart';
import 'package:bloc_firebase/repository/auth_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: BlocProvider(
          create: (context) => LoginBloc(AuthenticationRepositoryImpl()),
          child: const LoginForm(),
        ));
  }
}

import 'package:bloc_firebase/presentations/login/bloc/login_bloc.dart';
import 'package:bloc_firebase/presentations/signup/signup_view.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text(state.message), backgroundColor: Colors.red));
        }
      },
      child: ListView(
        padding: const EdgeInsets.all(12),
        children: const [
          SizedBox(height: 12),
          _EmailInput(),
          SizedBox(height: 12),
          _PasswordInput(),
          SizedBox(height: 12),
          _LoginButton(),
          SizedBox(height: 12),
          RegisterLinkButton()
        ],
      ),
    );
  }
}

class RegisterLinkButton extends StatelessWidget {
  const RegisterLinkButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
          onPressed: () {
            Navigator.of(context)
                .pushAndRemoveUntil(SignUpView.route(), (route) => false);
          },
          child: const Text("Register")),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          onChanged: (value) =>
              context.read<LoginBloc>().add(LoginEmailChanged(value)),
          decoration: const InputDecoration(
              border: OutlineInputBorder(), labelText: "Email"),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          onChanged: (value) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(value)),
          decoration: const InputDecoration(
              border: OutlineInputBorder(), labelText: "Password"),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
            onPressed: state.status.isValidated
                ? () {
                    context.read<LoginBloc>().add(const LoginSubmitted());
                  }
                : null,
            child: const Text("Login"));
      },
    );
  }
}

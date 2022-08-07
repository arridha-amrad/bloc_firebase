import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/signup_bloc.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign up"),
      ),
      body: BlocBuilder<SignupBloc, SignupState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(12),
            children: [
              const SizedBox(height: 12),
              TextFormField(
                onChanged: (val) =>
                    context.read<SignupBloc>().add(EmailChanged(val)),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Email"),
              ),
              const SizedBox(height: 12),
              TextFormField(
                onChanged: (value) =>
                    context.read<SignupBloc>().add(PasswordChanged(value)),
                obscureText: true,
                decoration: const InputDecoration(
                    helperMaxLines: 5,
                    helperText:
                        "Minimum six characters, at least one letter, one number and one special character:",
                    border: OutlineInputBorder(),
                    labelText: "Password"),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                  onPressed: context.read<SignupBloc>().state.isEmailValid &&
                          context.read<SignupBloc>().state.isPasswordValid
                      ? () => context
                          .read<SignupBloc>()
                          .add(const SignUpSubmitted())
                      : null,
                  child: const Text("SignUp"))
            ],
          );
        },
      ),
    );
  }
}

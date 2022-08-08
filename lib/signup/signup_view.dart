import 'package:bloc_firebase/login/login_view.dart';
import 'package:bloc_firebase/repository/auth_repo_impl.dart';
import 'package:bloc_firebase/repository/user_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'bloc/signup_bloc.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sign up"),
        ),
        body: BlocProvider(
            create: (context) => SignupBloc(
                  AuthenticationRepositoryImpl(),
                  UserRepositoryImpl(),
                ),
            child: BlocListener<SignupBloc, SignupState>(
              listener: (context, state) {
                if (state.status.isSubmissionFailure) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                          content: Text(state.alert.message),
                          backgroundColor: Colors.red),
                    );
                }
                if (state.status.isSubmissionSuccess) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          "Verification Required",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        content: const Text("Please verify your email"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                context
                                    .read<SignupBloc>()
                                    .add(const ResetField());
                              },
                              child: const Text("Ok"))
                        ],
                      );
                    },
                  );
                }
              },
              child: Stack(
                children: [
                  SizedBox(
                    child: ListView(
                      padding: const EdgeInsets.all(12),
                      children: const [
                        SizedBox(height: 12),
                        _UsernameInput(),
                        SizedBox(height: 12),
                        _EmailInput(),
                        SizedBox(height: 12),
                        _PasswordInput(),
                        SizedBox(height: 12),
                        _SignupButton(),
                        SizedBox(height: 12),
                        _LoginLinkButton()
                      ],
                    ),
                  ),
                  const _OnGoingRequestIndicator(),
                ],
              ),
            )));
  }
}

class _OnGoingRequestIndicator extends StatelessWidget {
  const _OnGoingRequestIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        if (state.status.isSubmissionInProgress) {
          return Positioned.fill(
              child: Container(
            color: Colors.black.withAlpha(50),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ));
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _UsernameInput extends StatelessWidget {
  const _UsernameInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          onChanged: (val) => context.read<SignupBloc>().add(EmailChanged(val)),
          decoration: const InputDecoration(
              border: OutlineInputBorder(), labelText: "Username"),
        );
      },
    );
  }
}

class _LoginLinkButton extends StatelessWidget {
  const _LoginLinkButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
          onPressed: () => Navigator.of(context)
              .pushAndRemoveUntil(LoginView.route(), (route) => false),
          child: const Text("Sign in")),
    );
  }
}

class _SignupButton extends StatelessWidget {
  const _SignupButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
            onPressed: state.status.isValidated
                ? () => context.read<SignupBloc>().add(const SignUpSubmitted())
                : null,
            child: const Text("SignUp"));
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
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          onChanged: (value) =>
              context.read<SignupBloc>().add(PasswordChanged(value)),
          obscureText: true,
          decoration: const InputDecoration(
              helperMaxLines: 5,
              helperText:
                  "Minimum six characters, at least one letter, one number and one special character:",
              border: OutlineInputBorder(),
              labelText: "Password"),
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          onChanged: (val) => context.read<SignupBloc>().add(EmailChanged(val)),
          decoration: const InputDecoration(
              border: OutlineInputBorder(), labelText: "Email"),
        );
      },
    );
  }
}

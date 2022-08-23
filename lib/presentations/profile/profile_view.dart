import 'package:bloc_firebase/domain/domain.dart';
import 'package:bloc_firebase/presentations/profile/bloc/profile_bloc.dart';
import 'package:bloc_firebase/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(
        authenticationRepository: AuthenticationRepositoryImpl(),
        userRepository: UserRepositoryImpl(),
      )..add(SetUser()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state.message == "UnAuthenticated") {
              Navigator.of(context).pushReplacementNamed(Routes.login.name);
            }
          },
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.user == null) {
                return const Center(
                  child: Text("User not found"),
                );
              }
              return ListView(
                padding: const EdgeInsets.all(12),
                children: [
                  Row(
                    children: [
                      const Text("Name"),
                      const SizedBox(width: 12),
                      Text(state.user!.username)
                    ],
                  ),
                  Row(
                    children: [
                      const Text("Email"),
                      const SizedBox(width: 12),
                      Text(state.user!.email)
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

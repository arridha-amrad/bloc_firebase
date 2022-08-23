import 'package:bloc_firebase/domain/domain.dart';
import 'package:bloc_firebase/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/select_contact_bloc.dart';

class SelectContact extends StatelessWidget {
  const SelectContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SelectContactBloc(
        userRepository: UserRepositoryImpl(),
        authenticationRepository: AuthenticationRepositoryImpl(),
      )..add(LoadUsers()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Select Contact"),
        ),
        body: BlocBuilder<SelectContactBloc, SelectContactState>(
          builder: (context, state) {
            return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  final user = state.users[index];
                  return ListTile(
                    onTap: () => Navigator.of(context).pushNamed(
                      Routes.chatRoom.name,
                      arguments: user,
                    ),
                    leading: const CircleAvatar(),
                    title: Text(user.username),
                    subtitle: Text(user.email),
                  );
                });
          },
        ),
      ),
    );
  }
}
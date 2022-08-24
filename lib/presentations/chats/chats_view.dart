import 'package:bloc_firebase/domain/domain.dart';
import 'package:bloc_firebase/domain/repositories/chat_repository_impl.dart';
import 'package:bloc_firebase/presentations/chats/bloc/chats_bloc.dart';
import 'package:bloc_firebase/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatsBloc(
        chatRepository: ChatRepositoryImpl(),
        authenticationRepository: AuthenticationRepositoryImpl(),
        userRepository: UserRepositoryImpl(),
      )..add(LoadChats()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Chats"),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () => Navigator.of(context).pushNamed(
            Routes.selectContact.name,
          ),
          child: const Icon(Icons.message),
        ),
        body: BlocBuilder<ChatsBloc, ChatsState>(
          builder: (context, state) {
            return ListView.builder(
              itemCount: state.chats.length,
              itemBuilder: (context, index) {
                final chat = state.chats[index];
                final partner = chat.users
                    .where((user) => user.id != state.authUserId)
                    .first;
                return ListTile(
                  onTap: () => Navigator.of(context)
                      .pushNamed(Routes.chatRoom.name, arguments: chat),
                  trailing: Text(DateFormat.jm().format(chat.latestDate)),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      partner.avatar,
                    ),
                  ),
                  title: Text(partner.username),
                  subtitle: Text(chat.latestMessage),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

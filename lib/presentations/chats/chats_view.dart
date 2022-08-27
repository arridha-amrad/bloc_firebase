import 'package:bloc_firebase/domain/domain.dart';
import 'package:bloc_firebase/domain/repositories/chat_repository_impl.dart';
import 'package:bloc_firebase/presentations/chat_room/model/chat_room.dart';
import 'package:bloc_firebase/presentations/chats/bloc/chats_bloc.dart';
import 'package:bloc_firebase/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatRepository chatRepository = ChatRepositoryImpl();
    return BlocProvider(
      create: (_) => ChatsBloc(
        chatRepository: chatRepository,
        authenticationRepository: AuthenticationRepositoryImpl(),
        userRepository: UserRepositoryImpl(),
      )..add(LoadChats()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Chats"),
        ),
        floatingActionButton: BlocBuilder<ChatsBloc, ChatsState>(
          buildWhen: (previous, current) => previous.myChats != current.myChats,
          builder: (context, state) {
            return FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: () => Navigator.of(context)
                  .pushNamed(Routes.selectContact.name, arguments: context),
              child: const Icon(
                Icons.message,
                color: Colors.white,
              ),
            );
          },
        ),
        body: BlocListener<ChatsBloc, ChatsState>(
          listenWhen: (previous, current) => previous.chats != current.chats,
          listener: (context, state) {
            context.read<ChatsBloc>().add(LoadExtendChats());
          },
          child: BlocBuilder<ChatsBloc, ChatsState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount: state.myChats.length,
                itemBuilder: (context, index) {
                  final chat = state.myChats[index];
                  final partner = chat.partner;
                  final ChatRoom chatRoom = ChatRoom(
                      avatar: partner.avatar,
                      userId: partner.id,
                      username: partner.username,
                      chatId: chat.id);
                  return ListTile(
                    onTap: () => Navigator.of(context)
                        .pushNamed(Routes.chatRoom.name, arguments: chatRoom),
                    trailing: Text(DateFormat.jm().format(chat.latestDate)),
                    leading: CircleAvatar(
                        backgroundImage: NetworkImage(partner.avatar)),
                    title: Text(partner.username),
                    subtitle: StreamBuilder<Message>(
                      stream: chatRepository.getMessage(
                          chat.latestMessageId, chat.id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        final message = snapshot.data;
                        return Wrap(
                          children: [
                            message?.sender == state.authUserId
                                ? Icon(
                                    Icons.done_all,
                                    color: message!.isRead
                                        ? Colors.blue
                                        : Colors.grey,
                                    size: 15,
                                  )
                                : const SizedBox.shrink(),
                            Text(
                              message!.body,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

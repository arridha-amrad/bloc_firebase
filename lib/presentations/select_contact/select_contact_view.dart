import 'package:bloc_firebase/domain/domain.dart';
import 'package:bloc_firebase/presentations/chat_room/model/chat_room.dart';
import 'package:bloc_firebase/presentations/chats/bloc/chats_bloc.dart';
import 'package:bloc_firebase/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/select_contact_bloc.dart';
import 'widgets/search_user.dart';

class SelectContact extends StatelessWidget {
  const SelectContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BuildContext ctx =
        ModalRoute.of(context)?.settings.arguments as BuildContext;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SelectContactBloc(
            userRepository: UserRepositoryImpl(),
            authenticationRepository: AuthenticationRepositoryImpl(),
          )..add(LoadUsers()),
        ),
        BlocProvider.value(
          value: ctx.read<ChatsBloc>(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Select Contact"),
          actions: [
            BlocBuilder<SelectContactBloc, SelectContactState>(
              builder: (context, state) {
                return state.isSearch
                    ? IconButton(
                        onPressed: () {
                          context.read<SelectContactBloc>().add(ToggleSearch());
                        },
                        icon: const Icon(Icons.close))
                    : IconButton(
                        onPressed: () {
                          context.read<SelectContactBloc>().add(ToggleSearch());
                        },
                        icon: const Icon(Icons.search));
              },
            )
          ],
        ),
        body: BlocBuilder<SelectContactBloc, SelectContactState>(
          builder: (context, state) {
            return BlocBuilder<ChatsBloc, ChatsState>(
              builder: (cbContext, cbState) {
                return Container(
                  margin: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      state.isSearch ? const SearchForm() : SizedBox.fromSize(),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.users.length,
                          itemBuilder: (context, index) {
                            String? roomId;
                            final user = state.users[index];
                            final existingChat = cbState.myChats
                                .where((chat) => chat.partner.id == user.id);
                            if (existingChat.isNotEmpty) {
                              roomId = existingChat.first.id;
                            }
                            final ChatRoom chatRoom = ChatRoom(
                              avatar: user.avatar,
                              userId: user.id,
                              username: user.username,
                              chatId: roomId,
                            );
                            return ListTile(
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pushNamed(
                                  Routes.chatRoom.name,
                                  arguments: chatRoom,
                                );
                              },
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(user.avatar),
                              ),
                              title: Text(user.username),
                              subtitle: Text(user.email),
                            );
                          }),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

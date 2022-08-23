import 'package:bloc_firebase/presentations/chats/chats_view.dart';
import 'package:bloc_firebase/presentations/home/home_view.dart';
import 'package:bloc_firebase/presentations/profile/bloc/profile_bloc.dart';
import 'package:bloc_firebase/presentations/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/entry_bloc.dart';

class EntryView extends StatelessWidget {
  final screens = const [
    HomeView(),
    ProfileView(),
    ChatView(),
  ];

  const EntryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EntryBloc(),
      child: BlocBuilder<EntryBloc, EntryState>(
        buildWhen: (previous, current) => previous.index != current.index,
        builder: (context, state) {
          return Scaffold(
              body: IndexedStack(
                index: state.index,
                children: screens,
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: state.index,
                onTap: (value) =>
                    context.read<EntryBloc>().add(SetIndex(value)),
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_box),
                    label: "Account",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.chat),
                    label: "Chats",
                  ),
                ],
              ));
        },
      ),
    );
  }
}

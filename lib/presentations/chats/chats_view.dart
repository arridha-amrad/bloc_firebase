import 'package:bloc_firebase/routes.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}

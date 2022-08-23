import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/chat_room_bloc.dart';

class SendButton extends StatelessWidget {
  const SendButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.green,
      ),
      child: Center(
        child: BlocBuilder<ChatRoomBloc, ChatRoomState>(
          builder: (context, state) {
            return IconButton(
              onPressed: () => context.read<ChatRoomBloc>().add(Send()),
              icon: const Icon(Icons.send_rounded),
              color: Colors.white,
            );
          },
        ),
      ),
    );
  }
}

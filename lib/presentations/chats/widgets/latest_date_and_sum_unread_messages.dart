import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/domain.dart';
import '../models/chat_extend.dart';

class LatestDateAndSumUnreadMessages extends StatelessWidget {
  const LatestDateAndSumUnreadMessages({
    Key? key,
    required this.chat,
    required this.chatRepository,
  }) : super(key: key);

  final ChatExtend chat;
  final ChatRepository chatRepository;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: chatRepository.sumUnreadMessages(chat.id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox.shrink();
          }
          final sum = snapshot.data;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              sum == 0
                  ? const SizedBox.shrink()
                  : Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(18)),
                      child: Center(
                        child: Text(
                          sum.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
              Text(DateFormat.jm().format(chat.latestDate)),
            ],
          );
        });
  }
}

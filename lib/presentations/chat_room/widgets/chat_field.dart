import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../bloc/chat_room_bloc.dart';

class ChatField extends StatefulWidget {
  const ChatField({Key? key}) : super(key: key);

  @override
  State<ChatField> createState() => _ChatFieldState();
}

class _ChatFieldState extends State<ChatField> {
  TextEditingController textCon = TextEditingController();
  bool isShowEmojiList = false;
  FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    textCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: BlocListener<ChatRoomBloc, ChatRoomState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (context, state) {
                if (state.status.isSubmissionSuccess) {
                  textCon.clear();
                }
              },
              child: BlocBuilder<ChatRoomBloc, ChatRoomState>(
                buildWhen: (previous, current) => previous.text != current.text,
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: TextFormField(
                      focusNode: focusNode,
                      onTap: () {
                        setState(() {
                          isShowEmojiList = false;
                        });
                      },
                      maxLines: null,
                      textInputAction: TextInputAction.newline,
                      controller: textCon,
                      onChanged: (value) =>
                          context.read<ChatRoomBloc>().add(TextChanged(value)),
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isShowEmojiList = !isShowEmojiList;
                                if (isShowEmojiList) {
                                  focusNode.unfocus();
                                } else {
                                  FocusScope.of(context)
                                      .requestFocus(focusNode);
                                }
                              });
                            },
                            icon: const Icon(Icons.emoji_emotions_outlined)),
                        hintText: "Type...",
                        border: InputBorder.none,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          BlocBuilder<ChatRoomBloc, ChatRoomState>(
            builder: (context, state) {
              return Offstage(
                offstage: !isShowEmojiList,
                child: SizedBox(
                    height: 250,
                    child: EmojiPicker(
                      onEmojiSelected: (category, emoji) {
                        context.read<ChatRoomBloc>().add(
                            TextChanged("${state.text.value} ${emoji.emoji}"));
                      },
                      onBackspacePressed: () {},
                      textEditingController: textCon,
                      config: Config(
                        columns: 7,
                        emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                        verticalSpacing: 0,
                        horizontalSpacing: 0,
                        gridPadding: EdgeInsets.zero,
                        initCategory: Category.RECENT,
                        bgColor: const Color(0xFFF2F2F2),
                        indicatorColor: Colors.blue,
                        iconColor: Colors.grey,
                        iconColorSelected: Colors.blue,
                        backspaceColor: Colors.blue,
                        skinToneDialogBgColor: Colors.white,
                        skinToneIndicatorColor: Colors.grey,
                        enableSkinTones: true,
                        showRecentsTab: true,
                        recentsLimit: 28,
                        replaceEmojiOnLimitExceed: false,
                        noRecents: const Text(
                          'No Recents',
                          style: TextStyle(fontSize: 20, color: Colors.black26),
                          textAlign: TextAlign.center,
                        ),
                        tabIndicatorAnimDuration: kTabScrollDuration,
                        categoryIcons: const CategoryIcons(),
                        buttonMode: ButtonMode.MATERIAL,
                      ),
                    )),
              );
            },
          ),
        ],
      ),
    );
  }
}

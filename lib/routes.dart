import 'package:bloc_firebase/presentations/chat_room/chat_room_view.dart';
import 'package:bloc_firebase/presentations/entry/entry_view.dart';
import 'package:bloc_firebase/presentations/login/login_view.dart';
import 'package:bloc_firebase/presentations/select_contact/select_contact_view.dart';
import 'package:bloc_firebase/presentations/settings/settings_view.dart';
import 'package:bloc_firebase/presentations/signup/signup_view.dart';
import 'package:bloc_firebase/presentations/todo_form/todo_form_view.dart';
import 'package:flutter/material.dart';

enum Routes {
  login,
  todoForm,
  settings,
  signup,
  selectContact,
  entry,
  chatRoom
}

class AppRoutes {
  static final Map<String, Widget Function(BuildContext)> all = {
    Routes.login.name: (_) => const LoginView(),
    Routes.signup.name: (_) => const SignUpView(),
    Routes.todoForm.name: (_) => const TodoFormView(),
    Routes.settings.name: (_) => const SettingsView(),
    Routes.selectContact.name: (_) => const SelectContact(),
    Routes.entry.name: (_) => const EntryView(),
    Routes.chatRoom.name: (_) => const ChatRoomView(),
  };
}

import 'package:bloc_firebase/presentations/login/login_view.dart';
import 'package:bloc_firebase/presentations/todo_form/views/todo_form_view.dart';
import 'package:flutter/material.dart';

enum Routes { login, todoForm }

class AppRoutes {
  static final Map<String, Widget Function(BuildContext)> all = {
    Routes.login.name: (_) => const LoginView(),
    Routes.todoForm.name: (_) => const TodoFormView(),
  };
}

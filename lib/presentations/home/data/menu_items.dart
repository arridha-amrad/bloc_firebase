import 'package:bloc_firebase/presentations/home/models/item.dart';
import 'package:flutter/material.dart';

class MenuItems {
  static const itemSettings = Item("Settings", Icons.settings);
  static const createTodo = Item("Create Todo", Icons.add);
  static const signOut = Item("Sign Out", Icons.logout);

  static const listOne = [itemSettings, createTodo];
  static const listTwo = [signOut];
}

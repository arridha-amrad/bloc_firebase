import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_firebase/abstracts/authentication_repository.dart';
import 'package:bloc_firebase/abstracts/todo_repository.dart';
import 'package:bloc_firebase/models/todo.dart';
import 'package:bloc_firebase/presentations/todos/bloc/todo_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthenticationRepository _authenticationRepository;
  final TodoRepository _todoRepository;

  StreamSubscription? _todosSubscription;

  HomeBloc(
    AuthenticationRepository authenticationRepository,
    TodoRepository todoRepository,
  )   : _authenticationRepository = authenticationRepository,
        _todoRepository = todoRepository,
        super(const HomeState()) {
    on<Logout>(_onLogout);
    on<LoadTodos>(_onLoadTodos);
    on<UpdateTodos>(_onUpdateTodos);
  }

  void _onUpdateTodos(UpdateTodos event, Emitter<HomeState> emit) {
    emit(state.copyWith(
      todos: event.todos,
    ));
  }

  Future<void> _onLoadTodos(LoadTodos event, Emitter<HomeState> emit) async {
    // await Future.delayed(const Duration(microseconds: 200));
    _todosSubscription?.cancel();
    _todosSubscription = _todoRepository
        .getAllTodos()
        .listen((todos) => add(UpdateTodos(todos)));
  }

  // Stream<HomeState> mapEventToState(
  //     HomeEvent event, Emitter<HomeState> emit) async* {
  //   if (event is LoadTodos) {
  //     yield* _mapLoadTodosToState();
  //   }
  //   if (event is UpdateTodos) {
  //     yield* _mapUpdateTodosToState(event);
  //   }
  // }

  // Stream<HomeState> _mapLoadTodosToState() async* {
  //   _todosSubscription?.cancel();
  //   _todosSubscription = _todoRepository.getAllTodos().listen((todos) {
  //     return add(UpdateTodos(todos));
  //   });
  // }

  // Stream<HomeState> _mapUpdateTodosToState(UpdateTodos event) async* {
  //   yield TodoLoaded(todos: event.todos);
  // }

  Future<void> _onLogout(Logout event, Emitter<HomeState> emit) async {
    try {
      await _authenticationRepository.logout();
    } catch (e) {
      rethrow;
    }
  }
}

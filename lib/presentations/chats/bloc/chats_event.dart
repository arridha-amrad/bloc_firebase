part of 'chats_bloc.dart';

abstract class ChatsEvent extends Equatable {
  const ChatsEvent();

  @override
  List<Object> get props => [];
}

class LoadChats extends ChatsEvent {}

class LoadExtendsChat extends ChatsEvent {}
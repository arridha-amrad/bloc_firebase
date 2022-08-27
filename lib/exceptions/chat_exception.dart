class ChatException implements Exception {
  final String message;
  const ChatException(this.message);

  @override
  String toString() {
    return "Chat Exception : $message";
  }
}

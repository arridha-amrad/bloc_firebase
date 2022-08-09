class TodoException implements Exception {
  final String message;
  const TodoException(this.message);

  @override
  String toString() => "Todo Exception : $message";
}

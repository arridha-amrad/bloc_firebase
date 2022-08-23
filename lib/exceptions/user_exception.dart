class UserException implements Exception {
  final String message;
  const UserException(this.message);

  @override
  String toString() {
    return "User exception : $message";
  }
}

import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRepository {
  Future<UserCredential> signup(String email, String password);
  Future<void> logout();
  Future<UserCredential> login(String email, String password);
}

import 'package:bloc_firebase/domain/abstracts/abstracts.dart';
import 'package:bloc_firebase/exceptions/auth_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final _auth = FirebaseAuth.instance;

  @override
  Future<UserCredential> signup(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        throw AuthException(message: "Email has been registered");
      }
    } catch (e) {
      rethrow;
    }
    throw AuthException(message: "Something went wrong");
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }

  @override
  Future<UserCredential> login(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        throw AuthException(message: "User not found");
      }
      if (e.code == "wrong-password") {
        throw AuthException(message: "Invalid email and password");
      }
    } catch (e) {
      rethrow;
    }
    throw AuthException(message: "Something went wrong");
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw AuthException(
          message: "Failed to get current user after registration complete");
    }
    await user.sendEmailVerification();
  }

  @override
  User? getAuthUser() {
    final user = _auth.currentUser;
    return user;
  }
}

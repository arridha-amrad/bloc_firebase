import 'package:bloc_firebase/abstracts/authentication_repository.dart';
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
}

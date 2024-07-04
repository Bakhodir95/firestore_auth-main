import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_auth/services/users_firebase_service.dart';

class RegisterController {
  final fireAuth = FirebaseAuth.instance;
  final userService = UserFirerbaseService();

  login(String email, String password) async {
    try {
      await fireAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  register(String name, String email, String password) async {
    try {
      await fireAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await userService.addUser(
          name: name, email: email, uid: fireAuth.currentUser!.uid);
    } catch (e) {
      rethrow;
    }
  }

  resetPassword(String email) async {
    await fireAuth.sendPasswordResetEmail(email: email);
  }
}

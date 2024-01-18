import 'package:bloc_firebase_test/dependency_injection/di_container.dart';
import 'package:bloc_firebase_test/exception/exception.dart';
import 'package:bloc_firebase_test/model/user.dart' as model;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class AuthMethods {
  final FirebaseAuth _auth = locator<FirebaseAuth>();
  final FirebaseFirestore _firestore = locator<FirebaseFirestore>();

  User? getCurrentUser() {
    final currentUser = _auth.currentUser;
    return currentUser;
  }

  Future<void> signUp(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final currentUser = credential.user;
      if (currentUser != null) {
        final user = model.User(
          uidConected: '4546842654', //vpiši pravi uid!!!!!
          email: currentUser.email ?? 'no email',
          uid: currentUser.uid,
        );
        await _firestore.collection('users').doc(user.uid).set(user.toMap());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException(message: 'password provided is too short');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException(message: 'this email is already used');
      } else if (e.code == 'invalid-email') {
        throw AuthException(message: 'bad formated email');
      } else if (e.code == 'network-request-failed') {
        throw AuthException(message: 'No internet connection.');
      } else {
        throw AuthException(message: 'something another');
      }
    } catch (e) {
      throw e;
    }
    ;
  }

  Future<void> signIn(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw e;
    }
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }
}

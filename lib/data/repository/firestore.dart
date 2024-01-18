import 'package:bloc_firebase_test/dependency_injection/di_container.dart';
import 'package:bloc_firebase_test/model/driving_data.dart';
import 'package:bloc_firebase_test/model/user.dart' as model;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = locator<FirebaseFirestore>();
  final FirebaseAuth _auth = locator<FirebaseAuth>();

  User? get currentUser =>
      _auth.currentUser; //v kolikor kličeš si prijavljen nebo nikoli null

  Future<model.User> fetchUserData(String uid) async {
    try {
      final DocumentSnapshot fetchedUserSnapshot =
          await _firestore.collection('users').doc(uid).get();

      // Correctly get the data as a map
      final Map<String, dynamic> userData =
          fetchedUserSnapshot.data() as Map<String, dynamic>;

      final model.User user = model.User.fromMap(userData);
      return user;
    } catch (e) {
      throw e;
    }
  }

  // Future<DrivingData> fetchDrivingData() async {
  //   try {
  //     final allDataCollection = await _firestore
  //         .collection('data')
  //         .doc(currentUser!.uid)
  //         .collection(currentUser!.uid);
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  Future<void> addData(DrivingData data) async {
    final String docId = Uuid().v1();

    try {
      _firestore
          .collection('data')
          .doc(currentUser!.uid)
          .collection(currentUser!.uid)
          .doc(docId)
          .set(data.toMap());
    } catch (e) {
      print(e);
      throw e;
    }
  }
}

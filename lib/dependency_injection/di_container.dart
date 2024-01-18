import 'package:bloc_firebase_test/data/repository/auth.dart';
import 'package:bloc_firebase_test/data/repository/firestore.dart';
import 'package:bloc_firebase_test/data/repository/logicMethods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);
  locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  locator.registerLazySingleton<AuthMethods>(() => AuthMethods());
  locator.registerLazySingleton<FirestoreMethods>(() => FirestoreMethods());
  locator.registerLazySingleton<LogicMethods>(() => LogicMethods());
}

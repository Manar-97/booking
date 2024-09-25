import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  @singleton
  FirebaseAuth getFirebaseAuth() => FirebaseAuth.instance;
}

@module
abstract class FireBaseModule {
  @singleton
  FirebaseFirestore getFirebaseFirestore() => FirebaseFirestore.instance;
}
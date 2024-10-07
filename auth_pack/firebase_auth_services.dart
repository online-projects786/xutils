import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'requirements.dart';
import 'firebase_storage_services.dart';
import 'firestore_services.dart';

class FirebaseAuthServices {
  final auth.FirebaseAuth firebaseAuth = auth.FirebaseAuth.instance;
  Requirements req = Requirements();
  Future<User?> registerNewUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? phone,
    Uint8List? file,
  }) async {
    email = email.trim();
    password = password.trim();
    firstName = firstName.trim();
    lastName = lastName.trim();
    phone != null ? phone.trim() : phone;

    //Registering/Creating User using email.
    req.user = await FirebaseAuthServices()
        ._registerWithEmailAndPassword(email, password);
    if (req.user == null) {
      return req.user;
    }

    //Uploading Data of User to database.
    FirestoreServices().saveUserProfileData(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
    );
    //Uploading User Profile Image to Database
    if (file != null) {
      FirebaseStorageServices().uploadProfileImage(file);
    }
    return req.user;
  }

  Future<auth.User?> _registerWithEmailAndPassword(
      String email, String password) async {
    auth.UserCredential userCre = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    req.user = userCre.user;
    return userCre.user;
  }

  Future<auth.User?> signInWithEmailAndPassword(
      String email, String password) async {
    auth.UserCredential userCre = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    req.user = userCre.user;
    return userCre.user;
  }

  Future<void> signOut() async {
    firebaseAuth.signOut();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/user_data_model.dart';
import 'requirements.dart';

class FirestoreServices {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Requirements req = Requirements();
  Future<bool> saveUserProfileData({
    required String firstName,
    required String lastName,
    required String email,
    String? phone,
  }) async {
    //Uploading Data of User to database.
    UserFields user = UserFields();
    await firebaseFirestore
        .collection(req.collection)
        .doc(req.userProfileDataDoc)
        .set({
      user.date: DateTime.now(),
      user.firstName: firstName,
      user.lastName: lastName,
      user.email: email,
      user.phone: phone,
      user.id: req.user?.uid,
    });
    return true;
  }

  Future<UserDataModel> getUserData() async {
    DocumentSnapshot snapshot = await firebaseFirestore
        .collection(req.collection)
        .doc(req.userProfileDataDoc)
        .get();
    return UserDataModel.fromDocument(snapshot);
  }

  Future<bool> verifyExistance(String email) async {
    DocumentSnapshot snapshot = await firebaseFirestore
        .collection(email)
        .doc(req.userProfileDataDoc)
        .get();
    return snapshot.exists;
  }
}

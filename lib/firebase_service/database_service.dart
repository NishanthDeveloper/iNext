import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({required this.uid});

  final CollectionReference userCollection =
  FirebaseFirestore.instance.collection("users");



  Future savingUserData(String fullName, String email, String password,String address,String phone) async {
    return await userCollection.doc(uid).set({
      "fullName": fullName,
      "address": address,
      "phone": phone,
      "email": email,
      "profilePic": "",
      "uid": uid,
    });
  }

  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
    await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }




}

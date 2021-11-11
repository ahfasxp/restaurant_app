import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreServices {
  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<void> addUser({
    required String uid,
    required String fullName,
    required String email,
  }) {
    return userCollection
        .doc(uid)
        .set({
          'full_name': fullName,
          'email': email,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  static Future<void> updateUser({
    required String fullName,
    required String telephon,
    required String address,
  }) {
    var currentUser = FirebaseAuth.instance.currentUser;
    return userCollection
        .doc(currentUser!.uid)
        .set(
          {
            'full_name': fullName,
            'telephone': telephon,
            'address': address,
          },
          SetOptions(merge: true),
        )
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  static Future<DocumentSnapshot> getUser() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    return await userCollection.doc(currentUser!.uid).get();
  }

  static Future<void> deleteUser(String uid) {
    return userCollection
        .doc(uid)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
}

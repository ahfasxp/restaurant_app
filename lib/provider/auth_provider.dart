import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/model/user_model.dart';
import 'package:restaurant_app/utils/auth_exception_handler.dart';
import 'package:restaurant_app/utils/auth_result_status.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth firebaseAuth;
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  AuthProvider({required this.firebaseAuth});

  late UserModel _user;
  UserModel get user => _user;

  late AuthResultStatus _status;
  AuthResultStatus get status => _status;

  Future<AuthResultStatus> createAccount(
      {required String fullName,
      required String email,
      required String password}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        await _userCollection
            .doc(userCredential.user!.uid)
            .set({
              'full_name': fullName,
              'email': email,
            })
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));

        _status = AuthResultStatus.successful;
        getUser(uid: userCredential.user!.uid);
      } else {
        _status = AuthResultStatus.undefined;
        notifyListeners();
      }
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      notifyListeners();
    } catch (e) {
      print('Exception @signUp: $e');
      _status = AuthExceptionHandler.handleException(e);
      notifyListeners();
    }

    return _status;
  }

  Future<AuthResultStatus> signIn({email, password}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        _status = AuthResultStatus.successful;
        getUser(uid: userCredential.user!.uid);
      } else {
        _status = AuthResultStatus.undefined;
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Failed to signIn, error: $e');
    }

    return _status;
  }

  void signOut() {
    firebaseAuth.signOut();
  }

  Future<void> getUser({required String uid}) async {
    try {
      DocumentSnapshot snapshot = await _userCollection.doc(uid).get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      final user = UserModel.fromJson(uid, data);
      _user = user;
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to getUser, error: $e');
    }
  }

  Future<void> updateUser(
      {required String uid,
      required String fullName,
      required String telephone,
      required String address}) async {
    try {
      await _userCollection
          .doc(uid)
          .set(
            {
              'full_name': fullName,
              'telephone': telephone,
              'address': address,
            },
            SetOptions(merge: true),
          )
          .then((value) => print("User Updated"))
          .catchError((error) => print("Failed to update user: $error"));

      getUser(uid: uid);
    } catch (e) {
      throw Exception('Failed to updateUser, error: $e');
    }
  }

  Future<void> deleteUser(String uid) {
    return _userCollection
        .doc(uid)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
}

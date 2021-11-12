import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant_app/utils/auth/auth_exception_handler.dart';
import 'package:restaurant_app/utils/auth/auth_result_status.dart';
import 'package:restaurant_app/utils/firestore_services.dart';

class FirebaseAuthHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late AuthResultStatus _status;

  ///
  /// Helper Function
  ///

  Future<AuthResultStatus> createAccount({fullName, email, password}) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        final uid = userCredential.user!.uid;
        FirestoreServices.addUser(uid: uid, fullName: fullName, email: email);
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    } catch (e) {
      print('Exception @signUp: $e');
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  Future<AuthResultStatus> signIn({email, password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
    } on FirebaseAuthException catch (e) {
      print('Exception @signIn: $e');
      _status = AuthExceptionHandler.handleException(e);
    }

    return _status;
  }

  signOut() {
    _auth.signOut();
  }

  // static Future deleteUser(String email, String password) async {
  //   try {
  //     var currentUser = _auth.currentUser;
  //     await FirebaseAuth.instance.currentUser!.delete();
  //     await FirestoreServices.deleteUser(currentUser!.uid);
  //     return true;
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'requires-recent-login') {
  //       print(
  //           'The user must reauthenticate before this operation can be executed.');
  //     }
  //   }
  // }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/utils/firestore_services.dart';
import 'package:restaurant_app/widgets/toast_custom.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscureText = true;
  bool _isLoading = false;

  // Inisialisasi Controller
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Expanded(child: Center(child: CircularProgressIndicator()))
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 34),
                child: Text(
                  'Full Name',
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 12),
                    fillColor: whiteColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Color(0xFF9CA3AF),
                        width: 2.0,
                      ),
                    ),
                    hintText: 'Enter your full name',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 34),
                child: Text(
                  'Email address',
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 12),
                    fillColor: whiteColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Color(0xFF9CA3AF),
                        width: 2.0,
                      ),
                    ),
                    hintText: 'Eg namaemail@emailkamu.com',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 34),
                child: Text(
                  'Password',
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 12),
                    fillColor: whiteColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Color(0xFF9CA3AF),
                        width: 2.0,
                      ),
                    ),
                    hintText: '**** **** ****',
                    suffixIcon: IconButton(
                      icon: Icon(_obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 34,
              ),
              Align(
                child: ElevatedButton(
                  onPressed: _register,
                  child: Text(
                    'Registration',
                    style: whiteTextStyle.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: greenColor,
                    minimumSize: Size(256, 49),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Align(
                child: ElevatedButton(
                  onPressed: () {
                    Toast.show(
                      'Coming Soon',
                      context,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/ic_google.png',
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(
                        width: 24,
                      ),
                      Text(
                        'Sign up with Google',
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[300],
                    minimumSize: Size(256, 49),
                    maximumSize: Size(256, 49),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                ),
              ),
            ],
          );
  }

  // NOTE: Method Register
  void _register() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final name = _nameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;

      // Metode Signup form Firebase
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((result) => FirestoreServices.addUser(
              uid: result.user!.uid, fullName: name, email: email));

      Toast.show(
        'Register Successfullly',
        context,
        backgroundColor: Colors.green.shade300,
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Toast.show(
          'The password provided is too weak.',
          context,
          backgroundColor: Colors.red.shade300,
        );
      } else if (e.code == 'email-already-in-use') {
        Toast.show(
          'The account already exists for that email.',
          context,
          backgroundColor: Colors.red.shade300,
        );
      } else {
        print('Failed with error code: ${e.code}');
        Toast.show(
          e.message.toString(),
          context,
          backgroundColor: Colors.red.shade300,
        );
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

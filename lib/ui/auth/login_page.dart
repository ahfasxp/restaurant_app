import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/ui/home/home_page.dart';
import 'package:restaurant_app/utils/auth/auth_exception_handler.dart';
import 'package:restaurant_app/utils/auth/auth_result_status.dart';
import 'package:restaurant_app/utils/auth/firebase_auth_helper.dart';
import 'package:restaurant_app/widgets/toast_custom.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Inisialisai Objek Firebase Auth
  bool _obscureText = true;
  bool _isLoading = false;

  // Inisialisasi Controller
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
                    hintText: '**** **** ****',
                  ),
                ),
              ),
              SizedBox(
                height: 34,
              ),
              Align(
                child: ElevatedButton(
                  onPressed: _login,
                  child: Text(
                    'Login',
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
                  onPressed: () {},
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

  // NOTE: Method Login
  void _login() async {
    setState(() {
      _isLoading = true;
    });
    final email = _emailController.text;
    final password = _passwordController.text;
    final status =
        await FirebaseAuthHelper().signIn(email: email, password: password);

    if (status == AuthResultStatus.successful) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          HomePage.routeName, (Route<dynamic> route) => false);
    } else {
      final errorMsg = AuthExceptionHandler.generateExceptionMessage(status);
      Toast.show(
        errorMsg,
        context,
        backgroundColor: Colors.red.shade300,
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/provider/auth_provider.dart';
import 'package:restaurant_app/ui/auth/welcome_page.dart';
import 'package:restaurant_app/ui/home/home_page.dart';

class SplashPage extends StatefulWidget {
  static const routeName = '/splash';
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () async {
      FirebaseAuth.instance.authStateChanges().listen((User? user) async {
        if (user == null) {
          Navigator.of(context).pushReplacementNamed(WelcomePage.routeName);
        } else {
          await Provider.of<AuthProvider>(context, listen: false)
              .getUser(uid: user.uid);
          Navigator.of(context).pushReplacementNamed(HomePage.routeName);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/order_success.png',
              width: 150,
              height: 150,
            ),
            Text(
              'Restaurant App',
              style: blackTextStyle.copyWith(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_app/common/style.dart';
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
    Timer(Duration(seconds: 5),
        () => Navigator.of(context).pushReplacementNamed(HomePage.routeName));
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

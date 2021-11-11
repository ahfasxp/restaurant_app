import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/ui/auth/welcome_page.dart';

class ProfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(
                height: 61,
              ),
              Container(
                height: 70,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 13),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.grey,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sadek Hossen',
                          style: blackTextStyle.copyWith(fontSize: 16),
                        ),
                        Text(
                          currentUser!.email.toString(),
                          style: greyTextStyle.copyWith(fontSize: 10),
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      child: Icon(
                        Icons.notifications,
                        color: greyColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                height: 70,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 13),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Row(
                  children: [
                    Icon(Icons.person_outlined),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      'Account setting',
                      style: profileTextStyle.copyWith(fontSize: 18),
                    ),
                    Spacer(),
                    Icon(
                      Icons.edit,
                      size: 14,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 13),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.language),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          'Language',
                          style: profileTextStyle.copyWith(fontSize: 18),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.chat),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          'Feedback',
                          style: profileTextStyle.copyWith(fontSize: 18),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.star),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          'Rate us',
                          style: profileTextStyle.copyWith(fontSize: 18),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_circle_up_outlined),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          'New Version',
                          style: profileTextStyle.copyWith(fontSize: 18),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () async {
                  // Metode Signout from Firebase
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(
                      context, WelcomePage.routeName);
                },
                child: Text(
                  'Logout',
                  style: whiteTextStyle.copyWith(fontSize: 16),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(redColor),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                      side: BorderSide(color: redColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

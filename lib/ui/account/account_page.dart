import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/provider/auth_provider.dart';
import 'package:restaurant_app/ui/account/account_setting_page.dart';
import 'package:restaurant_app/ui/auth/welcome_page.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                padding: EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(11),
                ),
                child:
                    Consumer<AuthProvider>(builder: (context, provider, child) {
                  return Row(
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: Avatar(
                          name: provider.user.fullName,
                          textStyle: whiteTextStyle.copyWith(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            provider.user.fullName,
                            style: blackTextStyle.copyWith(fontSize: 16),
                          ),
                          Text(
                            provider.user.email,
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
                  );
                }),
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
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AccountSettingPage.routeName);
                  },
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
                onPressed: () {
                  // Metode Signout from Firebase
                  Provider.of<AuthProvider>(context, listen: false).signOut();
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

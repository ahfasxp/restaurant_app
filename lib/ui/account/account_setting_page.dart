import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/provider/auth_provider.dart';
import 'package:restaurant_app/ui/account/account_edit_page.dart';

class AccountSettingPage extends StatelessWidget {
  static const routeName = '/restaurant/account/setting';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                SizedBox(
                  height: 61,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 13),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Consumer<AuthProvider>(
                      builder: (context, provider, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: 90,
                            width: 90,
                            child: Avatar(
                              name: provider.user.fullName,
                              textStyle: whiteTextStyle.copyWith(fontSize: 18),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Name :',
                          style: blackTextStyle.copyWith(fontSize: 16),
                        ),
                        Text(
                          provider.user.fullName,
                          style: greyTextStyle.copyWith(fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Email :',
                          style: blackTextStyle.copyWith(fontSize: 16),
                        ),
                        Text(
                          provider.user.email,
                          style: greyTextStyle.copyWith(fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Telephone :',
                          style: blackTextStyle.copyWith(fontSize: 16),
                        ),
                        Text(
                          provider.user.telephone ?? '',
                          style: greyTextStyle.copyWith(fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Address :',
                          style: blackTextStyle.copyWith(fontSize: 16),
                        ),
                        Text(
                          provider.user.address ?? '',
                          style: greyTextStyle.copyWith(fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  }),
                ),
                SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AccountEditPage.routeName);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 13),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.edit),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          'Edit Account',
                          style: profileTextStyle.copyWith(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                GestureDetector(
                  onTap: () => showAlertDialog(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 13),
                    decoration: BoxDecoration(
                      color: redColor,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.delete),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          'Delete Account',
                          style: profileTextStyle.copyWith(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Account"),
      content: Text("This feature coming soon!"),
      actions: [
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

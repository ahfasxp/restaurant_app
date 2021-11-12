import 'package:avatars/avatars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/ui/account/account_edit_page.dart';
import 'package:restaurant_app/utils/firestore_services.dart';

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<DocumentSnapshot>(
                          future: FirestoreServices.getUser(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text("Something went wrong");
                            }

                            if (snapshot.hasData && !snapshot.data!.exists) {
                              return Text("Document does not exist");
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              Map<String, dynamic> data =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      height: 90,
                                      width: 90,
                                      child: Avatar(
                                        name: data['full_name'],
                                        textStyle: whiteTextStyle.copyWith(
                                            fontSize: 18),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Name :',
                                    style:
                                        blackTextStyle.copyWith(fontSize: 16),
                                  ),
                                  Text(
                                    data['full_name'],
                                    style: greyTextStyle.copyWith(fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Email :',
                                    style:
                                        blackTextStyle.copyWith(fontSize: 16),
                                  ),
                                  Text(
                                    data['email'],
                                    style: greyTextStyle.copyWith(fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Telephone :',
                                    style:
                                        blackTextStyle.copyWith(fontSize: 16),
                                  ),
                                  Text(
                                    data['telephone'] ?? '',
                                    style: greyTextStyle.copyWith(fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Address :',
                                    style:
                                        blackTextStyle.copyWith(fontSize: 16),
                                  ),
                                  Text(
                                    data['address'] ?? '',
                                    style: greyTextStyle.copyWith(fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              );
                            }

                            return Text("loading");
                          }),
                    ],
                  ),
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

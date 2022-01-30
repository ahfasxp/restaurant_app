import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/provider/auth_provider.dart';
import 'package:restaurant_app/widgets/toast_custom.dart';

class AccountEditPage extends StatefulWidget {
  static const routeName = '/restaurant/account/edit';
  const AccountEditPage({Key? key}) : super(key: key);

  @override
  State<AccountEditPage> createState() => _AccountEditPageState();
}

class _AccountEditPageState extends State<AccountEditPage> {
  // Inisialisasi Controller
  final _fullNameController = TextEditingController();
  final _telephonController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 120,
            ),
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
                controller: _fullNameController,
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
                  hintText: 'Enter your fullname',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 34),
              child: Text(
                'Telephon',
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
                controller: _telephonController,
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
                  hintText: 'Enter your telephon',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 34),
              child: Text(
                'Address',
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
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                minLines: 2,
                maxLines: 5,
                controller: _addressController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  fillColor: whiteColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Color(0xFF9CA3AF),
                      width: 2.0,
                    ),
                  ),
                  hintText: 'Enter your address',
                ),
              ),
            ),
            SizedBox(
              height: 34,
            ),
            Align(
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    final fullName = _fullNameController.text;
                    final telephone = _telephonController.text;
                    final address = _addressController.text;
                    await authProvider.updateUser(
                      uid: authProvider.user.uid,
                      fullName: fullName,
                      telephone: telephone,
                      address: address,
                    );
                    Navigator.pop(context);
                    Toast.show(
                      'Update Successfully',
                      context,
                      backgroundColor: Colors.red.shade300,
                    );
                  } catch (e) {
                    print(e);
                    Toast.show(
                      e.toString(),
                      context,
                      backgroundColor: Colors.red.shade300,
                    );
                  }
                },
                child: Text(
                  'Edit Account',
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
          ],
        ),
      )),
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _telephonController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}

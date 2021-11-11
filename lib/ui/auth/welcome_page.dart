import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/ui/auth/login_page.dart';
import 'package:restaurant_app/ui/auth/register_page.dart';

class WelcomePage extends StatefulWidget {
  static const routeName = '/welcome';
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  // Inisialisasi Variabel
  int selectedNavText = 0;

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      message: 'Press back again to close',
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 138,
                  ),
                  Image.asset(
                    'assets/images/order_success.png',
                    width: 280,
                    height: 224,
                  ),
                  SizedBox(
                    height: 55,
                  ),
                  Text(
                    'Welcome',
                    style: blackTextStyle.copyWith(fontSize: 24),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Before enjoying Foodmedia services\nPlease register first',
                    style: greyTextStyle.copyWith(
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 95,
                  ),
                  // NOTE: Button Show Modal Register
                  ElevatedButton(
                    onPressed: () {
                      selectedNavText = 0;
                      _showModal(context);
                    },
                    child: Text(
                      'Create Account',
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
                  SizedBox(
                    height: 16,
                  ),
                  // NOTE: Button Show Modal Login
                  ElevatedButton(
                    onPressed: () {
                      selectedNavText = 1;
                      _showModal(context);
                    },
                    child: Text(
                      'Login ',
                      style: greenTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: loginColor,
                      minimumSize: Size(256, 49),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text.rich(
                    TextSpan(
                      text:
                          'By Logging In Or Registering, You Have Agreed To ', // default text style
                      children: [
                        TextSpan(
                          text: 'The Terms And\n',
                          style: greenTextStyle,
                        ),
                        TextSpan(
                          text: 'Conditions',
                          style: greenTextStyle,
                        ),
                        TextSpan(
                          text: ' And ',
                        ),
                        TextSpan(
                          text: 'Privacy Policy.',
                          style: greenTextStyle,
                        ),
                      ],
                      style: profileTextStyle.copyWith(fontSize: 10),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showModal(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, StateSetter setModalState) {
          return Container(
            height: 576,
            padding: EdgeInsets.symmetric(
              vertical: 24,
            ),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(36),
                topRight: Radius.circular(36),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  child: Image.asset(
                    'assets/images/line.png',
                    width: 48,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // NOTE: Navigation Text
                    _navText(
                      index: 0,
                      title: 'Create Account',
                      imgLine: 'assets/images/line_create.png',
                      onPressed: () {
                        setModalState(() {
                          selectedNavText = 0;
                        });
                      },
                    ),
                    _navText(
                      index: 1,
                      title: 'Login',
                      imgLine: 'assets/images/line_login.png',
                      onPressed: () {
                        setModalState(() {
                          selectedNavText = 1;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 36,
                ),
                // NOTE: Condition Loading and Widget
                selectedNavText == 0 ? RegisterPage() : LoginPage(),
              ],
            ),
          );
        });
      },
    );
  }

  // NOTE: Widget Navigation Text
  Widget _navText(
      {required int index,
      required String title,
      required String imgLine,
      required void Function() onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Text(
            title,
            style: selectedNavText == index
                ? greenTextStyle.copyWith(fontSize: 16)
                : greyTextStyle.copyWith(fontSize: 16),
          ),
          SizedBox(
            height: 12,
          ),
          selectedNavText == index
              ? Image.asset(
                  imgLine,
                  width: index == 0 ? 77 : 28,
                )
              : SizedBox(),
        ],
      ),
    );
  }
}

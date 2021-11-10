import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/home/home_page.dart';
import 'package:restaurant_app/ui/restaurant/restaurant_detail_page.dart';
import 'package:restaurant_app/ui/auth/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(primary: greenColor),
        ),
        initialRoute: HomePage.routeName,
        routes: {
          WelcomePage.routeName: (context) => WelcomePage(),
          HomePage.routeName: (context) => HomePage(),
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
                restaurant:
                    ModalRoute.of(context)?.settings.arguments as Restaurant,
              ),
        },
      ),
    );
  }
}

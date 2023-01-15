import 'dart:convert';

import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/widgets/card_explore_restaurant.dart';

class RestaurantPage extends StatelessWidget {
  const RestaurantPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      message: 'Press back again to close',
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16,
                ),
                // NOTE: Widget Explore
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Explore Restaurant',
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Check your city Near by Restaurant',
                        style: greyTextStyle.copyWith(
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      FutureBuilder(
                        future: DefaultAssetBundle.of(context)
                            .loadString('assets/json/local_restaurant.json'),
                        builder: (context, AsyncSnapshot snapshot) {
                          final RestaurantResult restaurantResult =
                              RestaurantResult.fromJson(
                                  json.decode(snapshot.data));

                          return Column(
                            children: restaurantResult.restaurants
                                .map(
                                  (item) => CardExploreRestaurant(
                                    restaurant: item,
                                  ),
                                )
                                .toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

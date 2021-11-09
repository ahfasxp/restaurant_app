import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widgets/card_explore_restaurant.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 64,
              decoration: BoxDecoration(
                color: greenColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Center(
                child: Text(
                  'Favorites',
                  style: whiteTextStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Expanded(
              child:
                  Consumer<DatabaseProvider>(builder: (context, provider, _) {
                if (provider.state == ResultState.HasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: provider.favorites.length,
                    padding: EdgeInsets.all(18),
                    itemBuilder: (context, index) {
                      var restaurant = provider.favorites[index];
                      return CardExploreRestaurant(restaurant: restaurant);
                    },
                  );
                } else {
                  return Center(
                    child: Text(provider.message),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

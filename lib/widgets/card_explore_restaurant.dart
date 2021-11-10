import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/ui/restaurant/restaurant_detail_page.dart';

class CardExploreRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  final String pictureUrl =
      'https://restaurant-api.dicoding.dev/images/medium/';

  const CardExploreRestaurant({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, provider, _) {
      return FutureBuilder<bool>(
          future: provider.isFavorited(restaurant.id),
          builder: (context, snapshot) {
            var isFavorited = snapshot.data ?? false;
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RestaurantDetailPage.routeName);
              },
              child: Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.only(
                  bottom: 6,
                ),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        pictureUrl + restaurant.pictureId.toString(),
                        width: 64,
                        height: 64,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(restaurant.name),
                              SizedBox(
                                height: 6,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.place,
                                    color: greenColor,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        restaurant.city,
                                        style: greyTextStyle.copyWith(
                                            fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          isFavorited
                              ? IconButton(
                                  onPressed: () =>
                                      provider.removeFavorite(restaurant.id),
                                  icon: Icon(
                                    Icons.favorite,
                                    color: greenColor,
                                  ),
                                )
                              : IconButton(
                                  onPressed: () =>
                                      provider.addFavorite(restaurant),
                                  icon: Icon(
                                    Icons.favorite_outline,
                                    color: greenColor,
                                  ),
                                ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          });
    });
  }
}

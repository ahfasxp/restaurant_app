import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/ui/restaurant/restaurant_detail_page.dart';

class CardNewRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  final String pictureUrl =
      'https://restaurant-api.dicoding.dev/images/medium/';

  const CardNewRestaurant({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DetailRestaurantProvider detailRestaurantProvider =
        Provider.of<DetailRestaurantProvider>(context);

    return GestureDetector(
      onTap: () async {
        await detailRestaurantProvider.fetchDetailRestaurant(restaurant.id);
        Navigator.pushNamed(
          context,
          RestaurantDetailPage.routeName,
          arguments: restaurant,
        );
      },
      child: Container(
        width: 148,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(left: 12),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 128,
              height: 103,
              decoration: BoxDecoration(
                color: greyColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(
                    10,
                  ),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(
                    10,
                  ),
                ),
                child: Hero(
                  tag: restaurant.pictureId,
                  child: Image.network(
                    pictureUrl + restaurant.pictureId,
                    width: 128,
                    height: 103,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              restaurant.name,
              style: blackTextStyle.copyWith(fontSize: 16),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.place,
                  color: greenColor,
                  size: 16,
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    restaurant.city,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: greyTextStyle.copyWith(fontSize: 10),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

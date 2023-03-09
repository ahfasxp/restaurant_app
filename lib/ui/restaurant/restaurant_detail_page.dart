import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/model/detail_restaurant.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant/detail';
  final String pictureUrl =
      'https://restaurant-api.dicoding.dev/images/medium/';

  final Restaurant restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Details Restaurant',
          style: whiteTextStyle.copyWith(
            fontSize: 12,
          ),
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Consumer<DetailRestaurantProvider>(
            builder: (context, provider, child) {
              DetailRestaurant detailRestaurant = provider.result.restaurant;

              if (provider.state == ResultState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (provider.state == ResultState.HasData) {
                return Column(
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    detailRestaurant.name,
                                    style:
                                        blackTextStyle.copyWith(fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.place,
                                        color: greenColor,
                                        size: 16,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        detailRestaurant.city,
                                        style: greyTextStyle.copyWith(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              Icon(
                                Icons.star,
                                color: greenColor,
                              ),
                              Text(
                                detailRestaurant.rating.toString(),
                                style: blackTextStyle.copyWith(fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Hero(
                              tag: detailRestaurant.pictureId,
                              child: Image.network(
                                pictureUrl + detailRestaurant.pictureId,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Description',
                            style: blackTextStyle.copyWith(fontSize: 14),
                          ),
                          Text(
                            detailRestaurant.description,
                            style: greyTextStyle.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          _foodsMenu(detailRestaurant),
                          SizedBox(
                            height: 10,
                          ),
                          _drinksMenu(detailRestaurant),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                  ],
                );
              } else if (provider.state == ResultState.NoData) {
                return Center(child: Text(provider.message));
              } else if (provider.state == ResultState.Error) {
                return Center(child: Text(provider.message));
              } else {
                return Center(child: Text(''));
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _foodsMenu(DetailRestaurant detailRestaurant) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Text(
            'Foods Menu',
            style: blackTextStyle.copyWith(
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: detailRestaurant.menus.foods.length,
            itemBuilder: (context, index) {
              var detail = detailRestaurant.menus.foods[index];
              return Container(
                height: 40,
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  left: 8,
                ),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: greenColor),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Text(detail.name),
              );
            },
          ),
        )
      ],
    );
  }

  Widget _drinksMenu(DetailRestaurant detailRestaurant) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              'Drinks Menu',
              style: blackTextStyle.copyWith(
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: detailRestaurant.menus.drinks.length,
              itemBuilder: (context, index) {
                var detail = detailRestaurant.menus.drinks[index];
                return Container(
                  height: 40,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    left: 8,
                  ),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: greenColor),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Text(detail.name),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/restaurant/restaurant_search_page.dart';
import 'package:restaurant_app/utils/firestore_services.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widgets/card_explore_restaurant.dart';
import 'package:restaurant_app/widgets/card_new_restaurant.dart';

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
                Container(
                  padding: EdgeInsets.only(top: 32, right: 15, left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(
                        width: 16,
                      ),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['full_name'],
                                    style: blackTextStyle.copyWith(
                                      fontSize: 16,
                                      color: Color(0xFF4B5563),
                                    ),
                                  ),
                                  Text(
                                    data['email'],
                                    style: greyTextStyle.copyWith(
                                      fontSize: 12,
                                      color: Color(0xFF4B5563),
                                    ),
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
                  height: 16,
                ),
                // NOTE: Widget Search
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 47),
                  child: TextField(
                    readOnly: true,
                    onTap: () {
                      Navigator.pushNamed(
                          context, RestaurantSearchPage.routeName);
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 27),
                      filled: false,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                      prefixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {},
                      ),
                      hintText: 'Search',
                    ),
                  ),
                ),
                SizedBox(
                  height: 28,
                ),
                // NOTE: Widget New Arivable
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Today New Arivable',
                            style: blackTextStyle.copyWith(fontSize: 16),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Best of the today  food list update',
                            style: greyTextStyle.copyWith(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 196,
                      child: Consumer<RestaurantProvider>(
                        builder: (context, provider, _) {
                          if (provider.state == ResultState.Loading) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (provider.state == ResultState.HasData) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                var restaurant =
                                    provider.result.restaurants[index];
                                return CardNewRestaurant(
                                    restaurant: restaurant);
                              },
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
                  ],
                ),
                SizedBox(
                  height: 36,
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
                      Consumer<RestaurantProvider>(
                        builder: (context, provider, _) {
                          if (provider.state == ResultState.Loading) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (provider.state == ResultState.HasData) {
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: provider.result.restaurants.length,
                              itemBuilder: (context, index) {
                                var restaurant =
                                    provider.result.restaurants[index];
                                return CardExploreRestaurant(
                                    restaurant: restaurant);
                              },
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

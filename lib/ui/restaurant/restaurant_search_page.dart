import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/provider/search_restaurant_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widgets/card_explore_restaurant.dart';

class RestaurantSearchPage extends StatelessWidget {
  static const routeName = '/restaurant/search';
  const RestaurantSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child:
            Consumer<SearchRestaurantProvider>(builder: (context, provider, _) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 47, vertical: 10),
                decoration: BoxDecoration(
                  color: whiteColor,
                ),
                child: TextField(
                  onChanged: (query) {
                    provider.fetchSearchRestaurant(query);
                  },
                  autofocus: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 27),
                    fillColor: searchColor,
                    filled: true,
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
                height: 16,
              ),
              Expanded(
                child: _buildList(provider),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildList(SearchRestaurantProvider provider) {
    if (provider.state == ResultState.Loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (provider.state == ResultState.HasData) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: provider.result.restaurants.length,
        itemBuilder: (context, index) {
          var restaurant = provider.result.restaurants[index];
          return CardExploreRestaurant(restaurant: restaurant);
        },
      );
    } else if (provider.state == ResultState.NoData) {
      return Text(provider.message);
    } else if (provider.state == ResultState.Error) {
      return Text(provider.message);
    } else {
      return Text('');
    }
  }
}

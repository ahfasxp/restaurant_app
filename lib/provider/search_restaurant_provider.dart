import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/utils/result_state.dart';

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantProvider({required this.apiService});

  late RestaurantResult _restaurantResult;
  RestaurantResult get result => _restaurantResult;

  ResultState _state = ResultState.NoData;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchSearchRestaurant(String query) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurants = await apiService.searchRestaurant(query);
      if (restaurants.restaurants.isEmpty) {
        _state = ResultState.NoData;
        _message = 'Empty Data';
        notifyListeners();
      } else {
        _state = ResultState.HasData;
        _restaurantResult = restaurants;
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error --> $e';
      notifyListeners();
    }
  }
}

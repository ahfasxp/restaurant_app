import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/utils/result_state.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchListRestaurant();
  }

  late RestaurantResult _restaurantResult;
  RestaurantResult get result => _restaurantResult;

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> _fetchListRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.listRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        _message = 'Empty Data';
        notifyListeners();
      } else {
        _state = ResultState.HasData;
        _restaurantResult = restaurant;
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Maaf, kamu tidak memiliki koneksi internet';
      notifyListeners();
    }
  }
}

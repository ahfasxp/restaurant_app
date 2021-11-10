import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/detail_restaurant.dart';
import 'package:restaurant_app/utils/result_state.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  DetailRestaurantProvider({required this.apiService, required this.id}) {
    _fetchDetailRestaurant(id);
  }

  late ResultState _state;
  late DetailRestaurantResult _detailRestaurantResult;
  String _message = '';

  ResultState get state => _state;
  DetailRestaurantResult get result => _detailRestaurantResult;
  String get message => _message;

  Future<dynamic> _fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final detailRestaurant = await apiService.detailRestaurant(id);
      _state = ResultState.HasData;
      notifyListeners();
      return _detailRestaurantResult = detailRestaurant;
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}

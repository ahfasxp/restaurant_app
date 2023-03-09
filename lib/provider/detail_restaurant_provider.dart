import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/detail_restaurant.dart';
import 'package:restaurant_app/utils/result_state.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  DetailRestaurantProvider({required this.apiService});

  late DetailRestaurantResult _detailRestaurantResult;
  DetailRestaurantResult get result => _detailRestaurantResult;

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final detailRestaurant = await apiService.detailRestaurant(id);
      if (detailRestaurant.restaurant.id.isEmpty) {
        _state = ResultState.NoData;
        _message = 'Empty Data';
        notifyListeners();
      } else {
        _state = ResultState.HasData;
        _detailRestaurantResult = detailRestaurant;
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Maaf, kamu tidak memiliki koneksi internet';
      notifyListeners();
    }
  }
}

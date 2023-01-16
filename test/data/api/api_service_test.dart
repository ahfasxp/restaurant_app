import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

void main() {
  test('Should success parsing json list restaurant', () async {
    // arrange
    ApiService apiService = ApiService();
    // act
    var result = await apiService.listRestaurant();
    // assert
    expect(result, isA<RestaurantResult>());
  });
}

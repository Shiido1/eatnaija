import 'dart:async';

import 'package:eatnaija/api_connection/api_connection.dart';
import 'package:meta/meta.dart';
import 'package:eatnaija/presentation/screens/restaurant_foods/model/get_all_restaurant_food_response.dart';
import 'package:eatnaija/dao/user_dao.dart';

class AllRestaurantFoodRepository {
  final userDao = UserDao();

  Future<List<Menu>> restaurantFoodCategories(String id) async {
    // dynamic vendor = await userDao.getUser("nandom");

    // var token = vendor["token"];

    GetAllRestaurantFoodResponse uploadResponse = await getAllRestaurantFood(id
        // token
        );
    List<Menu> categories = uploadResponse.menu;
    return categories;
  }
}

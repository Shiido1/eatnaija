import 'dart:async';

import 'package:eatnaija/api_connection/api_connection.dart';
import 'package:eatnaija/presentation/screens/allrestaurants/model/all_cafe_response.dart';
import 'package:eatnaija/presentation/screens/allrestaurants/model/all_food_company_response.dart';
import 'package:eatnaija/presentation/screens/allrestaurants/model/all_food_equipment_response.dart';
import 'package:eatnaija/presentation/screens/allrestaurants/model/all_food_port_response.dart';

import 'package:eatnaija/presentation/screens/allrestaurants/model/all_restaurants_response.dart';
import 'package:eatnaija/dao/user_dao.dart';

class AllRestaurantsRepository {
  final userDao = UserDao();

  Future<List<Restaurants>> restaurantFoodCategories() async {
    // dynamic vendor = await userDao.getUser("nandom");

    // var token = vendor["token"];

    AllRestaurantsResponse response = await getAllRestaurants();
    List<Restaurants> restaurants = response.restaurants;
    return restaurants;
  }

  Future<List<FoodCompany>> getAllFoodCompanies() async {
    dynamic vendor = await userDao.getUser("nandom");

    var token = vendor["token"];

    AllFoodCompanyResponse response = await getFoodCompanies();
    List<FoodCompany> restaurants = response.foodCompany;
    return restaurants;
  }

  Future<List<FoodEquipment>> getFoodEquipmentRepo() async {
    dynamic vendor = await userDao.getUser("nandom");

    var token = vendor["token"];

    AllFoodEquipmentResponse response = await getFoodEquipment();
    List<FoodEquipment> restaurants = response.foodEquipment;
    return restaurants;
  }

  Future<List<Cafe>> getAllCafesRepo() async {
    dynamic vendor = await userDao.getUser("nandom");

    var token = vendor["token"];

    AllCafeResponse response = await getCafes();
    List<Cafe> restaurants = response.cafe;
    return restaurants;
  }

  Future<List<FoodPort>> getFoodPortRepo() async {
    dynamic vendor = await userDao.getUser("nandom");

    var token = vendor["token"];

    AllFoodPortResponse response = await getAllFoodPorts();
    List<FoodPort> restaurants = response.foodPort;
    return restaurants;
  }
}

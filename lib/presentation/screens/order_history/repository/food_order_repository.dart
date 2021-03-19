import 'dart:async';
import 'package:eatnaija/api_connection/api_connection.dart';
import 'package:eatnaija/dao/user_dao.dart';
import 'package:eatnaija/presentation/screens/order_history/model/food_order_response.dart';
import 'package:eatnaija/presentation/screens/order_history/model/request_response.dart';
import 'package:eatnaija/presentation/screens/order_history/model/order_history_response.dart';

import 'package:http/http.dart';

class FoodOrdersRepository {
  final userDao = UserDao();

  Future<List<Orderhistory>> getAllOrderedFoods() async {
    dynamic user = await userDao.getUser("nandom");

    var token = user["token"];

    OrderHistoryResponse foodOrderResponse = await orderHistoryRequest(token);
    List<Orderhistory> requests = foodOrderResponse.orderhistory;
    return requests;
  }

  Future<MyRequest> deliverFoodRequest(String foodId) async {
    dynamic user = await userDao.getUser("nandom");

    var token = user["token"];

    RequestResponse foodOrderResponse = await deliverFoodOrder(foodId,token);
    MyRequest request = foodOrderResponse.request;
    return request;
  }
}

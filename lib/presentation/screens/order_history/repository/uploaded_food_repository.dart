import 'dart:async';
import 'package:eatnaija/api_connection/api_connection.dart';
import 'package:eatnaija/dao/user_dao.dart';

import 'package:eatnaija/presentation/screens/order_history/model/get_uploaded_food_response.dart';
import 'package:meta/meta.dart';

class AllFoodRepository {
  final userDao = UserDao();

  Future<List<Data>> uploadedFood() async {
    dynamic vendor = await userDao.getUser("nandom");

    var token = vendor["token"];

    GetUploadedFoodResponse uploadResponse = await allUploadedFoods(token);
    List<Data> sales = uploadResponse.data;
    return sales;
  }

  Future<void> delteToken({@required String id}) async {
    await userDao.deleteUser();
  }

  Future<bool> hasToken() async {
    bool result = await userDao.checkUser("nandom");
    return result;
  }
}

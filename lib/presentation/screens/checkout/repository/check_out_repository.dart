import 'dart:async';

import 'package:eatnaija/api_connection/api_connection.dart';
import 'package:eatnaija/presentation/screens/cart/model/cart_items_response.dart';
import 'package:eatnaija/presentation/screens/cart/model/delete_cart_item_response.dart';
import 'package:eatnaija/presentation/screens/cart/model/manage_cart_response.dart';
import 'package:eatnaija/presentation/screens/checkout/model/update_profile_request.dart';
import 'package:eatnaija/presentation/screens/checkout/model/update_user_response.dart';
import 'package:eatnaija/presentation/screens/food_detail/model/cart_response.dart';
import 'package:eatnaija/presentation/screens/checkout/model/checkout_request.dart';
import 'package:eatnaija/presentation/screens/checkout/model/checkout_response.dart';


import 'package:eatnaija/dao/user_dao.dart';
import 'package:eatnaija/presentation/screens/login/models/user.dart';

class CheckOutRepository {
  final userDao = UserDao();

  Future<CheckoutResponse> checkoutRepo({String address, String total}) async {
    dynamic vendor = await userDao.getUser("nandom");

    var token = vendor["token"];
    var userId = vendor["id"];
    var city = vendor["city"];

    CheckoutRequest updateProfileRequest = CheckoutRequest(
        total: total,
        phone: vendor["phone"],
        city: city ?? 'Abuja',
        address: address,
        state: vendor["state"] == null ? "Abuja" : vendor["state"]);

    CheckoutResponse uploadResponse =
        await checkoutRequest(updateProfileRequest, token);


    return uploadResponse;
  }

  Future<ManageCartResponse> addToCartRepo({String id}) async {
    dynamic vendor = await userDao.getUser("nandom");

    var token = vendor["token"];

    ManageCartResponse cartResponse = await addToCartRequest(id, token);
    return cartResponse;
  }
}

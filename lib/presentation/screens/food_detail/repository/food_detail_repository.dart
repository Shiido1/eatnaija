import 'dart:async';

import 'package:eatnaija/api_connection/api_connection.dart';
import 'package:eatnaija/presentation/screens/cart/model/manage_cart_response.dart';
import 'package:eatnaija/presentation/screens/login/models/user.dart';
import 'package:meta/meta.dart';
import 'package:eatnaija/presentation/screens/restaurant_foods/model/get_all_restaurant_food_response.dart';
import 'package:eatnaija/dao/user_dao.dart';
import 'package:eatnaija/presentation/screens/food_detail/model/cart_response.dart';

class FoodDetailRepository {
  final userDao = UserDao();

  Future<ManageCartResponse> addToCartRepo(String id) async {
    dynamic vendor = await userDao.getUser("nandom");
    var token = vendor["token"];
    ManageCartResponse cartResponse = await addToCartRequest(id, token);

    await updateCart(vendor, cartResponse.items);

    return cartResponse;
  }

  Future<void> updateCart(dynamic vendor, int cartItems) async{

    User myUser = User();

    myUser.id = vendor["id"];
    myUser.name = vendor["name"];
    myUser.email = vendor["email"];
    myUser.emailVerifiedAt = vendor["email_verified_at"];
    myUser.twoFactorSecret = vendor["two_factor_secret"];
    myUser.twoFactorRecoveryCodes = vendor["two_factor_recovery_codes"];
    myUser.currentTeamId = vendor["current_team_id"];
    myUser.image = vendor["image"];
    myUser.createdAt = vendor["created_at"];
    myUser.updatedAt = vendor["updated_at"];
    myUser.phone = vendor["phone"];
    myUser.address = vendor["address"];
    myUser.otp = vendor["otp"];
    myUser.city = vendor["city"];
    myUser.state = vendor["state"];
    myUser.token = vendor["token"];
    myUser.cart = cartItems;

    await userDao.deleteUser();
    //
    int intresult = await userDao.createUser(myUser);

    print(myUser.cart);
  }

}

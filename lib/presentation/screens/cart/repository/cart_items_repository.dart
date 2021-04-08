import 'dart:async';

import 'package:eatnaija/common/globals.dart' as globals;
import 'package:eatnaija/api_connection/api_connection.dart';
import 'package:eatnaija/presentation/screens/cart/model/cart_item_model.dart';
import 'package:eatnaija/presentation/screens/cart/model/cart_items_response.dart';
import 'package:eatnaija/presentation/screens/cart/model/delete_cart_item_response.dart';
import 'package:eatnaija/presentation/screens/cart/model/manage_cart_response.dart';
import 'package:eatnaija/presentation/screens/food_detail/model/cart_response.dart';

import 'package:eatnaija/dao/user_dao.dart';
import 'package:eatnaija/presentation/screens/login/models/user.dart';
import 'package:get_it/get_it.dart';

class AllCartItemsRepository {
  final userDao = UserDao();

  Future<List<AllCart>> getCartItems() async {
    dynamic vendor = await userDao.getUser("nandom");

    var token = vendor["token"];

    CartItemsResponse uploadResponse = await getAllCartItems(token);
    List<AllCart> cartItems = uploadResponse.cart;
    return cartItems;
  }
  List<Map<String,dynamic>> getCartItemNew(){
    return GetIt.I<CartItemsModel>().getCartItems();
  }

  Future<ManageCartResponse> addToCartRepo({String id}) async {
    dynamic vendor = await userDao.getUser("nandom");

    var token = vendor["token"];
    var userId = vendor["id"];

    ManageCartResponse cartResponse = await addToCartRequest(id, token);

    await updateCart(vendor, cartResponse.items, false);

    return cartResponse;
  }

  Future<DeleteCartItemResponse> deleteFromCartRepo({String id}) async {
    dynamic vendor = await userDao.getUser("nandom");

    var token = vendor["token"];

    DeleteCartItemResponse deleteResponse =
        await deleteFromCartRequest(id, token);

    await updateCart(vendor, 0, true);

    return deleteResponse;
  }

  Future<ManageCartResponse> subtractFromCartRepo({String id}) async {
    dynamic vendor = await userDao.getUser("nandom");

    var token = vendor["token"];

    ManageCartResponse cartResponse = await subtractFromCartRequest(id, token);

    await updateCart(vendor, cartResponse.items, false);
    return cartResponse;
  }

  Future<void> updateCart(dynamic vendor, int cartItems, bool isDelete) async {
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
    myUser.cart = !isDelete ? cartItems : vendor["cart"] - 1;

    await userDao.deleteUser();

    //
    int intresult = await userDao.createUser(myUser);

    print(myUser.cart);
  }
}

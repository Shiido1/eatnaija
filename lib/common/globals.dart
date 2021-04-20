library eatnaja.globals;

import 'dart:async';

import 'package:eatnaija/dao/user_dao.dart';
import 'package:eatnaija/presentation/screens/food_detail/bloc/add_to_cart_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:get_it/get_it.dart';

import 'package:eatnaija/presentation/screens/cart/model/cart_item_model.dart';

int cartCount = 0;

UserDao userDao = UserDao();


Stream<int> numbersStream() async* {
  var user = await userDao.getUser("nandom");

  // int cartItems = user["cart"] != null ? user["cart"] : 0;
  int cartItems = user != null ? user["cart"] : 0;

  yield cartItems;

}
Stream<int> cartItemNumbers() async* {

  // int cartItems = user["cart"] != null ? user["cart"] : 0;
  int cartItems = GetIt.I<CartItemsModel>().getCartItemsNumber();

  yield cartItems;

}
// final cartItemNumbers = streamController.stream;


final StreamController<int> streamController = StreamController<int>.broadcast();
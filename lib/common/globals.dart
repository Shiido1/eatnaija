library eatnaja.globals;

import 'dart:async';

import 'package:eatnaija/dao/user_dao.dart';

int cartCount = 0;

UserDao userDao = UserDao();


Stream<int> numbersStream() async* {
  var user = await userDao.getUser("nandom");

  int cartItems = user["cart"] != null ? user["cart"] : 0;

  yield cartItems;

}


final StreamController streamController = StreamController();
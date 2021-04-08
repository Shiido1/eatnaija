import 'package:eatnaija/presentation/screens/cart/model/cart_item_model.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setUp(){
  getIt.registerSingleton<CartItemsModel>(CartItemsModel());
}
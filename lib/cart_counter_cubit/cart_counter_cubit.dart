
import 'package:eatnaija/common/globals.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:cubit/cubit.dart';

part 'cart_counter_state.dart';

class CartCounterCubit extends Cubit<CartCounterState> {

  CartCounterCubit() : super(CartCounterState(cartCount: 0));

  void setCartCount(int cartCount) => emit(
      CartCounterState(cartCount: cartCount));


}

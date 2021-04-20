// import 'package:eatnaija/presentation/screens/cart/model/cart_model.dart';
import 'package:eatnaija/presentation/screens/cart/model/cart_item_model.dart';
import 'package:eatnaija/presentation/screens/cart/model/manage_cart_response.dart';
import 'package:eatnaija/presentation/screens/food_detail/repository/food_detail_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:eatnaija/presentation/screens/food_detail/model/cart_response.dart';
import 'package:cubit/cubit.dart';
import 'package:eatnaija/presentation/screens/restaurant_foods/model/get_all_restaurant_food_response.dart';
import 'package:get_it/get_it.dart';

part 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  FoodDetailRepository foodDetailRepository = FoodDetailRepository();
  CartItemsModel appCart = GetIt.I<CartItemsModel>();

  // final String id;
  String id = "-1";

  AddToCartCubit({this.id}) : super(AddToCartInitialState());

  void addMenuToCart(Map<String,dynamic> menu) async {

    try {
      emit(AddToCartLoadingState());
      // print("I got here menu: $menu");
      appCart.updateCartItems(menu);
      emit(AddToCartSuccessState());
      // print("success emitted");
    } catch (error) {
      emit(AddToCartFailedState(error: error.toString()));
    }
  }
  CartItemsModel getCartItems(){
    return appCart;
  }
  void addToCart() async {
    try {
      emit(AddToCartLoadingState());
      final cart = await foodDetailRepository.addToCartRepo(id);
      emit(AddToCartSuccessState(cart: cart));
    } catch (error) {
      emit(AddToCartFailedState(error: error.toString()));
    }
  }

}

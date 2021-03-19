import 'package:eatnaija/presentation/screens/cart/model/manage_cart_response.dart';
import 'package:eatnaija/presentation/screens/food_detail/repository/food_detail_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:eatnaija/presentation/screens/food_detail/model/cart_response.dart';
import 'package:cubit/cubit.dart';

part 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  FoodDetailRepository foodDetailRepository = FoodDetailRepository();

  final String id;

  AddToCartCubit({this.id}) : super(AddToCartInitialState());

  void addToCart() async {
    try {
      emit(AddToCartLoadingState());
      final cart = await foodDetailRepository.addToCartRepo(id);
      emit(AddToCartSuccessState(cart: cart));
    } catch (error) {
      emit(AddToCartFailedState(error: error));
    }
  }
}

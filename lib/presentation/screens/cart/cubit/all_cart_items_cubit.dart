import 'package:bloc/bloc.dart';
import 'package:eatnaija/presentation/screens/cart/model/cart_items_response.dart';
import 'package:eatnaija/presentation/screens/cart/model/delete_cart_item_response.dart';
import 'package:eatnaija/presentation/screens/cart/model/manage_cart_response.dart';
import 'package:eatnaija/presentation/screens/food_detail/model/cart_response.dart';
import 'package:eatnaija/presentation/screens/cart/repository/cart_items_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:cubit/cubit.dart';

part 'all_cart_items_state.dart';


class AllCartItemsCubit extends Cubit<AllCartItemsState> {

  AllCartItemsRepository allCartItemsRepository = AllCartItemsRepository();

  AllCartItemsCubit() : super(AllCartItemsInitialState()) {
    getAllCartItems();
  }


  void getAllCartItems() async {
    try {
      emit(AllCartItemsLoadingState());
      final cartItems =
      await allCartItemsRepository.getCartItems();
      emit(AllCartItemsSuccessState(cartItems: cartItems));
    } catch (error) {
      emit(AllCartItemsFailureState(error: error.toString()));
    }
  }
  void addToCartCartItems(String id) async {
    try {
      emit(ManageCartLoading());
      final cartItems =
      await allCartItemsRepository.addToCartRepo(id: id);
      emit(AddToCartItemsSuccess(cartResponse: cartItems));
    } catch (error) {
      emit(AddToCartItemsFailure(error: error));
    }
  }

  void subtractFromCartItems(String id) async {
    try {
      emit(ManageCartLoading());
      final cartItems =
      await allCartItemsRepository.subtractFromCartRepo(id: id);
      emit(SubtractFromCartItemsSuccess(cartResponse: cartItems));
    } catch (error) {
      emit(SubtractFromCartItemsFailure(error: error));
    }
  }
  void deleteFromCartItems(String id) async {
    try {
      emit(ManageCartLoading());
      final deleteResponse =
      await allCartItemsRepository.deleteFromCartRepo(id: id);
      emit(DeleteFromCartItemsSuccess(deleteResponse: deleteResponse, itemId: id));
    } catch (error) {
      emit(DeleteFromCartItemsFailure(error: error));
    }
  }
}

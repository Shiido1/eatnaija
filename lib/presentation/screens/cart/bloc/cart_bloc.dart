import 'package:eatnaija/presentation/screens/cart/model/cart_item_model.dart';
import 'package:eatnaija/presentation/screens/food_detail/bloc/add_to_cart_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, AddToCartState>{
  final CartItemsModel cartItemsModel;
  CartBloc({this.cartItemsModel});


  @override
  AddToCartState get initialState => AddToCartInitialState();

  @override
  Stream<AddToCartState> mapEventToState(CartEvent event) async* {
    // TODO: implement mapEventToState
    if(event is ItemAdded){
      yield AddToCartLoadingState();
      yield AddToCartSuccessState();
    }

    if(event is ItemAdditionFailed){
      yield AddToCartFailedState();
    }
  }}

abstract class CartEvent extends Equatable{
  const CartEvent();

  @override
  List<Object> get props => [];
}
class ItemAdded extends CartEvent{}

class ItemAdditionFailed extends CartEvent{}
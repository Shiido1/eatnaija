part of 'add_to_cart_cubit.dart';

abstract class AddToCartState extends Equatable {
  const AddToCartState();

  @override
  List<Object> get props => [];
}

class AddToCartInitialState extends AddToCartState {}

class AddToCartLoadingState extends AddToCartState {}

class AddToCartFailedState extends AddToCartState {
  final String error;

  AddToCartFailedState({this.error});

  @override
  List<Object> get props => [error];
}

class AddToCartSuccessState extends AddToCartState {
  final ManageCartResponse cart;

  AddToCartSuccessState({this.cart});

  @override
  List<Object> get props => [cart];
}

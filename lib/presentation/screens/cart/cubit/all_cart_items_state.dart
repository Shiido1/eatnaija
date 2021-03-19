part of 'all_cart_items_cubit.dart';

abstract class AllCartItemsState extends Equatable {
  const AllCartItemsState();

  @override
  List<Object> get props => [];
}

class AllCartItemsInitialState extends AllCartItemsState {}

class AllCartItemsLoadingState extends AllCartItemsState {}

class AddToCartItemsSuccess extends AllCartItemsState {
  final ManageCartResponse cartResponse;

  AddToCartItemsSuccess({this.cartResponse});

  @override
  List<Object> get props => [cartResponse];
}

class AddToCartItemsFailure extends AllCartItemsState {
  final String error;

  AddToCartItemsFailure({this.error});

  @override
  List<Object> get props => [error];
}

class SubtractFromCartItemsSuccess extends AllCartItemsState {
  final ManageCartResponse cartResponse;

  SubtractFromCartItemsSuccess({this.cartResponse});

  @override
  List<Object> get props => [cartResponse];
}

class SubtractFromCartItemsFailure extends AllCartItemsState {
  final String error;

  SubtractFromCartItemsFailure({this.error});

  @override
  List<Object> get props => [error];
}
class DeleteFromCartItemsSuccess extends AllCartItemsState {
  final DeleteCartItemResponse deleteResponse;
  final String itemId;

  DeleteFromCartItemsSuccess({this.deleteResponse, this.itemId});

  @override
  List<Object> get props => [deleteResponse];
}

class DeleteFromCartItemsFailure extends AllCartItemsState {
  final String error;

  DeleteFromCartItemsFailure({this.error});

  @override
  List<Object> get props => [error];
}

class ManageCartLoading extends AllCartItemsState {}

class AllCartItemsSuccessState extends AllCartItemsState {
  final List<AllCart> cartItems;

  AllCartItemsSuccessState({this.cartItems});

  @override
  List<Object> get props => [cartItems];
}

class AllCartItemsFailureState extends AllCartItemsState {
  final String error;

  AllCartItemsFailureState({this.error});

  @override
  List<Object> get props => [error];
}

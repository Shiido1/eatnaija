part of 'food_order_bloc.dart';

abstract class FoodOrderState extends Equatable {
  const FoodOrderState();
  @override
  List<Object> get props => [];
}

class FoodOrderInitialState extends FoodOrderState {}

class FoodOrderLoadingState extends FoodOrderState {}

class FoodOrderFailureState extends FoodOrderState {
  final String error;

  FoodOrderFailureState({this.error});

  @override
  List<Object> get props => [error];
}

class FoodOrderSuccessState extends FoodOrderState {
  final List<Orderhistory> orderHistory;

  FoodOrderSuccessState({this.orderHistory}) : assert(orderHistory != null);

  @override
  List<Object> get props => [orderHistory];
}

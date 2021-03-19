part of 'new_food_order_bloc.dart';

abstract class NewFoodOrderState extends Equatable {
  const NewFoodOrderState();

  @override
  List<Object> get props => [];
}

class NewFoodOrderInitialState extends NewFoodOrderState {}

class NewFoodOrderSuccessState extends NewFoodOrderState {
  final Orderhistory orderhistory;

  NewFoodOrderSuccessState({this.orderhistory});

  @override
  List<Object> get props => [orderhistory];
}
class NewFoodOrderFailureState extends NewFoodOrderState {
  final String error;

  NewFoodOrderFailureState({this.error});

  @override
  List<Object> get props => [error];
}

class AcceptFoodOrderSuccessState extends NewFoodOrderState {
  final MyRequest request;

  AcceptFoodOrderSuccessState({this.request});

  @override
  List<Object> get props => [request];
}

class AcceptFoodOrderFailureState extends NewFoodOrderState {
  final String error;

  AcceptFoodOrderFailureState({this.error});

  @override
  List<Object> get props => [error];
}

class AcceptFoodOrderLoadingState extends NewFoodOrderState {}

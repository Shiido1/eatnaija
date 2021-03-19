part of 'food_order_bloc.dart';

abstract class FoodOrderEvent extends Equatable {
  const FoodOrderEvent();
}

class FetchAllFoodRequestsEvent extends FoodOrderEvent {

  const FetchAllFoodRequestsEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoginButtonPressed { token: }';
}

class ReFetchAllFoodRequestsEvent extends FoodOrderEvent {

  const ReFetchAllFoodRequestsEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'ReFetchAllFoodRequestsEvent { token: }';
}

class RejectFoodRequestsEvent extends FoodOrderEvent {

  const RejectFoodRequestsEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoginButtonPressed { token: }';
}

class DeliverFoodRequestsEvent extends FoodOrderEvent {

  const DeliverFoodRequestsEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoginButtonPressed { token: }';
}

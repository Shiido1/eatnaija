part of 'new_food_order_bloc.dart';

abstract class NewFoodOrderEvent extends Equatable {
  const NewFoodOrderEvent();
}

class AcceptFoodRequestsEvent extends NewFoodOrderEvent {

  final int foodId;

  const AcceptFoodRequestsEvent({this.foodId});

  @override
  List<Object> get props => [foodId];

  @override
  String toString() {
    return 'AcceptFoodRequestsEvent{foodId: $foodId}';
  }
}


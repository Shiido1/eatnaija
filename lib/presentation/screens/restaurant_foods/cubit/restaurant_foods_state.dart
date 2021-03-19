part of 'restaurant_foods_cubit.dart';

abstract class RestaurantFoodsState extends Equatable {
  const RestaurantFoodsState();

  @override
  List<Object> get props => [];
}

class RestaurantFoodsInitialState extends RestaurantFoodsState {
  @override
  List<Object> get props => [];
}

class RestaurantFoodLoadingState extends RestaurantFoodsState {
  final String industryType;

  RestaurantFoodLoadingState({this.industryType});

  @override
  List<Object> get props => [industryType];
}

class RestaurantFoodSuccessState extends RestaurantFoodsState {
  final List<Menu> foodlist;

  RestaurantFoodSuccessState({this.foodlist});

  @override
  List<Object> get props => [foodlist];
}

class RestaurantFoodFailureState extends RestaurantFoodsState {
  final String error;

  RestaurantFoodFailureState({this.error});

  @override
  List<Object> get props => [error];
}

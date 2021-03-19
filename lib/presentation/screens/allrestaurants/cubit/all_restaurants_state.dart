part of 'all_restaurants_cubit.dart';

abstract class AllRestaurantsState extends Equatable {
  const AllRestaurantsState();
  @override
  List<Object> get props => [];
}

class AllRestaurantsInitialState extends AllRestaurantsState {}
class AllRestaurantsLoadingState extends AllRestaurantsState {}
class AllRestaurantsSuccessState extends AllRestaurantsState {
  final List<Restaurants> restaurants;

  AllRestaurantsSuccessState({this.restaurants});

  @override
  List<Object> get props => [restaurants];
}
class AllFoodPortSuccessState extends AllRestaurantsState {
  final List<FoodPort> foodPort;

  AllFoodPortSuccessState({this.foodPort});

  @override
  List<Object> get props => [foodPort];
}

class AllCafeSuccessState extends AllRestaurantsState {
  final List<Cafe> cafes;

  AllCafeSuccessState({this.cafes});

  @override
  List<Object> get props => [cafes];
}

class AllFoodCompanySuccessState extends AllRestaurantsState {
  final List<FoodCompany> foodCompany;

  AllFoodCompanySuccessState({this.foodCompany});

  @override
  List<Object> get props => [foodCompany];
}

class AllFoodEquipmentSuccess extends AllRestaurantsState {
  final List<FoodEquipment> foodEquipment;

  AllFoodEquipmentSuccess({this.foodEquipment});

  @override
  List<Object> get props => [foodEquipment];
}

class AllRestaurantsFailureState extends AllRestaurantsState {
  final String error;

  AllRestaurantsFailureState({this.error});

  @override
  List<Object> get props => [error];
}



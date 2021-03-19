import 'package:bloc/bloc.dart';
import 'package:eatnaija/presentation/screens/restaurant_foods/repository/all_restaurant_food_repository.dart';
import 'package:eatnaija/presentation/screens/restaurant_foods/repository/all_restaurant_food_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:cubit/cubit.dart';

import 'package:eatnaija/presentation/screens/restaurant_foods/model/get_all_restaurant_food_response.dart';

part 'restaurant_foods_state.dart';

class RestaurantFoodsCubit extends Cubit<RestaurantFoodsState> {
  AllRestaurantFoodRepository allRestaurantsRepository =
      AllRestaurantFoodRepository();
  final String id;

  RestaurantFoodsCubit({this.id}) : super(RestaurantFoodsInitialState()) {
    getAllCategories(id);
  }

  void getAllCategories(String id) async {
    try {
      emit(RestaurantFoodLoadingState());
      final foodList =
          await allRestaurantsRepository.restaurantFoodCategories(id);
      emit(RestaurantFoodSuccessState(foodlist: foodList));
    } catch (error) {
      emit(RestaurantFoodFailureState(error: error));
    }
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eatnaija/presentation/screens/order_history/model/food_order_response.dart';
import 'package:eatnaija/presentation/screens/order_history/repository/food_order_repository.dart';
import 'package:eatnaija/presentation/screens/order_history/model/order_history_response.dart';

import 'package:equatable/equatable.dart';


part 'food_order_event.dart';
part 'food_order_state.dart';

class FoodOrderBloc extends Bloc<FoodOrderEvent, FoodOrderState> {
  FoodOrderBloc() : super();
  FoodOrdersRepository foodOrdersRepository = FoodOrdersRepository();

  @override
  Stream<FoodOrderState> mapEventToState(
    FoodOrderEvent event,
  ) async* {
    if(event is FetchAllFoodRequestsEvent){
      // yield FoodOrderLoadingState();
      try {
        final foodRequests = await foodOrdersRepository.getAllOrderedFoods();

        yield FoodOrderSuccessState(orderHistory: foodRequests);
      }catch(error){
        yield FoodOrderFailureState(error: error);
      }
    }

  if(event is ReFetchAllFoodRequestsEvent){
      yield FoodOrderLoadingState();
      try {
        final foodRequests = await foodOrdersRepository.getAllOrderedFoods();

        yield FoodOrderSuccessState(orderHistory: foodRequests);
      }catch(error){
        yield FoodOrderFailureState(error: error);
      }
    }
  }

  @override
  // TODO: implement initialState
  FoodOrderState get initialState => FoodOrderLoadingState();
}

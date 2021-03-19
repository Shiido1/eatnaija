import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eatnaija/presentation/screens/order_history/model/request_response.dart';
import 'package:eatnaija/presentation/screens/order_history/repository/food_order_repository.dart';
import 'package:eatnaija/presentation/screens/order_history/model/order_history_response.dart';

import 'package:equatable/equatable.dart';

part 'new_food_order_event.dart';
part 'new_food_order_state.dart';

class NewFoodOrderBloc extends Bloc<NewFoodOrderEvent, NewFoodOrderState> {

  final FoodOrdersRepository foodOrdersRepository;

  NewFoodOrderBloc({this.foodOrdersRepository}) : super();

  @override
  Stream<NewFoodOrderState> mapEventToState(
    NewFoodOrderEvent event,
  ) async* {
    if(event is AcceptFoodRequestsEvent){
      yield AcceptFoodOrderLoadingState();
      try {
        // final foodRequests = await foodOrdersRepository.acceptFoodRequest(event.foodId.toString());

        // yield AcceptFoodOrderSuccessState(request: foodRequests);
      }catch(error){
        yield AcceptFoodOrderFailureState(error: error);
      }
    }  }

  @override
  // TODO: implement initialState
  NewFoodOrderState get initialState => NewFoodOrderInitialState();
}

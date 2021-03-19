import 'package:bloc/bloc.dart';
import 'package:eatnaija/presentation/screens/allrestaurants/model/all_cafe_response.dart';
import 'package:eatnaija/presentation/screens/allrestaurants/model/all_food_company_response.dart';
import 'package:eatnaija/presentation/screens/allrestaurants/model/all_food_equipment_response.dart';
import 'package:eatnaija/presentation/screens/allrestaurants/model/all_food_port_response.dart';
import 'package:eatnaija/presentation/screens/allrestaurants/repository/all_restaurants_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:cubit/cubit.dart';
import 'package:eatnaija/presentation/screens/allrestaurants/model/all_restaurants_response.dart';


part 'all_restaurants_state.dart';

class AllRestaurantsCubit extends Cubit<AllRestaurantsState> {
  AllRestaurantsRepository allRestaurantsRepository =
      AllRestaurantsRepository();

  final int type;

  AllRestaurantsCubit({this.type}) : super(AllRestaurantsInitialState()) {
    getAllCategories();
  }

  void getAllCategories() async {
    try {
      emit(AllRestaurantsLoadingState());
      switch (type) {
        case 1:
          {
            final restaurants =
                await allRestaurantsRepository.restaurantFoodCategories();
            emit(AllRestaurantsSuccessState(restaurants: restaurants));
          }
          break;
        case 2:
          {
            final foodports = await allRestaurantsRepository.getFoodPortRepo();
            emit(AllFoodPortSuccessState(foodPort: foodports));

          }
          break;
        case 3:
          {
            final cafes = await allRestaurantsRepository.getAllCafesRepo();
            emit(AllCafeSuccessState(cafes: cafes));
          }
          break;
        case 4:
          {
            final cafes = await allRestaurantsRepository.getAllCafesRepo();
            emit(AllCafeSuccessState(cafes: cafes));
          }
          break;
        case 5:
          {
            final foodCompanies = await allRestaurantsRepository.getAllFoodCompanies();
            emit(AllFoodCompanySuccessState(foodCompany: foodCompanies));
          }
          break;
        default:
          {

            final foodEquipment = await allRestaurantsRepository.getFoodEquipmentRepo();
            emit(AllFoodEquipmentSuccess(foodEquipment: foodEquipment));
          }
          break;
      }
    } catch (error) {
      emit(AllRestaurantsFailureState(error: error));
    }
  }
}

import 'package:eatnaija/presentation/screens/checkout/repository/check_out_repository.dart';
import 'package:eatnaija/presentation/screens/login/models/user.dart';
import 'package:eatnaija/repository/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:cubit/cubit.dart';
import 'package:eatnaija/presentation/screens/checkout/model/checkout_request.dart';
import 'package:eatnaija/presentation/screens/checkout/model/checkout_response.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckOutRepository checkOutRepository = CheckOutRepository();
  UserRepository userRepository = UserRepository();

  CheckoutCubit() : super(CheckoutInitialState());

  void getCheckOut(String address, total) async {
    try {
      emit(CheckoutLoadingState());
      final checkoutResponse =
          await checkOutRepository.checkoutRepo(address: address, total: total);

      emit(CheckoutSuccessState(checkoutResponse: checkoutResponse));
    } catch (error) {
      emit(CheckoutFailedState(error: error.toString()));
    }
  }
}

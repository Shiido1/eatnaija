import 'package:bloc/bloc.dart';
import 'package:eatnaija/presentation/screens/login/models/user.dart';
import 'package:eatnaija/repository/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:cubit/cubit.dart';

part 'update_address_state.dart';

class UpdateAddressCubit extends Cubit<UpdateAddressState> {
  UserRepository userRepository = UserRepository();

  UpdateAddressCubit() : super(UpdateAddressInitialState());

  void updateAddress(String address, String phone) async {
    try {
      emit(UpdateAddressLoadingState());
      final user = await userRepository.updateUserInfo(address: address, phone: phone);

      emit(UpdateAddressSuccessState(user: user));
    } catch (error) {
      emit(UpdateAddressFailureState(error: error.toString()));
    }
  }
}

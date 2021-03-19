import 'package:bloc/bloc.dart';
import 'package:eatnaija/presentation/screens/login/models/user.dart';
import 'package:eatnaija/repository/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:cubit/cubit.dart';

part 'personal_information_state.dart';

class PersonalInformationCubit extends Cubit<PersonalInformationState> {
  UserRepository userRepository = UserRepository();

  PersonalInformationCubit() : super(PersonalInformationInitial());

  void updateUserProfileInformation({String address, String image, String city,
      String state, String phone}) async {
    try {
      emit(PersonalInformationLoadingState());
      final checkoutResponse = await userRepository.updateUserProfile(
          address: address,
          phone: phone,
          city: city,
          state: state,
          image: image);

      emit(PersonalInformationSuccessState(user: checkoutResponse));
    } catch (error) {
      emit(PersonalInformationFailureState(error: error.toString()));
    }
  }
}

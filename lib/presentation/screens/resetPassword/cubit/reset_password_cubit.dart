import 'package:bloc/bloc.dart';
import 'package:eatnaija/presentation/screens/resetPassword/repository/reset_password_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:eatnaija/presentation/screens/resetPassword/model/reset_password_request.dart';
import 'package:eatnaija/presentation/screens/resetPassword/model/reset_password_response.dart';
import 'package:cubit/cubit.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordRepository resetPasswordRepository = ResetPasswordRepository();

  ResetPasswordCubit() : super(ResetPasswordInitialState());

  void getAllCategories({String email}) async {
    try {
      emit(ResetPasswordLoadingState());
      final resetPasswordResponse =
          await resetPasswordRepository.resetPasswordRepo(email: email);
      emit(ResetPasswordSuccessState(
          resetPasswordResponse: resetPasswordResponse));
    } catch (error) {
      emit(ResetPasswordFailureState(error: error));
    }
  }
}

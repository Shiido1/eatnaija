part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterCompleteState extends RegisterState {
  final RegisterResponse registerResponse;

  RegisterCompleteState(this.registerResponse);

  @override
  List<Object> get props => [registerResponse];
}

class RegisterFailureState extends RegisterState {
  final String error;

  RegisterFailureState({this.error});

  @override
  List<Object> get props => [error];
}

part of 'update_address_cubit.dart';

abstract class UpdateAddressState extends Equatable {
  const UpdateAddressState();

  @override
  List<Object> get props => [];
}

class UpdateAddressInitialState extends UpdateAddressState {}

class UpdateAddressLoadingState extends UpdateAddressState {}

class UpdateAddressSuccessState extends UpdateAddressState {
  final User user;

  UpdateAddressSuccessState({this.user});

  @override
  List<Object> get props => [user];
}

class UpdateAddressFailureState extends UpdateAddressState {
  final String error;

  UpdateAddressFailureState({this.error});

  @override
  List<Object> get props => [error];
}

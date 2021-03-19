part of 'checkout_cubit.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object> get props => [];
}

class CheckoutInitialState extends CheckoutState {}

class CheckoutLoadingState extends CheckoutState {}

class ChangeAddressSuccessState extends CheckoutState {}

class ChangeAddressFailedState extends CheckoutState {}

class CheckoutSuccessState extends CheckoutState {
  final CheckoutResponse checkoutResponse;

  CheckoutSuccessState({this.checkoutResponse});

  @override
  List<Object> get props => [checkoutResponse];
}

class CheckoutFailedState extends CheckoutState {
  final dynamic error;

  CheckoutFailedState({this.error});

  @override
  List<Object> get props => [error];
}

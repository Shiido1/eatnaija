part of 'personal_information_cubit.dart';

abstract class PersonalInformationState extends Equatable {
  const PersonalInformationState();

  @override
  List<Object> get props => [];
}

class PersonalInformationInitial extends PersonalInformationState {}

class PersonalInformationLoadingState extends PersonalInformationState {}

class PersonalInformationSuccessState extends PersonalInformationState {
  final User user;

  PersonalInformationSuccessState({this.user});

  @override
  List<Object> get props => [user];
}

class PersonalInformationFailureState extends PersonalInformationState {
  final String error;

  PersonalInformationFailureState({this.error});

  @override
  List<Object> get props => [error];
}

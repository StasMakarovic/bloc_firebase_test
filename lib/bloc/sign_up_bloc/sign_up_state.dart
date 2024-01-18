part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpState {}

sealed class SignUpActionState extends SignUpState {}

////////////////

final class SignUpLoadingState extends SignUpState {}

final class SignUpInitialState extends SignUpState {}

//////

final class SuccessfulSignUpState extends SignUpActionState {}

final class NavigateToSignInState extends SignUpActionState {}

final class ShowSnackBarState extends SignUpActionState {
  final String errorMessage;

  ShowSnackBarState(this.errorMessage);
}

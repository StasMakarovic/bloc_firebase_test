part of 'sign_in_bloc.dart';

@immutable
sealed class SignInState {}

sealed class SignInActionState extends SignInState {}

////////////////

final class SignInLoadingState extends SignInState {}

final class SignInInitialState extends SignInState {}

//////

final class SuccessfulSignInState extends SignInActionState {}

final class ShowSnackBarSignInState extends SignInActionState {
  final String errorMessage;

  ShowSnackBarSignInState(this.errorMessage);
}

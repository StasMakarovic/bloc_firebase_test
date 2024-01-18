part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent {}

final class SignUpButtonClickedEvent extends SignUpEvent {
  final String email;
  final String password;

  SignUpButtonClickedEvent({required this.email, required this.password});
}

final class SignInNavigateButtonClickedEvent extends SignUpEvent {}

final class ResetSignUpStateEvent extends SignUpEvent {}

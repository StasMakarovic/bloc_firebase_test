part of 'sign_in_bloc.dart';

@immutable
sealed class SignInEvent {}

final class SignInButtonClickedEvent extends SignInEvent {
  final String email;
  final String password;

  SignInButtonClickedEvent({required this.email, required this.password});
}

final class ResetSignInEvent extends SignInEvent {}

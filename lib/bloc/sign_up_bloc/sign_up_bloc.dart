import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_firebase_test/data/repository/auth.dart';
import 'package:bloc_firebase_test/dependency_injection/di_container.dart';
import 'package:bloc_firebase_test/exception/exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthMethods authMethods;

  SignUpBloc(this.authMethods) : super(SignUpInitialState()) {
    on<SignUpButtonClickedEvent>(signUpButtonClickedEvent);
    on<SignInNavigateButtonClickedEvent>(signInNavigateButtonClickedEvent);
    on<ResetSignUpStateEvent>(resetSignUpState);
  }

  FutureOr<void> signUpButtonClickedEvent(
      SignUpButtonClickedEvent event, Emitter<SignUpState> emit) async {
    emit(SignUpLoadingState());
    try {
      await authMethods.signUp(event.email, event.password);
      emit(SuccessfulSignUpState());
    } on AuthException catch (e) {
      emit(ShowSnackBarState(e.message)); //known exception corectly handeled
      emit(SignUpInitialState());
    } catch (e) {
      emit(ShowSnackBarState(e.toString())); //unknown exceptions just printed
      emit(SignUpInitialState());
    }
  }

  FutureOr<void> signInNavigateButtonClickedEvent(
      SignInNavigateButtonClickedEvent event, Emitter<SignUpState> emit) {
    emit(NavigateToSignInState());
  }

  FutureOr<void> resetSignUpState(
      ResetSignUpStateEvent event, Emitter<SignUpState> emit) {
    emit(SignUpInitialState());
  }
}

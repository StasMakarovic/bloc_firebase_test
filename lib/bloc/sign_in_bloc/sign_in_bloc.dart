import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_firebase_test/data/repository/auth.dart';
import 'package:bloc_firebase_test/dependency_injection/di_container.dart';
import 'package:bloc_firebase_test/exception/exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitialState()) {
    on<SignInButtonClickedEvent>(signInButtonClickedEvent);
    on<ResetSignInEvent>(resetSignInEvent);
  }

  FutureOr<void> signInButtonClickedEvent(
      SignInButtonClickedEvent event, Emitter<SignInState> emit) async {
    final _authMethods = locator<AuthMethods>();

    emit(SignInLoadingState());
    try {
      await _authMethods.signIn(event.email, event.password);
      emit(SuccessfulSignInState());
    } catch (e) {
      emit(ShowSnackBarSignInState(
          e.toString())); //unknown exceptions just printed
      emit(SignInInitialState());
    }
  }

  FutureOr<void> resetSignInEvent(
      ResetSignInEvent event, Emitter<SignInState> emit) {
    emit(SignInInitialState());
  }
}

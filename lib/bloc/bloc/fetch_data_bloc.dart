// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_firebase_test/data/repository/firestore.dart';
import 'package:bloc_firebase_test/model/calculated_data.dart';
import 'package:bloc_firebase_test/model/driving_data.dart';
import 'package:bloc_firebase_test/model/user.dart' as model;
import 'package:meta/meta.dart';
import 'package:bloc_firebase_test/data/repository/logicMethods.dart';

part 'fetch_data_event.dart';
part 'fetch_data_state.dart';

class FetchDataBloc extends Bloc<FetchDataEvent, FetchDataState> {
  final LogicMethods logicMethods;
  final FirestoreMethods firestoreMethods;

  FetchDataBloc(
    this.logicMethods,
    this.firestoreMethods,
  ) : super(FetchDataInitial()) {
    on<InitialFetchedData>(initialFetchedData);
  }

  FutureOr<void> initialFetchedData(
      InitialFetchedData event, Emitter<FetchDataState> emit) async {
    try {
      emit(FetchDataLoading());

      //usercurent

      final String currentUserUid = firestoreMethods.currentUser!.uid;

      final CalculatedData currentUserCalculatedData =
          await logicMethods.getTotalValues(currentUserUid);

      final model.User currentUserTotalData =
          await firestoreMethods.fetchUserData(currentUserUid);

      //contectedUser

      final String connectedUserUid = currentUserTotalData.uidConected;

      final CalculatedData connectedUserCalculatedData =
          await logicMethods.getTotalValues(connectedUserUid);

      emit(FetchDataSuccess(
          calculatedDataUser1: currentUserCalculatedData,
          dataUser1: currentUserTotalData,
          calculatedDataUser2: connectedUserCalculatedData));
    } catch (e) {
      emit(FetchDataError(error: e.toString()));
    }
  }
}

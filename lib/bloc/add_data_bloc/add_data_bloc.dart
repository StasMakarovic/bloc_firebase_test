import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_firebase_test/data/repository/firestore.dart';
import 'package:bloc_firebase_test/model/driving_data.dart';
import 'package:meta/meta.dart';

part 'add_data_event.dart';
part 'add_data_state.dart';

class AddDataBloc extends Bloc<AddDataEvent, AddDataState> {
  final FirestoreMethods authMethods;

  AddDataBloc(this.authMethods) : super(AddDataInitial()) {
    on<AddInformation>(addInformation);
  }

  FutureOr<void> addInformation(
      AddInformation event, Emitter<AddDataState> emit) {
    try {
      final data = DrivingData(
          range: event.range ?? 0,
          money: event.price ?? 0,
          fuelUsage: event.usage ?? 0,
          uid: authMethods.currentUser!.uid,
          fuelPrice: '0',
          date: DateTime.now());
      authMethods.addData(data);
      emit(ShowSnackBarAddDataState(message: 'succesfull'));
    } catch (e) {
      emit(ShowSnackBarAddDataState(message: e.toString()));
    }
  }
}

part of 'add_data_bloc.dart';

@immutable
sealed class AddDataState {}

abstract class AddDataActionState extends AddDataState {}

final class AddDataInitial extends AddDataState {}

final class ShowSnackBarAddDataState extends AddDataActionState {
  final String message;

  ShowSnackBarAddDataState({required this.message});
}

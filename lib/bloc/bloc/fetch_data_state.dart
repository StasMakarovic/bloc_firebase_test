part of 'fetch_data_bloc.dart';

@immutable
sealed class FetchDataState {}

final class FetchDataInitial extends FetchDataState {}

final class FetchDataError extends FetchDataState {
  final String error;

  FetchDataError({required this.error});
}

final class FetchDataSuccess extends FetchDataState {
  final CalculatedData calculatedDataUser1;
  final model.User dataUser1;

  final CalculatedData calculatedDataUser2;

  FetchDataSuccess({
    required this.calculatedDataUser1,
    required this.dataUser1,
    required this.calculatedDataUser2,
  });
}

final class FetchDataLoading extends FetchDataState {}

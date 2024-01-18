part of 'fetch_data_bloc.dart';

@immutable
sealed class FetchDataEvent {}

final class InitialFetchedData extends FetchDataEvent {}

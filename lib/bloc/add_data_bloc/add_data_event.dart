part of 'add_data_bloc.dart';

@immutable
sealed class AddDataEvent {}

final class AddInformation extends AddDataEvent {
  final double? range;
  final double? price;
  final double? usage;

  AddInformation(
      {required this.range, required this.price, required this.usage});
}

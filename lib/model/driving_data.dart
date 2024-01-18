// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';
import 'dart:convert';

class DrivingData {
  final double range;
  final double money;
  final double fuelUsage;
  final String uid;
  final String fuelPrice;
  final DateTime date;
  DrivingData({
    required this.range,
    required this.money,
    required this.fuelUsage,
    required this.uid,
    required this.fuelPrice,
    required this.date,
  });

  DrivingData copyWith({
    double? range,
    double? money,
    double? fuelUsage,
    String? uid,
    String? fuelPrice,
    DateTime? date,
  }) {
    return DrivingData(
      range: range ?? this.range,
      money: money ?? this.money,
      fuelUsage: fuelUsage ?? this.fuelUsage,
      uid: uid ?? this.uid,
      fuelPrice: fuelPrice ?? this.fuelPrice,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'range': range,
      'money': money,
      'fuelUsage': fuelUsage,
      'uid': uid,
      'fuelPrice': fuelPrice,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory DrivingData.fromMap(Map<String, dynamic> map) {
    return DrivingData(
      range: map['range'] as double,
      money: map['money'] as double,
      fuelUsage: map['fuelUsage'] as double,
      uid: map['uid'] as String,
      fuelPrice: map['fuelPrice'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory DrivingData.fromJson(String source) =>
      DrivingData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DrivingData(range: $range, money: $money, fuelUsage: $fuelUsage, uid: $uid, fuelPrice: $fuelPrice, date: $date)';
  }

  @override
  bool operator ==(covariant DrivingData other) {
    if (identical(this, other)) return true;

    return other.range == range &&
        other.money == money &&
        other.fuelUsage == fuelUsage &&
        other.uid == uid &&
        other.fuelPrice == fuelPrice &&
        other.date == date;
  }

  @override
  int get hashCode {
    return range.hashCode ^
        money.hashCode ^
        fuelUsage.hashCode ^
        uid.hashCode ^
        fuelPrice.hashCode ^
        date.hashCode;
  }
}

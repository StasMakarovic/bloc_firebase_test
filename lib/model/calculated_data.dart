// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CalculatedData {
  final double totalMoney;
  final double totalRange;
  final double totalUsage;
  final double averageUsage;
  CalculatedData({
    required this.totalMoney,
    required this.totalRange,
    required this.totalUsage,
    required this.averageUsage,
  });

  CalculatedData copyWith({
    double? totalMoney,
    double? totalRange,
    double? totalUsage,
    double? averageUsage,
  }) {
    return CalculatedData(
      totalMoney: totalMoney ?? this.totalMoney,
      totalRange: totalRange ?? this.totalRange,
      totalUsage: totalUsage ?? this.totalUsage,
      averageUsage: averageUsage ?? this.averageUsage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalMoney': totalMoney,
      'totalRange': totalRange,
      'totalUsage': totalUsage,
      'averageUsage': averageUsage,
    };
  }

  factory CalculatedData.fromMap(Map<String, dynamic> map) {
    return CalculatedData(
      totalMoney: map['totalMoney'] as double,
      totalRange: map['totalRange'] as double,
      totalUsage: map['totalUsage'] as double,
      averageUsage: map['averageUsage'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory CalculatedData.fromJson(String source) =>
      CalculatedData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CalculatedData(totalMoney: $totalMoney, totalRange: $totalRange, totalUsage: $totalUsage, averageUsage: $averageUsage)';
  }

  @override
  bool operator ==(covariant CalculatedData other) {
    if (identical(this, other)) return true;

    return other.totalMoney == totalMoney &&
        other.totalRange == totalRange &&
        other.totalUsage == totalUsage &&
        other.averageUsage == averageUsage;
  }

  @override
  int get hashCode {
    return totalMoney.hashCode ^
        totalRange.hashCode ^
        totalUsage.hashCode ^
        averageUsage.hashCode;
  }
}

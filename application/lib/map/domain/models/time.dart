// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Time extends Equatable {
  final int hour;
  final int minute;
  final int second;
  const Time({
    required this.hour,
    required this.minute,
    required this.second,
  });

  Time copyWith({
    int? hour,
    int? minute,
    int? second,
  }) {
    return Time(
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      second: second ?? this.second,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hour': hour,
      'minute': minute,
      'second': second,
    };
  }

  String getFormatted() {
    return "$hour:$minute";
  }

  factory Time.fromMap(Map<String, dynamic> map) {
    return Time(
      hour: map['hour'] as int,
      minute: map['minute'] as int,
      second: map['second'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Time.fromJson(String source) => Time.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [hour, minute, second];
}

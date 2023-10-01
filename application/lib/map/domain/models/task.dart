// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


class Task extends Equatable {
  final int? id;
  final double? long;
  final double? lat;
  final double? radius;
  final String? memo;
  final TimeOfDay? from;
  final TimeOfDay? to;
  final String? location;

  const Task({
    this.id,
    this.long,
    this.lat,
    this.radius,
    this.memo,
    this.from,
    this.to,
    this.location,
  });

  Task copyWith({
    int? id,
    double? long,
    double? lat,
    double? radius,
    String? memo,
    TimeOfDay? from,
    TimeOfDay? to,
    String? location,
  }) {
    return Task(
      id: id ?? this.id,
      long: long ?? this.long,
      lat: lat ?? this.lat,
      radius: radius ?? this.radius,
      memo: memo ?? this.memo,
      from: from ?? this.from,
      to: to ?? this.to,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'id': id,
      'long': long,
      'lat': lat,
      'radius': radius,
      'memo': memo,
      'from': [from?.hour ?? 0, from?.minute ?? 0].join(":"),
      'to': [to?.hour ?? 0, to?.minute ?? 0].join(":"),
      'location': location,
    };
  }

  // factory Task.fromMap(Map<String, dynamic> map) {
  //   return Task(
  //     id: map['id'] != null ? map['id'] as int : null,
  //     long: map['long'] != null ? map['long'] as double : null,
  //     lat: map['lat'] != null ? map['lat'] as double : null,
  //     radius: map['radius'] != null ? map['radius'] as double : null,
  //     memo: map['memo'] != null ? map['memo'] as String : null,
  //     from: map['from'] != null
  //         ? Time.fromMap(map['from'] as Map<String, dynamic>)
  //         : null,
  //     to: map['to'] != null
  //         ? Time.fromMap(map['to'] as Map<String, dynamic>)
  //         : null,
  //     location: map['location'] != null ? map['location'] as String : null,
  //   );
  // }

  String toJson() => json.encode(toMap());

  // factory Task.fromJson(String source) =>
  //     Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id ?? -1,
      long ?? 0,
      lat ?? 0,
      radius ?? 0,
      memo ?? '',
      location ?? '',
    ];
  }
}

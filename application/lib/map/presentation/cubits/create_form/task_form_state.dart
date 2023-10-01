// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'task_form_cubit.dart';

enum TaskFormStatus { loading, success, failed }

class TaskFormState extends Equatable {
  final String memo;
  final double radius;
  final double latitude;
  final double longitude;
  final String location;
  final TaskFormStatus status;
  final TimeOfDay from;
  final TimeOfDay to;

   TaskFormState({
    this.memo = "",
    this.radius = 0,
    this.latitude = 0,
    this.longitude = 0,
    this.location = "",
    this.status = TaskFormStatus.loading,
    this.from = const TimeOfDay(hour: 0, minute: 0),
    this.to = const TimeOfDay(hour: 0, minute: 0)
  });


  @override
  List<Object> get props {
    return [
      memo,
      radius,
      latitude,
      longitude,
      location,
      status,
      from,
      to

    ];
  }

  @override
  bool get stringify => true;


  TaskFormState copyWith({
    String? memo,
    double? radius,
    double? latitude,
    double? longitude,
    String? location,
    TaskFormStatus? status,
    TimeOfDay? from,
    TimeOfDay? to,
  }) {
    return TaskFormState(
      memo:memo ?? this.memo,
      radius: radius ?? this.radius,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      location: location ?? this.location,
      status: status ?? this.status,
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }
}

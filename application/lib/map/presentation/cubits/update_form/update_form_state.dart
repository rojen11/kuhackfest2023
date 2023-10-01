part of 'update_form_cubit.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

enum UpdateFormStatus { loading, success, failed }

class UpdateFormState extends Equatable {
  final String memo;
  final double radius;
  final double latitude;
  final double longitude;
  final String location;
  final UpdateFormStatus status;
  final TimeOfDay? from;
  final TimeOfDay? to;
  final int id;

  const UpdateFormState(
      {this.memo = "",
      this.radius = 0,
      this.latitude = 0,
      this.longitude = 0,
      this.location = "",
      this.status = UpdateFormStatus.loading,
      this.from,
      this.to,
      required this.id});

  @override
  List<Object> get props {
    return [memo, radius, latitude, longitude, location, status, id];
  }

  @override
  bool get stringify => true;

  UpdateFormState copyWith({
    String? memo,
    double? radius,
    double? latitude,
    double? longitude,
    String? location,
    UpdateFormStatus? status,
    TimeOfDay? from,
    TimeOfDay? to,
    int? id,
  }) {
    return UpdateFormState(
        memo: memo ?? this.memo,
        radius: radius ?? this.radius,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        location: location ?? this.location,
        status: status ?? this.status,
        from: from ?? this.from,
        to: to ?? this.to,
        id: id ?? this.id);
  }
}

import 'package:application/map/domain/models/task.dart';
import 'package:application/map/domain/repositories/database_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

part 'update_form_state.dart';

class UpdateFormCubit extends Cubit<UpdateFormState> {
  UpdateFormCubit({required this.db, required this.id})
      : super(UpdateFormState(id: -1));

  final DatabaseRepository db;
  final int id;

  void init() async {
    Task task = await db.fetchTaskById(id);
    emit(UpdateFormState(
        id: task.id ?? -1,
        from: task.from,
        latitude: task.lat ?? 0,
        longitude: task.long ?? 0,
        location: task.location ?? "",
        memo: task.memo ?? "",
        radius: task.radius ?? 0,
        status: UpdateFormStatus.success,
        to: task.to));

  }

  void handleRadiusChange(double radius) {
    emit(state.copyWith(radius: radius));
  }

  void handleMemoChange(String memo) {
    emit(state.copyWith(memo: memo));
  }

  void handleCoordsChange(double latitude, double longitude) async {
    emit(state.copyWith(latitude: latitude, longitude: longitude));

    List<Placemark> placemarks = [];

    try {
      placemarks = await placemarkFromCoordinates(latitude, longitude);
    } catch (e) {
      debugPrint("Couldn't fetch placemarks");
    }

    String location = "";

    if (placemarks.isNotEmpty) {
      location = placemarks[0].street ?? "";
    }

    emit(state.copyWith(location: location));
  }

  void handleFromTimeChange(TimeOfDay time) {
    emit(state.copyWith(from: time));
  }

  void handleToTimeChange(TimeOfDay time) {
    emit(state.copyWith(to: time));
  }
}

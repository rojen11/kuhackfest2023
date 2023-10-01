import 'package:application/map/utils/extensions/check_location_permission.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

part 'task_form_state.dart';

class TaskFormCubit extends Cubit<TaskFormState> {
  TaskFormCubit() : super(TaskFormState());

  void initMap() async {
    if (await handleLocationPermission()) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      emit(state.copyWith(
          status: TaskFormStatus.success,
          latitude: position.latitude,
          longitude: position.longitude));
    }
    emit(state.copyWith(status: TaskFormStatus.failed));
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

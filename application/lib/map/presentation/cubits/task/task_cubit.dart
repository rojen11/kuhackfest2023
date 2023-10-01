import 'package:application/map/domain/models/task.dart';
import 'package:application/map/domain/repositories/database_repository.dart';
import 'package:application/map/utils/extensions/check_location_permission.dart';
import 'package:application/map/utils/extensions/location_background_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final DatabaseRepository databaseRepository;
  TaskCubit({required this.databaseRepository}) : super(TaskLoading());

  Future<void> getAllTasks() async {
    final data = await databaseRepository.fetchAllTask();
    emit(TaskSucess(tasks: data));

    if (await handleLocationPermission()) {
      FlutterBackgroundService service = FlutterBackgroundService();
      service.configure(
          iosConfiguration: IosConfiguration(),
          androidConfiguration: AndroidConfiguration(
              onStart: startLocationService, isForegroundMode: true));

      if (data.isEmpty) {
        if (await service.isRunning()) {
          service.invoke('stopService');
        }
      } else {
        if (!(await service.isRunning())) {
          service.startService();
        }
      }
    }
  }

  Future<List<Task>> _getAllTasks() async {
    final data = await databaseRepository.fetchAllTask();
    return data;
  }

  Future<void> insertTask(Task task) async {
    emit(TaskLoading());
    await databaseRepository.insertTask(task);
    emit(TaskSucess(tasks: await _getAllTasks()));
  }

  Future<void> updateTask(Task task) async {
    emit(TaskLoading());
    await databaseRepository.updateTask(task);
    emit(TaskSucess(tasks: await _getAllTasks()));

  }

  Future<void> deleteTask(Task task) async {
    emit(TaskLoading());
    await databaseRepository.deleteTask(task);
    emit(TaskSucess(tasks: await _getAllTasks()));
  }

}

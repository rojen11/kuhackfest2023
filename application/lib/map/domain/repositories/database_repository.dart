import 'package:application/map/domain/models/task.dart';

abstract class DatabaseRepository {


  Future<int> insertTask(Task task);

  Future<void> deleteTask(Task task);

  Future<int> updateTask(Task task);

  Future<List<Task>> fetchAllTask();

  Future<Task> fetchTaskById(int id);
}
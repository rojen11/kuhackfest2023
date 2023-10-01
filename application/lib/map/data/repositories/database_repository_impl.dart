// ignore: depend_on_referenced_packages
import 'package:application/map/domain/models/task.dart';
import 'package:application/map/domain/repositories/database_repository.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseRepositoryImpl extends DatabaseRepository {
  static const table = "task";
  static const database = "geonotify.db";

  static Future<Database> _getDatabase() async {
    const qry =
        "CREATE TABLE $table (`id` INTEGER PRIMARY KEY AUTOINCREMENT,  `lat` REAL, `long` REAL, `memo` TEXT, `location` TEXT, `radius` REAL, `from` TEXT, `to` TEXT);";

    return openDatabase(join(await getDatabasesPath(), database),
        onCreate: (db, version) {
      return db.execute(qry);
    }, version: 1);
  }

  @override
  Future<int> deleteTask(Task task) async {
    final database = await _getDatabase();

    return await database.delete(table, where: "id = ?", whereArgs: [task.id]);
  }

  @override
  Future<List<Task>> fetchAllTask() async {
    final database = await _getDatabase();

    final List<Map<String, dynamic>> maps = await database.query(table);

    return List.generate(maps.length, (index) {
      final data = maps[index];

      final from = data["from"].toString().split(":");
      final to = data["to"].toString().split(":");

      return Task(
        id: data["id"],
        lat: data["lat"],
        long: data["long"],
        memo: data["memo"],
        radius: data["radius"],
        location: data["location"],
        from: TimeOfDay(
          hour: int.parse(from[0]),
          minute: int.parse(from[1]),
        ),
        to: TimeOfDay(
          hour: int.parse(to[0]),
          minute: int.parse(to[1]),
        ),
      );
    });
  }

  @override
  Future<int> insertTask(Task task) async {
    Database database = await _getDatabase();
    int res = await database.insert(
      table,
      task.toMap(),
    );

    return res;
  }

  @override
  Future<int> updateTask(Task task) async {
    Database database = await _getDatabase();
    String from = [task.from?.hour ?? 0, task.from?.minute ?? 0].join(":");
    if (from == "") {
      from = "00:00";
    }

    String to = [task.to?.hour ?? 0, task.to?.minute ?? 0].join(":");
    if (to == "") {
      to = "00:00";
    }

    int res = await database.rawUpdate(
        'UPDATE $table SET lat = ?, long = ?, memo = ?, location = ?, radius = ?, `from` = ?, `to` = ? WHERE id = ?',
        [
          task.lat,
          task.long,
          task.memo,
          task.location,
          task.radius,
          from,
          to,
          task.id
        ]);

    return res;
  }

  @override
  Future<Task> fetchTaskById(int id) async {
    Database database = await _getDatabase();
    List<Map<String, dynamic>> maps =
        await database.query(table, where: "id = ?", whereArgs: [id]);

    List<Task> data = List.generate(maps.length, (index) {
      final data = maps[index];

      final from = data["from"].toString().split(":");
      final to = data["to"].toString().split(":");

      return Task(
        id: data["id"],
        lat: data["lat"],
        long: data["long"],
        memo: data["memo"],
        radius: data["radius"],
        location: data["location"],
        from: TimeOfDay(
          hour: int.parse(from[0]),
          minute: int.parse(from[1]),
        ),
        to: TimeOfDay(
          hour: int.parse(to[0]),
          minute: int.parse(to[1]),
        ),
      );
    });

    if (data.length == 1) {
      return data[0];
    }

    throw Exception("Task not found");
  }
}

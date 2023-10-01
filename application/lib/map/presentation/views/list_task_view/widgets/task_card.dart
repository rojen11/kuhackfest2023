import 'package:application/map/domain/models/task.dart';
import 'package:application/map/presentation/cubits/task/task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    String from = task.from?.format(context) ?? '';
    String to = task.to?.format(context) ?? '';
    double radius = task.radius ?? 0;
    String location = task.location ?? '';

    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            flex: 1,
            onPressed: (context) {
              context.read<TaskCubit>().deleteTask(task);
            },
            backgroundColor: Colors.transparent,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          context.push("/update/${task.id}");
        },
        child: Card(
          color: Colors.white12,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$radius km - $location",
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      task.memo ?? "",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Text(
                  "$from - $to",
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:application/map/data/repositories/database_repository_impl.dart';
import 'package:application/map/domain/models/task.dart';
import 'package:application/map/presentation/cubits/task/task_cubit.dart';
import 'package:application/map/presentation/cubits/update_form/update_form_cubit.dart';
import 'package:application/map/presentation/views/create_view/widgets/map_view.dart';
import 'package:application/map/presentation/views/update_view/update_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UpdateViewWrapper extends StatelessWidget {
  const UpdateViewWrapper({super.key, required this.taskId});

  final int taskId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateFormCubit(
          db: context.read<DatabaseRepositoryImpl>(), id: taskId)
        ..init(),
      child: const UpdateView(),
    );
  }
}

class UpdateView extends StatelessWidget {
  const UpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    void handleUpdateTask() {
      UpdateFormState formValue = context.read<UpdateFormCubit>().state;

      Task task = Task(
          id: formValue.id,
          lat: formValue.latitude,
          long: formValue.longitude,
          memo: formValue.memo,
          radius: formValue.radius,
          location: formValue.location,
          from: formValue.from,
          to: formValue.to);

      context.read<TaskCubit>().updateTask(task);
      context.go("/list");
    }

    return Scaffold(body: SafeArea(
      child: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          return Stack(
            children: [
              const MapView(),
              DraggableScrollableSheet(
                // expand: true,
                maxChildSize: 1,
                minChildSize: 0.2,
                initialChildSize: 0.2,

                builder: (context, scrollController) => SingleChildScrollView(
                  controller: scrollController,
                  child: UpdateForm(
                    onUpdate: handleUpdateTask,
                  ),
                ),
              )
            ],
          );
        },
      ),
    ));
  }
}

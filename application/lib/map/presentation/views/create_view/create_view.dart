import 'package:application/map/domain/models/task.dart';
import 'package:application/map/presentation/cubits/create_form/task_form_cubit.dart';
import 'package:application/map/presentation/cubits/task/task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'widgets/widgets.dart';

class CreateViewWrapper extends StatelessWidget {
  const CreateViewWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskFormCubit()..initMap(),
      child: const CreateView(),
    );
  }
}

class CreateView extends StatelessWidget {
  const CreateView({super.key});

  @override
  Widget build(BuildContext context) {
    void handleCreateTask() {
      TaskFormState formValue = context.read<TaskFormCubit>().state;


      Task task = Task(
          lat: formValue.latitude,
          long: formValue.longitude,
          memo: formValue.memo,
          radius: formValue.radius,
          location: formValue.location,
          from: formValue.from,
          to: formValue.to
          );

      context.read<TaskCubit>().insertTask(task);
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
                  child: CreateForm(
                    onCreate: handleCreateTask,
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

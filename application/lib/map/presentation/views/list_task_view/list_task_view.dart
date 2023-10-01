import 'package:application/map/domain/models/task.dart';
import 'package:application/map/presentation/cubits/task/task_cubit.dart';
import 'package:application/map/presentation/views/list_task_view/widgets/task_card.dart';
import 'package:application/screens/camera_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ListTaskView extends StatelessWidget {
  const ListTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text("Snap Point"),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CameraView()));
                      },
                      icon: Icon(Icons.camera),
                    )
                  ]),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: BlocBuilder<TaskCubit, TaskState>(
                  builder: (context, state) {
                    if (state is TaskLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    }

                    // go to create if list is empty
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (state.tasks.isEmpty) {
                        context.go("/create");
                      }
                    });

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.tasks.length,
                      itemBuilder: (context, index) {
                        Task item = state.tasks[index];
                        return TaskCard(task: item);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // FloatingActionButton(
              //   key: Key("fab1"),
              //   shape: const CircleBorder(),
              //   onPressed: () {},
              //   backgroundColor: Colors.white,
              //   child: const Icon(
              //     Icons.camera,
              //     color: Colors.black,
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              FloatingActionButton(
                key: Key("fab2"),
                shape: const CircleBorder(),
                onPressed: () {
                  context.push('/create');
                },
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
            ]));
  }
}

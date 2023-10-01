part of 'task_cubit.dart';

abstract class TaskState extends Equatable {

  final List<Task> tasks;


  const TaskState({
    this.tasks = const []
  });

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskSucess extends TaskState {
  const TaskSucess({super.tasks});
}

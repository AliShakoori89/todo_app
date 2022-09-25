import 'package:todo_app/model/task_model.dart';

abstract class TaskFromNetEvent{
  @override
  List<Object> get props => [];
}

class AddNewTaskEvent extends TaskFromNetEvent {

  final TaskModel taskModel;

  AddNewTaskEvent(
      {required this.taskModel});

  @override
  List<Object> get props => [taskModel];
}

class EditTaskEvent extends TaskFromNetEvent {

  final TaskModel taskModel;

  EditTaskEvent(
      {required this.taskModel});

  @override
  List<Object> get props => [taskModel];
}

class GetAllTaskEvent extends TaskFromNetEvent {
  GetAllTaskEvent();
}

class DeleteTaskEvent extends TaskFromNetEvent{
  final int id;

  DeleteTaskEvent({required this.id});

  @override
  List<Object> get props => [id];
}
import 'package:todo_app/model/task_model.dart';

abstract class TasksEvent{
  @override
  List<Object> get props => [];
}

class AddNewTaskEvent extends TasksEvent {

  final TaskModel taskModel;

  AddNewTaskEvent(
      {required this.taskModel});

  @override
  List<Object> get props => [taskModel];
}

class EditTaskEvent extends TasksEvent {

  final int id;
  final bool done;

  EditTaskEvent(
      {required this.id, required this.done});

  @override
  List<Object> get props => [id, done];
}

class GetAllTaskEvent extends TasksEvent {
  GetAllTaskEvent();
}

class DeleteTaskEvent extends TasksEvent{
  final int id;

  DeleteTaskEvent({required this.id});

  @override
  List<Object> get props => [id];
}
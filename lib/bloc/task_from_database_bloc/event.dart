import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/model/task_model_for_data_base.dart';

abstract class TaskFromDataBaseEvent{
  @override
  List<Object> get props => [];
}

class AddNewTaskEvent extends TaskFromDataBaseEvent {

  final TaskModel taskModel;

  AddNewTaskEvent(
      {required this.taskModel});

  @override
  List<Object> get props => [taskModel];
}

class EditTaskEvent extends TaskFromDataBaseEvent {

  final TaskModel taskModel;

  EditTaskEvent(
      {required this.taskModel});

  @override
  List<Object> get props => [taskModel];
}

class GetAllTaskEvent extends TaskFromDataBaseEvent {
  GetAllTaskEvent();
}

class DeleteTaskEvent extends TaskFromDataBaseEvent{
  final int id;

  DeleteTaskEvent({required this.id});

  @override
  List<Object> get props => [id];
}
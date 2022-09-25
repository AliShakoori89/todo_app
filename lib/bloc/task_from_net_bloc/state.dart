import 'package:equatable/equatable.dart';
import 'package:todo_app/model/task_model.dart';

abstract class TaskFromNetState extends Equatable {
  @override
  List<Object> get props => [];
}

class TasksInitialState extends TaskFromNetState {}

class TasksError extends TaskFromNetState {
  final int errorCode;

  TasksError(this.errorCode);
}

class TasksIsLoadedState extends TaskFromNetState {
  final List<TaskModel> _allTasks;

  TasksIsLoadedState(this._allTasks);

  List<TaskModel> get allTask => _allTasks;

  @override
  List<Object> get props => [_allTasks];
}

class TasksIsLoadingState extends TaskFromNetState {}

class TasksIsSucceededState extends TaskFromNetState {}

class TasksFailedState extends TaskFromNetState {
  final String status;

  TasksFailedState(this.status);

  @override
  List<Object> get props => [status];
}
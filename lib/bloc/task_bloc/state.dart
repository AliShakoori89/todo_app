import 'package:equatable/equatable.dart';
import 'package:todo_app/model/task_model.dart';

abstract class TasksState extends Equatable {
  @override
  List<Object> get props => [];
}

class TasksInitialState extends TasksState {}

class TasksError extends TasksState {
  final int errorCode;

  TasksError(this.errorCode);
}

class TasksIsLoadedState extends TasksState {
  final List<TaskModel> _allTasks;

  TasksIsLoadedState(this._allTasks);

  List<TaskModel> get allTask => _allTasks;

  @override
  List<Object> get props => [_allTasks];
}

class TasksIsLoadingState extends TasksState {}

class TasksIsSucceededState extends TasksState {}

class TasksFailedState extends TasksState {
  final String status;

  TasksFailedState(this.status);

  @override
  List<Object> get props => [status];
}
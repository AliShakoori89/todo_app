import 'package:equatable/equatable.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/model/task_model_for_data_base.dart';

abstract class TaskFromDataBaseState extends Equatable {
  @override
  List<Object> get props => [];
}

class TasksInitialState extends TaskFromDataBaseState {}

class TasksError extends TaskFromDataBaseState {
  final int errorCode;

  TasksError(this.errorCode);
}

class TasksIsLoadedState extends TaskFromDataBaseState {
  final List<TaskForDataBaseModel> _allTasks;

  TasksIsLoadedState(this._allTasks);

  List<TaskForDataBaseModel> get allTask => _allTasks;

  @override
  List<Object> get props => [_allTasks];
}

class TasksIsLoadingState extends TaskFromDataBaseState {}

class TasksIsSucceededState extends TaskFromDataBaseState {}

class TasksFailedState extends TaskFromDataBaseState {
  final String status;

  TasksFailedState(this.status);

  @override
  List<Object> get props => [status];
}
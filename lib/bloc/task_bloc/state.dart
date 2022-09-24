// import 'package:equatable/equatable.dart';
// import 'package:todo_app/model/task_model.dart';
//
//
// enum GetTaskStateStatus { initial, success, error, loading }
//
// extension GetTaskStateStatusX on GetTaskStateStatus {
//   bool get isInitial => this == GetTaskStateStatus.initial;
//   bool get isSuccess => this == GetTaskStateStatus.success;
//   bool get isError => this == GetTaskStateStatus.error;
//   bool get isLoading => this == GetTaskStateStatus.loading;
// }
//
// class TasksState extends Equatable {
//
//   const TasksState({
//     this.status = GetTaskStateStatus.initial,
//     List<TaskModel>? allTasks,
//   }): allTask = allTasks ?? const [];
//
//   final GetTaskStateStatus status;
//   final List<TaskModel> allTask;
//
//   @override
//   // TODO: implement props
//   List<Object> get props => [status, allTask];
//
//   TasksState copyWith({
//     GetTaskStateStatus? status,
//     List<TaskModel>? allTasks
//   }) {
//     return TasksState(
//       status: status ?? this.status,
//       allTasks: allTasks ?? allTask,
//     );
//   }
// }

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
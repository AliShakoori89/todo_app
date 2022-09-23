import 'package:equatable/equatable.dart';
import 'package:todo_app/model/task_model.dart';


enum GetTaskStateStatus { initial, success, error, loading }

extension GetTaskStateStatusX on GetTaskStateStatus {
  bool get isInitial => this == GetTaskStateStatus.initial;
  bool get isSuccess => this == GetTaskStateStatus.success;
  bool get isError => this == GetTaskStateStatus.error;
  bool get isLoading => this == GetTaskStateStatus.loading;
}

class TasksState extends Equatable {

  const TasksState({
    this.status = GetTaskStateStatus.initial,
    List<TaskModel>? allTasks,
  }): allTask = allTasks ?? const [];

  final GetTaskStateStatus status;
  final List<TaskModel> allTask;

  @override
  // TODO: implement props
  List<Object> get props => [status, allTask];

  TasksState copyWith({
    GetTaskStateStatus? status,
    List<TaskModel>? allTasks
  }) {
    return TasksState(
      status: status ?? this.status,
      allTasks: allTasks ?? allTask,
    );
  }
}
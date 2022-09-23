import 'package:equatable/equatable.dart';
import 'package:todo_app/model/task_model.dart';


enum GetTaskStateStatus { initial, success, error, loading }

extension GetTaskStateStatusX on GetTaskStateStatus {
  bool get isInitial => this == GetTaskStateStatus.initial;
  bool get isSuccess => this == GetTaskStateStatus.success;
  bool get isError => this == GetTaskStateStatus.error;
  bool get isLoading => this == GetTaskStateStatus.loading;
}

class GetTasksState extends Equatable {

  const GetTasksState({
    this.status = GetTaskStateStatus.initial,
    List<TaskModel>? allTasks,
  }): allTask = allTasks ?? const [];

  final GetTaskStateStatus status;
  final List<TaskModel> allTask;

  @override
  // TODO: implement props
  List<Object> get props => [status, allTask];

  GetTasksState copyWith({
    GetTaskStateStatus? status,
    List<TaskModel>? allTasks
  }) {
    return GetTasksState(
      status: status ?? this.status,
      allTasks: allTasks ?? allTask,
    );
  }
}
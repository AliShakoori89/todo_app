import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/task_from_net_bloc/event.dart';
import 'package:todo_app/bloc/task_from_net_bloc/state.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/network/http_exception.dart';
import 'package:todo_app/repository/task_repository.dart';

class TaskFromNetBloc extends Bloc<TaskFromNetEvent, TaskFromNetState> {
  TaskRepository taskRepository = TaskRepository();

  TaskFromNetBloc(this.taskRepository)
      : super(TasksInitialState());

  @override
  Stream<TaskFromNetState> mapEventToState(TaskFromNetEvent event) async* {

    if (event is GetAllTaskEvent) {
      try {
        final response = await taskRepository.getAllTask();
        Iterable l = json.decode(response.body);
        List<TaskModel> allTask = List<TaskModel>.from(l.map((model)=> TaskModel.fromJson(model)));
        yield TasksIsLoadedState(allTask);
      } catch (exception) {
        if (exception is AppException) {
          yield TasksFailedState('300');
        } else {
          yield TasksFailedState('500');
        }
      }}

    if (event is AddNewTaskEvent) {
      yield TasksIsLoadingState();
      String status = await taskRepository.addTask(event.taskModel);
      if (status.toString() == "Task_Already_exist") {
        yield TasksFailedState(status);
      } else {
        yield TasksIsSucceededState();
      }
    }

    if(event is EditTaskEvent){
      yield TasksIsLoadingState();
      String status = await taskRepository.editTask(event.taskModel);
      if (status.toString() == "Review_Already_exist") {
        yield TasksFailedState(status);
      } else {
        yield TasksIsSucceededState();
      }
    }
    if(event is DeleteTaskEvent){
      yield TasksIsLoadingState();
      String status = await taskRepository.deleteTask(event.id);
      if (status.toString() == "Review_Already_exist") {
        yield TasksFailedState(status);
      } else {
        yield TasksIsSucceededState();
      }
    }
  }
}
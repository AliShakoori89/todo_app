import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/task_bloc/event.dart';
import 'package:todo_app/bloc/task_bloc/state.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/repository/task_repository.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TaskRepository taskRepository = TaskRepository();

  TasksBloc(this.taskRepository)
      : super(TasksInitialState());

  @override
  Stream<TasksState> mapEventToState(TasksEvent event) async* {
    if (event is GetAllTaskEvent) {
      yield TasksIsLoadingState();
      final response = await taskRepository.getAllTask();
      Iterable l = json.decode(response.body);
      List<TaskModel> allTask = List<TaskModel>.from(l.map((model)=> TaskModel.fromJson(model)));
      yield TasksIsLoadedState(allTask);
    }
    if (event is AddNewTaskEvent) {
      yield TasksIsLoadingState();
      String status = await taskRepository.addTask(event.title, event.description!);
      if (status.toString() == "Task_Already_exist") {
        yield TasksFailedState(status);
      } else {
        yield TasksIsSucceededState();
      }
    }
    if(event is EditTaskEvent){
      yield TasksIsLoadingState();
      String status = await taskRepository.editTask(event.id, event.done);
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
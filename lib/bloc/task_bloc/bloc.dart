import 'dart:convert';
import 'dart:io';

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

      try {
        yield TasksIsLoadingState();
        final result = await InternetAddress.lookup('example.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print('connected');
          final response = await taskRepository.getAllTask();
          Iterable l = json.decode(response.body);
          List<TaskModel> allTask = List<TaskModel>.from(l.map((model)=> TaskModel.fromJson(model)));
          yield TasksIsLoadedState(allTask);
        }
      } on SocketException catch (_) {
        // var status = "Task_Already_exist";
        print('not connected');
        print('not connected');
      }
    }
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
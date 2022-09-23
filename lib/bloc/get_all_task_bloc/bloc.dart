import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:todo_app/bloc/get_all_task_bloc/event.dart';
import 'package:todo_app/bloc/get_all_task_bloc/state.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/repository/task_repository.dart';

class GetTasksBloc extends Bloc<GetTasksEvent, GetTasksState> {
  TaskRepository taskRepository;

  GetTasksBloc(this.taskRepository) : super(const GetTasksState()) {
    on<GetAllTaskEvent>(_mapGetAllTaskEventToState);
    on<AddNewTaskEvent>(_mapAddTaskEventToState);

  }

  void _mapGetAllTaskEventToState(
      GetAllTaskEvent event, Emitter<GetTasksState> emit) async {

    final response = await taskRepository.getAllTask();

    try {
      emit(state.copyWith(status: GetTaskStateStatus.loading));

      Iterable l = json.decode(response.body);
      List<TaskModel> allTask = List<TaskModel>.from(l.map((model)=> TaskModel.fromJson(model)));

      emit(
        state.copyWith(
          status: GetTaskStateStatus.success,
          allTasks: allTask,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: GetTaskStateStatus.error));
    }
  }

  void _mapAddTaskEventToState(
      AddNewTaskEvent event, Emitter<GetTasksState> emit) async {

    try {
      emit(state.copyWith(status: GetTaskStateStatus.loading));

      await taskRepository.addTask(event.title, event.description!);


      emit(
        state.copyWith(
          status: GetTaskStateStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: GetTaskStateStatus.error));
    }
  }
}
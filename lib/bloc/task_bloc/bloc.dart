import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/task_bloc/event.dart';
import 'package:todo_app/bloc/task_bloc/state.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/repository/task_repository.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TaskRepository taskRepository;

  TasksBloc(this.taskRepository) : super(const TasksState()) {
    on<GetAllTaskEvent>(_mapGetAllTaskEventToState);
    on<AddNewTaskEvent>(_mapAddTaskEventToState);
    on<EditTaskEvent>(_mapEditTaskEventToState);
  }

  void _mapGetAllTaskEventToState(
      GetAllTaskEvent event, Emitter<TasksState> emit) async {

    try {
      emit(state.copyWith(status: GetTaskStateStatus.loading));
      final response = await taskRepository.getAllTask();
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
      AddNewTaskEvent event, Emitter<TasksState> emit) async {

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

  void _mapEditTaskEventToState(
      EditTaskEvent event, Emitter<TasksState> emit) async {

    try {
      emit(state.copyWith(status: GetTaskStateStatus.loading));

      await taskRepository.editTask(event.id, event.done);

      print('success');
      emit(
        state.copyWith(
          status: GetTaskStateStatus.success,
        ),
      );
    } catch (error) {
      print('errrrrrrrrrrrrrrrrrrrrrror');
      emit(state.copyWith(status: GetTaskStateStatus.error));
    }
  }
}
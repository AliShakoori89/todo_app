import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/task_from_database_bloc/event.dart';
import 'package:todo_app/bloc/task_from_database_bloc/state.dart';
import 'package:todo_app/model/task_model_for_data_base.dart';
import 'package:todo_app/repository/task_repository.dart';

class TaskFromDataBaseBloc extends Bloc<TaskFromDataBaseEvent, TaskFromDataBaseState> {
  TaskRepository taskRepository = TaskRepository();

  TaskFromDataBaseBloc(this.taskRepository)
      : super(TasksInitialState());

  @override
  Stream<TaskFromDataBaseState> mapEventToState(TaskFromDataBaseEvent event) async* {

    if (event is GetAllTaskEvent) {
        List<TaskForDataBaseModel> allTask = await taskRepository.getAllTaskFromDataBase();
        yield TasksIsLoadedState(allTask);}

    if (event is AddNewTaskEvent) {
      yield TasksIsLoadingState();
      await taskRepository.addTask(event.taskModel);
    }

    if(event is EditTaskEvent){
      yield TasksIsLoadingState();
      await taskRepository.updateTaskToDataBase(event.taskForDataBaseModel);
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
abstract class TasksEvent {
  const TasksEvent();
}

class GetAllTaskEvent extends TasksEvent {
  const GetAllTaskEvent();
}

class AddNewTaskEvent extends TasksEvent {
  final String title;
  final String? description;
  final bool? done;

  AddNewTaskEvent(
      {required this.title, this.description, this.done});

  @override
  List<Object> get props => [title, description!, done!];
}

class EditTaskEvent extends TasksEvent {

  final int id;
  final bool done;

  EditTaskEvent(
      {required this.id, required this.done});

  @override
  List<Object> get props => [id, done];
}


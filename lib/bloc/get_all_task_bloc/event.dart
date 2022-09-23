abstract class GetTasksEvent {
  const GetTasksEvent();
}

class GetAllTaskEvent extends GetTasksEvent {
  const GetAllTaskEvent();
}

class AddNewTaskEvent extends GetTasksEvent {
  final String title;
  final String? description;
  final bool? done;

  AddNewTaskEvent(
      {required this.title, this.description, this.done});

  @override
  List<Object> get props => [title, description!, done!];
}


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:todo_app/bloc/task_bloc/bloc.dart';
import 'package:todo_app/repository/task_repository.dart';
import 'screen/all_task_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>
                TasksBloc(TaskRepository())),
        // BlocProvider(
        //     create: (BuildContext context) =>
        //         AddTasksBloc(TaskRepository())),
      ],
      child: const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: AllTaskPage()
      ),
    );
  }
}

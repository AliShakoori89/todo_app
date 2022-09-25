import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:todo_app/bloc/network_bloc/bloc.dart';
import 'package:todo_app/bloc/network_bloc/event.dart';
import 'package:todo_app/bloc/network_bloc/state.dart';
import 'package:todo_app/bloc/task_from_database_bloc/bloc.dart';
import 'package:todo_app/bloc/task_from_net_bloc/bloc.dart';
import 'package:todo_app/repository/task_repository.dart';
import 'package:todo_app/screen/from_data_base/all_task_from_data_base_page.dart';
import 'package:todo_app/screen/from_net/all_task_from_net_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
            create: (BuildContext context) => TaskFromNetBloc(TaskRepository())),
        BlocProvider(
            create: (BuildContext context) => TaskFromDataBaseBloc(TaskRepository())),
        BlocProvider(
          create: (context) => NetworkBloc()..add(NetworkObserve()),
        )
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<NetworkBloc, NetworkState>(
          builder: (context, state) {
            if (state is NetworkSuccess) {
              print('NetworkSuccess');
              return const AllTaskFromNetPage();
            } else {
              print('NetworkFailure');
              return const AllTaskFromDataBasePage();
            }
            // else {
            //   print("SizedBox.shrink");
            //   return const AllTaskFromDataBasePage();
            // }
          },
        ),
        // AllTaskPage()
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/bloc/task_from_database_bloc/bloc.dart';
import 'package:todo_app/bloc/task_from_database_bloc/state.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/screen/add_task_to_server.dart';
import 'package:todo_app/screen/read_task_page.dart';
import 'package:todo_app/utils/dimensions.dart';

import '../../bloc/task_from_database_bloc/event.dart';

class AllTaskFromDataBasePage extends StatefulWidget {
  const AllTaskFromDataBasePage({Key? key}) : super(key: key);

  @override
  State<AllTaskFromDataBasePage> createState() => _AllTaskFromDataBasePageState();
}

class _AllTaskFromDataBasePageState extends State<AllTaskFromDataBasePage>  {

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.white;
    }
    return Colors.black;
  }

  @override
  void initState() {
    BlocProvider.of<TaskFromDataBaseBloc>(context).add(GetAllTaskEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      // floatingActionButton: const MyFloatingActionButton(),
      body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(
                left: Dimensions.paddingWith_20,
                right: Dimensions.paddingWith_20,
                top: Dimensions.paddingHeight_30
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "All Tasks",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: Dimensions.fontSmallSize),
                ),
                SizedBox(
                  height: Dimensions.paddingHeight_20,
                ),
                Expanded(
                  child: BlocBuilder<TaskFromDataBaseBloc, TaskFromDataBaseState>(
                    builder: (context, state) {
                      if (state is TasksIsLoadingState) {
                        print('1111');

                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is TasksIsLoadedState) {
                        print('2222');

                        var task = state.allTask;

                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: task.length,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: EdgeInsets.only(top: Dimensions.paddingHeight_10),
                              child: Slidable(
                                key: const ValueKey(0),
                                endActionPane: ActionPane(
                                  extentRatio: 0.2,
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) => showDialog<String>(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.delete,
                                                color: Colors.red,
                                                size: Dimensions.iconMiddleSize,
                                              ),
                                              SizedBox(height: Dimensions.paddingHeight_40,),
                                              const Text('Are You Sure?!',
                                                  textAlign: TextAlign.center),
                                            ],
                                          ),
                                          actionsAlignment: MainAxisAlignment.spaceBetween,
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: (){
                                                final createTask =
                                                BlocProvider.of<TaskFromDataBaseBloc>(context);
                                                createTask.add(DeleteTaskEvent(id: task[index].id!));
                                                Navigator.pop(context, 'Delete');
                                              },
                                              child: const Text('Delete',
                                                style: TextStyle(color: Colors.red),),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, 'Cancel'),
                                              child: const Text('Cancel',
                                                style: TextStyle(color: Colors.black),),
                                            ),
                                          ],
                                        ),
                                      ),
                                      backgroundColor: const Color(0xFFFE4A49),
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                    ),
                                  ],
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    TaskModel taskModel = TaskModel();
                                    taskModel.id = task[index].id;
                                    taskModel.title = task[index].title;
                                    taskModel.description = task[index].description;
                                    taskModel.done = task[index].done == "false" ? false : true;
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => ReadTaskPage(
                                            task: taskModel,
                                            isChecked: task[index].done == "false"
                                                ? false
                                                : true
                                        )));
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: Dimensions.paddingHeight_40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(Dimensions.smallRadius),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: Dimensions.paddingWith_10,
                                          right: Dimensions.paddingWith_10),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('${task[index].title}'),
                                          Checkbox(
                                            fillColor:
                                            MaterialStateProperty.resolveWith(
                                                getColor),
                                            checkColor: Colors.white,
                                            value: task[index].done == "false" ? false : true ,
                                            onChanged: (bool? value) {},
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        );
                      }
                      if (state is TasksFailedState) {
                        print('3333');
                        return Center(
                            child: Text('Your app don\'t have iiiiiiiiinternet',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w700,
                                    fontSize: Dimensions.fontMiddleSize)));
                      } else {
                        print('444');
                        return Center(
                            child: Text('Your app don\'t have internetttttt',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w700,
                                    fontSize: Dimensions.fontMiddleSize)));
                      }
                    },
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
  void doNothing(BuildContext context) {

  }
}

class MyFloatingActionButton extends StatelessWidget {
  const MyFloatingActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'hero',
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddTaskFromNetPage()));
      },
      backgroundColor: Colors.white,
      elevation: 0,
      child: const Icon(
        Icons.add,
        color: Color.fromRGBO(22, 190, 105, 1),
        size: 30,),
    );
  }
}

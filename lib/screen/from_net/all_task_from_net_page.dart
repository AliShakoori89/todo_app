import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/bloc/task_from_net_bloc/bloc.dart';
import 'package:todo_app/bloc/task_from_net_bloc/state.dart';
import 'package:todo_app/component/add_floating_action_button.dart';
import 'package:todo_app/screen/add_task_to_server.dart';
import 'package:todo_app/screen/from_net/read_task_from_net_page.dart';
import 'package:todo_app/utils/dimensions.dart';
import '../../bloc/task_from_net_bloc/event.dart';

class AllTaskFromNetPage extends StatefulWidget {
  const AllTaskFromNetPage({Key? key}) : super(key: key);

  @override
  State<AllTaskFromNetPage> createState() => _AllTaskFromNetPageState();
}

class _AllTaskFromNetPageState extends State<AllTaskFromNetPage> {

  bool? isChecked;
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
    BlocProvider.of<TaskFromNetBloc>(context).add(GetAllTaskEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      floatingActionButton: const MyFloatingActionButton(),
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
            pageTitle(),
            SizedBox(
              height: Dimensions.paddingHeight_20,
            ),
            tasksCard()
          ],
        ),
        )
      ),
    );
  }

  Expanded tasksCard() {
    return Expanded(
            child: BlocBuilder<TaskFromNetBloc, TaskFromNetState>(
              builder: (context, state) {
                if (state is TasksIsLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is TasksIsLoadedState) {

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
                                          BlocProvider.of<TaskFromNetBloc>(context);
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
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ReadTaskFromNetPage(
                                        task: task[index],
                                        isChecked: task[index].done
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
                                      value: task[index].done ,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          isChecked = value!;
                                          task[index].done = isChecked;
                                          final createTask =
                                          BlocProvider.of<TaskFromNetBloc>(context);
                                          createTask.add(EditTaskEvent(
                                              taskModel: task[index]
                                          ));
                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => const AllTaskFromNetPage()));
                                        });

                                      },
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
                  return Center();
                } else {
                  return Center();
                }
              },
            ),
          );
  }
  Text pageTitle() {
    return Text(
            "All Tasks",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: Dimensions.fontSmallSize),
          );
  }
}
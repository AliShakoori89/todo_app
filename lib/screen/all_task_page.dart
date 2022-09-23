import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/bloc/task_bloc/bloc.dart';
import 'package:todo_app/bloc/task_bloc/event.dart';
import 'package:todo_app/bloc/task_bloc/state.dart';
import 'package:todo_app/screen/add_task_page.dart';
import 'package:todo_app/screen/read_task_page.dart';

class AllTaskPage extends StatefulWidget {
  const AllTaskPage({Key? key}) : super(key: key);

  @override
  State<AllTaskPage> createState() => _AllTaskPageState();
}

class _AllTaskPageState extends State<AllTaskPage> {

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
    print('QQQQQQQQQQQQQQQQQQQQQQQQQQQq');
    BlocProvider.of<TasksBloc>(context).add(const GetAllTaskEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[100],
      floatingActionButton: const MyFloatingActionButton(),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 30
          ),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "All Tasks",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: BlocBuilder<TasksBloc, TasksState>(
                builder: (context, state) {
                  if (state.status.isLoading) {
                    print('11111111111111111111111');

                    return const Padding(
                      padding: EdgeInsets.only(top: 300),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (state.status.isSuccess) {
                    print('2222222222222222222222');

                    var task = state.allTask;

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: task.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Slidable(
                            key: const ValueKey(0),
                            endActionPane: ActionPane(
                              extentRatio: 0.2,
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: doNothing,
                                  backgroundColor: const Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ReadTaskPage(
                                          task: task[index],
                                          isChecked: task[index].done,
                                        )));
                              },
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, right: 10),
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
                                        value: task[index].done,
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
                  if (state.status.isError) {
                    print('333333333333333333333');
                    return const SizedBox(
                      height: 500,
                      child: Center(
                          child: Text('Your app don\'t have internet',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 19))),
                    );
                  } else {
                    print('444444444444444444444444');
                    return const Padding(
                      padding: EdgeInsets.only(top: 300),
                      child: Center(
                          child: Text('Your app don\'t have internet',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 19))),
                    );
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
  void doNothing(BuildContext context) {}
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
            builder: (context) => const AddTaskPage()));
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
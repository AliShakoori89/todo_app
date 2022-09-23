import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:todo_app/bloc/task_bloc/bloc.dart';
import 'package:todo_app/bloc/task_bloc/event.dart';
import 'package:todo_app/screen/all_task_page.dart';
import '../custom_icon/my_flutter_app_icons.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(
            right: 10,
            left: 10,
            top: 20
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(MyFlutterApp.arrow_left_circle,
                      size: 26,)),
                  const Text("Add Task",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24
                  ),)
                ],
              ),
              const SizedBox(height: 20,),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    children: const [
                      Text("Title ",
                        style: TextStyle(
                          fontSize:14,
                          fontWeight: FontWeight.w500
                        ),),
                      Text("(Required)",
                      style: TextStyle(
                        fontSize: 12
                      ),)
                    ],
                  ),
                ),
                subtitle: TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    hintText: 'type your title',
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(215, 215, 215, 1)
                      )
                    )
                  ),
              ),
              const SizedBox(height: 20,),
              ListTile(
                title: const Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text("Description ",
                    style: TextStyle(
                        fontSize:14,
                        fontWeight: FontWeight.w500
                    ),),
                ),
                subtitle: Container(
                  height: 200,
                  child: TextFormField(
                    controller: descriptionController,
                      maxLines: 8,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8))),
                          hintText: 'type your title',
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(215, 215, 215, 1)
                          )
                      )
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                margin: const EdgeInsets.only(
                    right: 15,
                    left: 15,
                ),
                width: double.infinity,
                child: ElevatedButton(
                  style:  ElevatedButton.styleFrom(
                    elevation: 1,
                      primary: Colors.white),
                  child: const Text("Submit",
                  style: TextStyle(fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Color.fromRGBO(22, 190, 105, 1))),
                  onPressed: (){
                    final createTask =
                    BlocProvider.of<TasksBloc>(context);
                    createTask.add(AddNewTaskEvent(
                      title: titleController.text,
                      description: descriptionController.text
                    ));
                    Get.to(AllTaskPage());
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

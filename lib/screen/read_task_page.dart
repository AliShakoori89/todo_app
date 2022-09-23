import 'package:flutter/material.dart';
import 'package:todo_app/custom_icon/my_flutter_app_icons.dart';
import 'package:todo_app/model/task_model.dart';

class ReadTaskPage extends StatefulWidget {

  TaskModel? task;
  bool? isChecked;

  ReadTaskPage({Key? key, this.task, this.isChecked}): super(key: key);

  @override
  State<ReadTaskPage> createState() => _ReadTaskPageState(task, isChecked);
}

class _ReadTaskPageState extends State<ReadTaskPage> {

  TaskModel? task;
  bool? isChecked;

  _ReadTaskPageState(this.task, this.isChecked);

  @override
  Widget build(BuildContext context) {

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
                  Text('${task!.title}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24
                    ),)
                ],
              ),
              const SizedBox(height: 20,),
              Container(
                margin: const EdgeInsets.only(
                    right: 10,
                    left: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Container(
                  width: double.infinity,
                  height: 250,
                  margin: const EdgeInsets.only(
                    top: 10,
                    right: 10,
                    left: 10,
                    bottom: 10
                  ),
                  child: Text("${task!.description}",
                  style: const TextStyle(
                    color: Color.fromRGBO(130, 130, 130, 1)
                    )
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                margin: const EdgeInsets.only(right: 10, left: 10, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Have You Done This Task?",
                        style: TextStyle(
                            color: Color.fromRGBO(22, 190, 105, 1),
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                      ),
                    ),
                    Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                          print(isChecked);
                        });
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

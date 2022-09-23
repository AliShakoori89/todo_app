import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/network/api_base_helper.dart';

class TaskRepository{

  ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  Future<dynamic> getAllTask() async{
    var tasks = await _apiBaseHelper.get('/api/Task/GetAllTasks');
    print('!!!!!!!!!!!!!!!  '+ tasks.toString());
    return tasks;
  }

  Future<String> addTask(String title, String description) async {

    var body = jsonEncode({'title': title, 'description': description});

    print('{{{{{{{{{{{{    '+ body);

    final response = await _apiBaseHelper.post("/api/Task/CreateTask/", body);

    print('{{{{{{{{{{{{    '+ response);


    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.snackbar(
        backgroundColor: Colors.green,
        'successful',
        'add task successfully',
      );
      return 'success';
    }else{
      Get.snackbar(
        backgroundColor: Colors.red,
        'error',
        'No Internet connection',
      );
    }
    var parsedJson = json.decode(response.body);
    String message = parsedJson.values.elementAt(0);

    return message;
  }
}
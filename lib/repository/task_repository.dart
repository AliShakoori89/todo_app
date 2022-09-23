import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/network/api_base_helper.dart';

class TaskRepository{

  ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  Future<dynamic> getAllTask() async{
    var tasks = await _apiBaseHelper.get('/api/Task/GetAllTasks');
    return tasks;
  }

  Future<String> addTask(String title, String description) async {

    var body = jsonEncode({'title': title, 'description': description});

    final response = await _apiBaseHelper.post("/api/Task/CreateTask/", body);

    if(response.statusCode == 200 || response.statusCode == 201){
      return "success";
    }
    var parsedJson = json.decode(response.body);
    String message = parsedJson.values.elementAt(0);
    return message;
  }

  Future<String> editTask(int id, bool done) async {

    final response = await _apiBaseHelper.put("/api/Task/ChangeTaskStatus", id , done);

    print(response.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      return 'success';
    }
    var parsedJson = json.decode(response.body);
    String message = parsedJson.values.elementAt(0);

    return message;
  }
}
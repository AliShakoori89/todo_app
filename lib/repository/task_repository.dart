import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/database/database.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/model/task_model_for_data_base.dart';
import 'package:todo_app/network/api_base_helper.dart';

class TaskRepository{

  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();
  final DataBaseHelper _dataBaseHelper = DataBaseHelper();

  Future<dynamic> getAllTask() async{
    var tasks = await _apiBaseHelper.get('/api/Task/GetAllTasks');
    return tasks;
  }

  Future<String> addTask(TaskModel taskModel) async {

    var body = jsonEncode({'title': taskModel.title, 'description': taskModel.description});

    final response = await _apiBaseHelper.post("/api/Task/CreateTask/", body);

    TaskForDataBaseModel taskForDataBaseModel = TaskForDataBaseModel();
    taskForDataBaseModel.id = taskModel.id;
    taskForDataBaseModel.title = taskModel.title;
    taskForDataBaseModel.description = taskModel.description;
    taskForDataBaseModel.done = taskModel.done.toString();

    await _dataBaseHelper.saveTaskToDataBase(taskForDataBaseModel);
    if(response.statusCode == 200 || response.statusCode == 201){
      return "success";
    }
    var parsedJson = json.decode(response.body);
    String message = parsedJson.values.elementAt(0);
    return message;
  }

  Future<String> editTask(TaskModel taskModel) async {

    final response = await _apiBaseHelper.put("/api/Task/ChangeTaskStatus", taskModel.id! , taskModel.done!);

    TaskForDataBaseModel taskForDataBaseModel = TaskForDataBaseModel();
    taskForDataBaseModel.id = taskModel.id;
    taskForDataBaseModel.title = taskModel.title;
    taskForDataBaseModel.description = taskModel.description;
    taskForDataBaseModel.done = taskModel.done.toString();

    await _dataBaseHelper.updateTaskStatus(taskForDataBaseModel);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return 'success';
    }
    var parsedJson = json.decode(response.body);
    String message = parsedJson.values.elementAt(0);

    return message;
  }

  Future<String> deleteTask(int id) async{

    final response = await _apiBaseHelper.delete("/api/Task", id);
    await _dataBaseHelper.deleteTask(id);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return 'success';
    }
    var parsedJson = json.decode(response.body);
    String message = parsedJson.values.elementAt(0);

    return message;
  }

  Future<List<TaskForDataBaseModel>> getAllTaskFromDataBase() async {
    return await _dataBaseHelper.getAllTasks();
  }

  Future<bool> saveTaskToDataBase(TaskForDataBaseModel taskForDataBaseModel) async {
    return await _dataBaseHelper.saveTaskToDataBase(taskForDataBaseModel);
  }

  Future updateTaskToDataBase(TaskForDataBaseModel taskForDataBaseModel) async {
    return await _dataBaseHelper.updateTaskStatus(taskForDataBaseModel);
  }

  Future<int> deleteTaskFromDataBase(int id) async {
    return await _dataBaseHelper.deleteTask(id);
  }
}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/database/database.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/network/api_base_helper.dart';

class TaskRepository{

  ApiBaseHelper _apiBaseHelper = ApiBaseHelper();
  DataBaseHelper _dataBaseHelper = DataBaseHelper();

  Future<dynamic> getAllTask() async{

    var tasks = await _apiBaseHelper.get('/api/Task/GetAllTasks');
    return tasks;
  }

  Future<String> addTask(TaskModel taskModel) async {

    var body = jsonEncode({'title': taskModel.title, 'description': taskModel.description});

    final response = await _apiBaseHelper.post("/api/Task/CreateTask/", body);
    await _dataBaseHelper.saveTaskToDataBase(taskModel);
    if(response.statusCode == 200 || response.statusCode == 201){
      return "success";
    }
    var parsedJson = json.decode(response.body);
    String message = parsedJson.values.elementAt(0);
    return message;
  }

  Future<String> editTask(int id, bool done) async {

    final response = await _apiBaseHelper.put("/api/Task/ChangeTaskStatus", id , done);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return 'success';
    }
    var parsedJson = json.decode(response.body);
    String message = parsedJson.values.elementAt(0);

    return message;
  }

  Future<String> deleteTask(int id) async{
    final response = await _apiBaseHelper.delete("/api/Task", id);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return 'success';
    }
    var parsedJson = json.decode(response.body);
    String message = parsedJson.values.elementAt(0);

    return message;
  }

  // Future<List<TaskModel>> getAllTaskFromDataBase() async {
  //   print('AAAAAAAAAAAAAAA   ');
  //   return await _dataBaseHelper.getAllTasks();
  // }
  //
  // Future<bool> saveTaskToDataBaseRepo(TaskModel taskModel) async {
  //   print('TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT    ');
  //   return await _dataBaseHelper.saveTaskToDataBase(taskModel);
  // }
  //
  // Future updateCityWeatherRepo(TaskModel taskModel) async {
  //   return await _dataBaseHelper.updateTaskStatus(taskModel);
  // }
  //
  // Future<int> deleteCityWeatherDetailesRepo(int id) async {
  //   return await _dataBaseHelper.deleteTask(id);
  // }
}
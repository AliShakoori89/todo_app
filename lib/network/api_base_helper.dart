import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/network/http_exception.dart';

class ApiBaseHelper {
  final String _baseUrl = 'http://task.paratechco.com';

  Future<dynamic> get(String url) async {
    http.Response response = await http.get(Uri.parse(_baseUrl + url));
    return response;
  }

  Future<dynamic> post(String url, dynamic body) async {
    try {
      final response = await http.post(
          Uri.parse(_baseUrl+url),
          body: body,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },);
      Get.snackbar(
        backgroundColor: Colors.green[200],
        'successful',
        'add task successfully',
      );
      var responseJson = _returnResponse(response);
      return responseJson;

    } on SocketException {
      Get.snackbar(
        backgroundColor: Colors.red[200],
        'error',
        'No Internet connection',
      );
      throw FetchDataException('No Internet connection');
    }
  }

  Future<dynamic> put(String url, int id, bool done) async{
    var responseJson;
    try {
      final response = await http.put(
        Uri.parse("$_baseUrl$url?id=$id&done=$done"),
        headers: { "Content-Type" : "application/json"});

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url, int id) async {
    var apiResponse;
    try {
      final response = await http.put(
          Uri.parse("$_baseUrl$url?id=$id"),
          headers: { "Content-Type" : "application/json"});
      apiResponse = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return apiResponse;
  }
}

http.Response _returnResponse(http.Response response) {
  return response;
  // switch (response.statusCode) {
  //   case 200:
  //     var responseJson = json.decode(response.body.toString());
  //     print(responseJson);
  //     return responseJson;
  //   case 400:
  //     throw BadRequestException(response.body.toString());
  //   case 401:
  //   case 403:
  //     throw UnauthorisedException(response.body.toString());
  //   case 500:
  //   default:
  //     throw FetchDataException(
  //         'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  // }
}
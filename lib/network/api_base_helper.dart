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
      return response.statusCode;

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
    try {
      final response = await http.put(
        Uri.parse("$_baseUrl$url?id=$id&done=$done"),
        headers: { "Content-Type" : "application/json"});
      return response.statusCode;

    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }
}
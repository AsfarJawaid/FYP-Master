import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ApiHandler {
  static String baseUrl = "http://192.168.5.104:5000";

  static Dio dio = new Dio();

  Future makeGetRequest(@required String getRoute) async {
    return await dio.get(baseUrl + getRoute);
  }

  Future makePostRequest(@required String getRoute, @required data) async {
    var response = await dio.post(baseUrl + getRoute, data: data);
    return response;
  }

  Future makePutRequest(@required String getRoute, @required data) async {
    var response = await dio.put(baseUrl + getRoute, data: data);
    return response;
  }
}

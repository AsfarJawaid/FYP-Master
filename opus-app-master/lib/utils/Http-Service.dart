import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ApiHandler {
  static String baseUrl = "https://asfarjawaid.azurewebsites.net";
  static ApiHandler get getInstance {
    return ApiHandler();
  }

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

  Future<dynamic> deleteWorkerBooking({@required String getRoute}) async {
    return await dio.delete(baseUrl + getRoute).then((value) {
      return value;
    }).catchError((e) {
      log(e.toString());
    });
  }
}

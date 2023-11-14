import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioProvider {
  static const baseUrl = "http://192.168.1.47:8000/api";

  Future<bool> getToken(String email, String password) async {
    try {
      var response = await Dio().post(
        "$baseUrl/login",
        data: {
          "email": email,
          "password": password,
        },
        options: Options(
          contentType: Headers.jsonContentType,
          followRedirects: false,
          // validateStatus: (status) => true,
          headers: {
            "Accept": "application/json",
          },
        ),
      );

      // Store returned token to shared preferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response.data);

      final test = prefs.getString('token');
      log('prefs from getToken: ${test}');
      return true;
    } on DioError catch (err) {
      if (err.response != null) {
        log('Status: ${err.response!.statusCode}');
        log('Data: ${err.response!.data}');
      } else {
        // Something else happened, such as an error in sending the request
        log('Error message: ${err.message}');
      }
      return false;
    }
  }

  // Get user data
  Future<dynamic> getUser(String token) async {
    try {
      var response = await Dio().get(
        "$baseUrl/user",
        options: Options(
          headers: {
            "Authorization": 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      Map obj = response.data;
      return obj;
    } on DioError catch (err) {
      if (err.response != null) {
        log('Status: ${err.response!.statusCode}');
        log('Data: ${err.response!.data}');
      } else {
        // Something else happened, such as an error in sending the request
        log('Error message: ${err.message}');
      }
      // String error = err.response!.data;
      // return error; // Or handle the error accordingly
      return false;
    }
  }

  // Register user
  Future<bool> registerUser(
      String username, String email, String password) async {
    try {
      var response = await Dio().post(
        "$baseUrl/register",
        data: {
          "email": email,
          "password": password,
          "name": username,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
      );

      log('response: ${response}');
      // Map obj = response.data;
      return true;
    } on DioError catch (err) {
      if (err.response != null) {
        log('Status: ${err.response!.statusCode}');
        log('Data: ${err.response!.data}');
      } else {
        // Something else happened, such as an error in sending the request
        log('Error message: ${err.message}');
      }
      // String error = err.response!.data;
      // return error; // Or handle the error accordingly
      return false;
    }
  }
}

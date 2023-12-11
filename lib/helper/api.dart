import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/User.dart';
import '../utilities/shared_pref.dart';

class Api {
  final String baseUrl = 'https://student.valuxapps.com/api';
  Future<Map<String, dynamic>?> login(String eu, String password) async {
    final url = '$baseUrl/login';
    Map<String, dynamic>? data;
    try {
      final dio = Dio();
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      };

      final response = await dio.post(url, data: {
        'password': password,
        'email': eu,
      });

      print('login request response ${response.data}');

      if (response.statusCode == 200) {
        data = response.data;
      } else {
        print("========== ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      print('========== Error: $e');
      print('========== Error Stack Trace: $stackTrace');
    }
    return data;
  }













  Future<Map<String, dynamic>?> register(
    User user,
  ) async {
    final url = '$baseUrl/register';
    Map<String, dynamic>? data;
    try {
      final dio = Dio();
      FormData formData = FormData.fromMap({
        'name': user.name,
        'email': user.email,
        'password': user.password,
        'phone': user.phone,
      });
      final response = await dio.post(url, data: formData);

      print('register request response ${response.data}');

      if (response.statusCode == 200) {
        data = response.data;
      } else {
        print("========== ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      print('========== Error: $e');
      print('========== Error Stack Trace: $stackTrace');
    }
    return data;
  }




  Future<void> logout() async {
    final url = '$baseUrl/logout';
    try {
      final dio = Dio();
      final token = await getString('token');
      print('===$token');

      if (token != null) {
        dio.options.headers['Authorization'] = token;
      }

      final response = await dio.post(url);
      print('================$response');

      // Clear the token from shared preferences
    } catch (e, stackTrace) {
      print('========== Error: $e');
      print('========== Error Stack Trace: $stackTrace');
    }
  }









  // can include headerswhen auth
  Future<dynamic> get({required String url, @required String? token}) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    http.Response response = await http.get(Uri.parse(url),headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
      throw Exception('error data not valid ${response.statusCode}');
    }
  }
  // Future<Map<String, dynamic>> gett({required String url, required String token}) async {
  //   var headers = {
  //     'Authorization': 'Bearer $token',
  //     // Add any other necessary headers here
  //   };
  //
  //   try {
  //     var response = await http.get(Uri.parse(url), headers: headers);
  //
  //     if (response.statusCode == 200) {
  //       // Decode the response body as JSON
  //       var jsonResponse = json.decode(response.body);
  //       return jsonResponse; // Return the decoded JSON response as Map<String, dynamic>
  //     } else {
  //       throw Exception('Failed to fetch data');
  //     }
  //   } catch (e) {
  //     throw Exception('Error fetching data: $e');
  //   }
  // }

  Future<dynamic> post(
      {required String url,
      @required dynamic body,
      @required String? token}) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    http.Response response =
        await http.post(Uri.parse(url), body: body, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
          'error data not valid ${response.statusCode} with body ${jsonDecode(response.body)}');
      // can be       throw Exception($jsonDecode(response.body));
    }
  }

  Future<dynamic> put(
      {required String url,
      @required dynamic body,
      @required String? token}) async {
    Map<String, String> headers = {};
    headers.addAll({
      'Content-Type': 'application/x-www-form-urlencoded'
//headers can cause issues somyimes so its better to add this line
    });
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    http.Response response =
        await http.post(Uri.parse(url), body: body, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
          'error data not valid ${response.statusCode} with body ${jsonDecode(response.body)}');
      // can be       throw Exception($jsonDecode(response.body));
    }
  }
}

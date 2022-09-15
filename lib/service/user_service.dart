import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ones_blog/Constant.dart';
import 'package:ones_blog/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/api_response.dart';

//login
Future<ApiResponse> login(String email, String password, String deviceName) async {
  ApiResponse apiResponse = ApiResponse();

  try{
    print('1');
    final response = await http.post(
      Uri.parse(baseURL + loginUrl),
      headers: {'Accept' : 'application/json'},
      body: {
        'email':email,
        'password':password,
        'device_name': deviceName
      }
    );
    print(baseURL+loginUrl);
    switch(response.statusCode){
      case 200:
        print("2");
        apiResponse.data = UserModel.fromJson(jsonDecode(response.body));
        break;
      case 422:
        print("3");
        final errors = jsonDecode(response.body)['data'];
        print(jsonDecode(response.body)['data']);
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      default:
        print("5");
        apiResponse.error = somethingWentWrong;
        break;
    }
  }catch(e){
    print("6");
    print(e);
    apiResponse.error = serverError;
  }
  return apiResponse;
}

//register
Future<ApiResponse> register(String name, String email, String password, String deviceName) async {
  ApiResponse apiResponse = ApiResponse();
  try{
    print('11');
    final response = await http.post(
        Uri.parse(baseURL + registerUrl),
        headers: {'Accept' : 'application/json'},
        body: {
          'name':name,
          'email':email,
          'password':password,
          'password_confirmation':password,
          'device_name': deviceName
        }
    );
    switch(response.statusCode){
      case 201:
        print('22');
        apiResponse.data = UserModel.fromJson(jsonDecode(response.body));
        break;
      case 422:
        print('33');
        final errors = jsonDecode(response.body)['data'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      default:
        print('55');
        apiResponse.error = somethingWentWrong;
        break;
    }
  }catch(e){
    print('66');
    print(e);
    apiResponse.error = serverError;
  }
  return apiResponse;
}

//User
// Future<ApiResponse> getUserDetail() async{
//   ApiResponse apiResponse = ApiResponse();
//   try{
//     String token = await getToken();
//     final response = await http.get(
//       Uri.parse(baseURL + userUrl),
//       headers: {
//         'Accept' : 'application/json',
//         'token' : 'Bearer $token'
//       },
//     );
//     switch(response.statusCode){
//       case 200:
//         apiResponse.data = UserModel.fromJson(jsonDecode(response.body));
//         break;
//       case 401:
//         apiResponse.error = unauthorized;
//         break;
//       case 404:
//         final errors = jsonDecode(response.body)['data'];
//         apiResponse.error = errors[errors.keys.elementAt(0)][0];
//         break;
//       case 422:
//         final errors = jsonDecode(response.body)['data'];
//         apiResponse.error = errors[errors.keys.elementAt(0)][0];
//         break;
//       default:
//         apiResponse.error = somethingWentWrong;
//         break;
//     }
//   }catch(e){
//     apiResponse.error = serverError;
//   }
//   return apiResponse;
// }

//get token
Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('token') ?? '';
}

//get user email
Future<String> getUserEmail() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('email') ?? '';
}

//logout
Future<bool> logout() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return await pref.remove('token');
}
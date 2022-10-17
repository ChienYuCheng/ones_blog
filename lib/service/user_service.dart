import 'dart:convert';
import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ones_blog/Constant.dart';
import 'package:ones_blog/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/api_response.dart';

//login
Future<ApiResponse> login(String email, String password) async {
  ApiResponse apiResponse = ApiResponse();

  try{
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
        apiResponse.data = UserModel.fromJson(jsonDecode(response.body));
        print("登入成功");
        break;
      case 422:
        final errors = jsonDecode(response.body)['data'];
        print(jsonDecode(response.body)['data']);
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        print("422(login)");
        break;
      default:
        print("錯誤1");
        apiResponse.error = somethingWentWrong;
        break;
    }
  }catch(e){
    print("錯誤2");
    print(e);
    apiResponse.error = serverError;
  }
  return apiResponse;
}

//register
Future<ApiResponse> register(String name, String email, String password) async {
  ApiResponse apiResponse = ApiResponse();

  try{
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
        apiResponse.data = UserModel.fromJson(jsonDecode(response.body));
        print('註冊');
        break;
      case 422:
        final errors = jsonDecode(response.body)['data'];
        apiResponse.error = errors[errors.keys.elementAt(0)];
        print('422(register)');
        break;
      default:
        apiResponse.error = somethingWentWrong;
        print('Something went wrong!');
        break;
    }
  }catch(e){
    print('Server Error');
    print(e);
    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<ApiResponse> verifyCode(String name, String email, String code) async {
  ApiResponse apiResponse = ApiResponse();

  try{
    final response = await http.post(
        Uri.parse(baseURL + verifyUrl),
        headers: {'Accept' : 'application/json'},
        body: {
          'name' : name,
          'email': email,
          'code' : code
        }
    );
    switch(response.statusCode){
      case 200:
        apiResponse.data = UserModel.fromJson(jsonDecode(response.body));
        print('200 : 驗證');
        break;
      case 422:
        final errors = jsonDecode(response.body)['data'];
        apiResponse.error = errors[errors.keys.elementAt(0)];
        print('422(verifyCode)');
        break;
      default:
        apiResponse.error = somethingWentWrong;
        print('Something went wrong(verifyCode)!');
        break;
    }
  }catch(e){
    print('Server Error(verify)');
    print('catch error : $e');
    apiResponse.error = serverError;
  }
  return apiResponse;
}


// Future<String> getToken() async {
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   return pref.getString('token') ?? '';
// }
//
// //get user email
// Future<String> getUserEmail() async {
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   return pref.getString('email') ?? '';
// }

//logout
Future<bool> logout() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return await pref.remove('token');
}

DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
String deviceName = '';

Future<String?> loadDeviceInfo() async {
  try{
    if(kIsWeb){
      WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
      print('1 Running on ${webBrowserInfo.userAgent}');
      deviceName = webBrowserInfo.userAgent.toString();
      return webBrowserInfo.userAgent;
    }else if(Platform.isAndroid){
      AndroidDeviceInfo android = await deviceInfo.androidInfo;
      print('2 Running on ${android.brand}');
      deviceName = android.brand.toString();
      return deviceName;
    }else if(Platform.isIOS){
      IosDeviceInfo ios = await deviceInfo.iosInfo;
      print('3 Running on ${ios.utsname.machine}');
      deviceName = ios.utsname.machine.toString();
      return deviceName;
    }else if (Platform.isWindows) {
      WindowsDeviceInfo windowsInfo = await deviceInfo.windowsInfo;
      print(windowsInfo.toMap().toString());
      deviceName = windowsInfo.toMap().toString();
      return deviceName;
    }else if (Platform.isMacOS) {
      MacOsDeviceInfo macOSInfo = await deviceInfo.macOsInfo;
      print(macOSInfo.toMap().toString());
      deviceName = macOSInfo.toMap().toString();
      return deviceName;
    }else if (Platform.isLinux) {
      LinuxDeviceInfo linuxInfo = await deviceInfo.linuxInfo;
      print(linuxInfo.toMap().toString());
      deviceName = linuxInfo.toMap().toString();
      return deviceName;
    }
  }catch(e){
    print("Register Error");
    print(e);
  }
  return null;
}
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class UserModel{
  String name;
  String email;
  String password;
  String deviceName;
  String token;
  String code;

  UserModel({required this.name, required this.email, required this.password,required this.deviceName,required this.token, required this.code});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json['data']['name'],
        email: json['data']['email'],
        password: json['data']['password'],
        deviceName: json['data']['device_name'],
        token: json['data']['token'],
        code: json['data']['code']);
  }
}
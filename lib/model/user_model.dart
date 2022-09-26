// class UserModel{
//   Data data;
//
//   UserModel({required this.data});
//
//   factory UserModel.fromJson(Map<String, dynamic> parsedJson){
//     return UserModel(
//       data: Data.fromJson(parsedJson['data'])
//     );
//   }
// }
//
// class Data{
//   String name;
//   String email;
//   String password;
//   String token;
//
//   Data({required this.name, required this.email, required this.password, required this.token});
//
//   factory Data.fromJson(Map<String, dynamic> json) {
//     return Data(
//         name: json['name'],
//         email: json['email'],
//         password: json['password'],
//         token: json['token']
//     );
//   }
// }

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class UserModel{
  String name;
  String email;
  String token;
  String code;

  UserModel({required this.name, required this.email, required this.token, required this.code});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json['name'],
        email: json['email'],
        token: json['token'],
        code: json['code']);
  }
}
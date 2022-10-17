import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:ones_blog/Constant.dart';
import 'package:ones_blog/model/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/api_response.dart';
import '../model/location_model.dart';

class LocationRepository {
  static List<String> restaurantName = [];
  static List<String> restaurantAddress = [];
  static List<String> restaurantAvgScore = [];
  static List<String> restaurantPhone = [];
  static List<String> restaurantIntroduction = [];
  static List<String> restaurantCityAreaId = [];

  static List<String> spotName = [];
  static List<String> spotAddress = [];
  static List<String> spotAvgScore = [];
  static List<String> spotPhone = [];
  static List<String> spotIntroduction = [];

  static List<String> lodgingName = [];
  static List<String> lodgingAddress = [];
  static List<String> lodgingAvgScore = [];
  static List<String> lodgingPhone = [];
  static List<String> lodgingIntroduction = [];

  //首頁隨機餐廳
  Future<LocationModel> fetchRestaurantLocations(String categoryId) async {
    try{
      Uri uri = Uri.http('onesblog.herokuapp.com', '/api/locations',
          {'limit': '10', 'page': '1', 'random': '1', 'category_id': categoryId});
      print(uri);
      http.Response response =
      await http.get(uri, headers: {'Accept' : 'application/json'}); //發送請求
      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body);
        LocationModel locations = LocationModel.fromJson(jsonData);
        return locations;
      }else{
        throw Exception("Failed to load");
      }
    }catch(e){
      print(e.toString());
      throw e;
    }
  }
  //首頁餐廳(看更多、全部)
  Future<LocationModel> fetchAllRestaurantLocations() async {
    try{
      Uri uri = Uri.http('onesblog.herokuapp.com', '/api/locations',
          {'limit': '10', 'page': '1', 'category_id': '1'});
      print(uri);
      http.Response response =
      await http.get(uri, headers: {'Accept' : 'application/json'}); //發送請求
      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body);
        LocationModel locations = LocationModel.fromJson(jsonData);
        print('----------------');
        for(var i=0; i<restaurantName.length; i++){
          print(restaurantName[i]);
        }
        print('---------------');
        return locations;
      }else{
        throw Exception("Failed to load");
      }
    }catch(e){
      print(e.toString());
      throw e;
    }
  }
  //首頁隨機景點
  Future<LocationModel> fetchSpotLocations() async {
    try{
      Uri uri = Uri.http('onesblog.herokuapp.com', '/api/locations',
          {'limit': '10', 'page': '1', 'random': '1', 'category_id': '2'});
      print(uri);
      http.Response response =
      await http.get(uri, headers: {'Accept' : 'application/json'}); //發送請求
      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body);
        LocationModel locations = LocationModel.fromJson(jsonData);
        for(var i=0 ; i<locations.data.length;i++){
          spotName.add(locations.data[i].name);
        }
        for(var i=0 ; i<locations.data.length;i++){
          spotAvgScore.add(locations.data[i].avgScore);
        }
        for(var i=0 ; i<locations.data.length;i++){
          spotAddress.add(locations.data[i].address);
        }
        for(var i=0 ; i<locations.data.length;i++){
          spotPhone.add(locations.data[i].phone);
        }
        for(var i=0 ; i<locations.data.length;i++){
          spotIntroduction.add(locations.data[i].introduction);
        }
        // print('----------------');
        // for(var i=0; i<spotData.length; i++){
        //   print(spotData[i]);
        // }
        // print('---------------');
        return locations;
      }else{
        throw Exception("Failed to load");
      }
    }catch(e){
      print(e.toString());
      throw e;
    }
  }
  //首頁景點(看更多、全部)
  Future<LocationModel> fetchAllSpotLocations() async {
    try{
      Uri uri = Uri.http('onesblog.herokuapp.com', '/api/locations',
          {'limit': '10', 'page': '1', 'category_id': '2'});
      print(uri);
      http.Response response =
      await http.get(uri, headers: {'Accept' : 'application/json'}); //發送請求
      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body);
        LocationModel locations = LocationModel.fromJson(jsonData);
        print('----------------');
        for(var i=0; i<restaurantName.length; i++){
          print(restaurantName[i]);
        }
        print('---------------');
        return locations;
      }else{
        throw Exception("Failed to load");
      }
    }catch(e){
      print(e.toString());
      throw e;
    }
  }
  //首頁隨機旅宿
  Future<LocationModel> fetchLodgingLocations() async {
    try{
      Uri uri = Uri.http('onesblog.herokuapp.com', '/api/locations',
          {'limit': '10', 'page': '1', 'random': '1', 'category_id': '3'});
      print(uri);
      http.Response response =
      await http.get(uri, headers: {'Accept' : 'application/json'}); //發送請求
      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body);
        LocationModel locations = LocationModel.fromJson(jsonData);
        for(var i=0 ; i<locations.data.length;i++){
          lodgingName.add(locations.data[i].name);
        }
        for(var i=0 ; i<locations.data.length;i++){
          lodgingAvgScore.add(locations.data[i].avgScore);
        }
        for(var i=0 ; i<locations.data.length;i++){
          lodgingAddress.add(locations.data[i].address);
        }
        for(var i=0 ; i<locations.data.length;i++){
          lodgingPhone.add(locations.data[i].phone);
        }
        for(var i=0 ; i<locations.data.length;i++){
          lodgingIntroduction.add(locations.data[i].introduction);
        }
        // print('----------------');
        // for(var i=0; i<lodgingData.length; i++){
        //   print(lodgingData[i]);
        // }
        // print('---------------');
        return locations;
      }else{
        throw Exception("Failed to load");
      }
    }catch(e){
      print(e.toString());
      throw e;
    }
  }
  //首頁旅宿(看更多、全部)
  Future<LocationModel> fetchAllLodgingLocations() async {
    try{
      Uri uri = Uri.http('onesblog.herokuapp.com', '/api/locations',
          {'limit': '10', 'page': '1', 'category_id': '3'});
      print(uri);
      http.Response response =
      await http.get(uri, headers: {'Accept' : 'application/json'}); //發送請求
      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body);
        LocationModel locations = LocationModel.fromJson(jsonData);
        print('----------------');
        for(var i=0; i<restaurantName.length; i++){
          print(restaurantName[i]);
        }
        print('---------------');
        return locations;
      }else{
        throw Exception("Failed to load");
      }
    }catch(e){
      print(e.toString());
      throw e;
    }
  }

  Future<LocationModel> fetchLocations() async {
    try{
      Uri uri = Uri.http('onesblog.herokuapp.com', '/api/locations',
          {'limit': '10', 'page': '1'});
      print(uri);
      http.Response response =
      await http.get(uri, headers: {'Accept' : 'application/json'}); //發送請求
      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body);
        LocationModel locations = LocationModel.fromJson(jsonData);
        // print('----------------');
        // for(var i=0; i<restaurantName.length; i++){
        //   print(restaurantName[i]);
        // }
        // print('---------------');
        return locations;
      }else{
        throw Exception("Failed to load");
      }
    }catch(e){
      print(e.toString());
      throw e;
    }
  }
  Future<LocationModel> fetchLeaderBoardLocations(String categoryId) async {
    try{
      Uri uri = Uri.http('onesblog.herokuapp.com', '/api/locations',
          {'limit': '10', 'page': '1', 'ranking': '6', 'category_id':categoryId});
      print(uri);
      http.Response response =
      await http.get(uri, headers: {'Accept' : 'application/json'}); //發送請求
      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body);
        LocationModel locations = LocationModel.fromJson(jsonData);
        // print('----------------');
        // for(var i=0; i<restaurantName.length; i++){
        //   print(restaurantName[i]);
        // }
        // print('---------------');
        return locations;
      }else{
        throw Exception("Failed to load");
      }
    }catch(e){
      print(e.toString());
      throw e;
    }
  }
  //成為店家
  // Future<LocationModel> becomeStore() async {
  //   String token = await LocationRepository().getToken();
  //   try{
  //     Uri uri = Uri.http('onesblog.herokuapp.com', '/api/locations',
  //         {'limit': '10', 'page': '1'});
  //     print(uri);
  //     http.Response response =
  //     await http.post(uri, headers: {'Accept' : 'application/json','token' : 'Bearer $token'}); //發送請求
  //     if(response.statusCode == 200){
  //       final jsonData = jsonDecode(response.body);
  //       LocationModel locations = LocationModel.fromJson(jsonData);
  //       // print('----------------');
  //       // for(var i=0; i<restaurantName.length; i++){
  //       //   print(restaurantName[i]);
  //       // }
  //       // print('---------------');
  //       return locations;
  //     }else{
  //       throw Exception("Failed to load");
  //     }
  //   }catch(e){
  //     print(e.toString());
  //     throw e;
  //   }
  // }
  // int cityAreaId, int categoryId,
  Future<ApiResponse> becomeStore(int cityAreaId,int categoryId,String name, String address, String phone, String introduction,String token) async {
    ApiResponse apiResponse = ApiResponse();
    // String token = await LocationRepository().getToken();

    try{
      final response = await http.post(
          Uri.parse(baseURL + registerUrl),
          headers: {'Accept' : 'application/json', 'token' : 'Bearer $token'},
          body: {
            'city_area_id':cityAreaId,
            'category_id':categoryId,
            'name':name,
            'address':address,
            'phone':phone,
            'introduction':introduction,
          }
      );
      switch(response.statusCode){
        case 201:
          print('location created.');
          apiResponse.data = LocationModel.fromJson(jsonDecode(response.body));
          break;
        case 401:
          print('without personal access token.');
          final errors = jsonDecode(response.body)['data'];
          apiResponse.error = errors[errors.keys.elementAt(0)][0];
          break;
        case 422:
          print('any validation failed.');
          final errors = jsonDecode(response.body)['data'];
          apiResponse.error = errors[errors.keys.elementAt(0)][0];
          break;
        default:
          print('Something went wrong!');
          apiResponse.error = somethingWentWrong;
          break;
      }
    }catch(e){
      print('Server Error');
      print(e);
      apiResponse.error = serverError;
    }
    return apiResponse;
  }
  Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('token') ?? '';
  }
}
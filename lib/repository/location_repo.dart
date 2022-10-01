import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:ones_blog/Constant.dart';
import 'package:ones_blog/model/post_model.dart';

import '../model/location_model.dart';

class LocationRepository {
  static List<String> restaurantData = [];
  static List<String> spotData = [];
  static List<String> lodgingData = [];
  Future<LocationModel> fetchRestaurantLocations() async {
    try{
      Uri uri = Uri.http('onesblog.herokuapp.com', '/api/locations',
          {'limit': '10', 'page': '1', 'random': '1', 'category_id': '1'});
      print(uri);
      http.Response response =
      await http.get(uri, headers: {'Accept' : 'application/json'}); //發送請求
      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body);
        LocationModel locations = LocationModel.fromJson(jsonData);
        for(var i=0 ; i<locations.data.length;i++){
          // print(locations.data[i].name);
          restaurantData.add(locations.data[i].name+'\n'+locations.data[i].address);
        }
        print('----------------');
        for(var i=0; i<restaurantData.length; i++){
          print(restaurantData[i]);
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
          // print(locations.data[i].name);
          spotData.add(locations.data[i].name+'\n'+locations.data[i].address);
        }
        print('----------------');
        for(var i=0; i<spotData.length; i++){
          print(spotData[i]);
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
          // print(locations.data[i].name);
          lodgingData.add(locations.data[i].name+'\n'+locations.data[i].address);
        }
        print('----------------');
        for(var i=0; i<lodgingData.length; i++){
          print(lodgingData[i]);
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
}
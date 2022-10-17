import 'dart:convert';

import 'package:ones_blog/model/cities_model.dart';
import 'package:http/http.dart' as http;
import 'package:ones_blog/model/cityAreas_model.dart';


class CitiesRepository {
  static List<String> citiesList = [];
  static List<String> cityAreasList = [];
  static List<String> cityAreasId = [];
  Future<List<String>> fetchCities() async {
    try{
      Uri uri = Uri.http('onesblog.herokuapp.com', '/api/cities');
      print(uri);
      http.Response response =
      await http.get(uri, headers: {'Accept' : 'application/json'});//發送請求
      if(response.statusCode == 200){
        // List<String> items = [];
        var jsonData = jsonDecode(response.body);
        CitiesModel cities = CitiesModel.fromJson(jsonData);
        citiesList = [];
        for(var i=0;i<cities.data.length;i++){
          citiesList.add(cities.data[i].city);
        }
        return citiesList;
      }else{
        throw Exception("Failed to load");
      }
    }catch(e){
      print(e);
      throw e;
    }
  }
  Future<List<String>> fetchCityAreas(String cityId) async {
    try{
      Uri uri = Uri.http('onesblog.herokuapp.com', '/api/cities/$cityId');
      print(uri);
      http.Response response =
      await http.get(uri, headers: {'Accept' : 'application/json'});//發送請求
      if(response.statusCode == 200){
        // List<String> items = [];
        final jsonData = jsonDecode(response.body);
        CityAreasModel cityAreas = CityAreasModel.fromJson(jsonData);
        cityAreasList = [];
        for(var i=0;i<cityAreas.data.cityAreas.length;i++){
          cityAreasList.add(cityAreas.data.cityAreas[i].cityArea);
        }
        cityAreasId = [];
        for(var i=0;i<cityAreas.data.cityAreas.length;i++){
          cityAreasId.add(cityAreas.data.cityAreas[i].id.toString());
          // print('CITY AREAS ID : ${cityAreas.data.cityAreas[i].cityArea}, ID : ${cityAreas.data.cityAreas[i].id}');
        }
        print('city areas id: $cityAreasId');
        return cityAreasList;
      }else{
        throw Exception("Failed to load");
      }
      // final String response = await rootBundle.loadString('assets/raw/posts.json');
      // final data = await json.decode(response);
      // PostModel comments = PostModel.fromJson(data);
      // return comments;
    }catch(e){
      print(e);
      throw e;
    }
  }
}

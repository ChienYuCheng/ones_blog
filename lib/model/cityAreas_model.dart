// import 'dart:convert';
// class CityAreasModel{
//   Data data;
//
//   CityAreasModel({required this.data});
//
//   factory CityAreasModel.fromJson(Map<String, dynamic> json){
//     return CityAreasModel(
//         data: Data.fromJson(json['data']),
//     );
//   }
// }
// class Data{
//   int id;
//   String createdAt;
//   String updatedAt;
//   String city;
//   List<Data> cityAreas;
//
//   Data({required this.id,required this.createdAt, required this.updatedAt,required this.city,required this.cityAreas});
//
//   factory Data.fromJson(Map<String, dynamic> json){
//
//     var list = json['city_areas'] as List;
//     print(list.runtimeType);
//     List<Data> cityAreasList = list.map((i) => Data.fromJson(i)).toList();
//
//     return Data(
//       id: json['id'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//       city: json['city'],
//       cityAreas:cityAreasList
//     );
//   }
// }
// class CityAreas {
//   int id;
//   String createdAt;
//   String updatedAt;
//   int cityId;
//   String cityArea;
//   String zipCode;
//
//   CityAreas({
//     required this.id,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.cityId,
//     required this.cityArea,
//     required this.zipCode
//   });
//
//   factory CityAreas.fromJson(Map<String, dynamic> json){
//     return CityAreas(
//       id: json['id'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//       cityId: json['city_id'],
//       cityArea: json['city_area'],
//       zipCode: json['zip_code'],
//     );
//   }
// }

// To parse this JSON data, do
//
//     final cityAreasModel = cityAreasModelFromJson(jsonString);

import 'dart:convert';
//
// CityAreasModel cityAreasModelFromJson(String str) => CityAreasModel.fromJson(json.decode(str));
//
// String cityAreasModelToJson(CityAreasModel data) => json.encode(data.toJson());

class CityAreasModel {
  Data data;

  CityAreasModel({required this.data});

  factory CityAreasModel.fromJson(Map<String, dynamic> json) => CityAreasModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  int id;
  String createdAt;
  String updatedAt;
  String city;
  List<CityArea> cityAreas;
  Data({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.city,
    required this.cityAreas,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    city: json["city"],
    cityAreas: List<CityArea>.from(json["city_areas"].map((x) => CityArea.fromJson(x))),
  );
}

class CityArea {
  CityArea({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.cityId,
    required this.cityArea,
    required this.zipCode,
  });

  int id;
  String createdAt;
  String updatedAt;
  int cityId;
  String cityArea;
  String zipCode;

  factory CityArea.fromJson(Map<String, dynamic> json) => CityArea(
    id: json["id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    cityId: json["city_id"],
    cityArea: json["city_area"],
    zipCode: json["zip_code"],
  );
}

class CitiesModel{
  List<Data> data;

  CitiesModel({required this.data});

  factory CitiesModel.fromJson(Map<String, dynamic> json){

    final data = json['data'] as List;
    List<Data> dataList = data.map((e) => Data.fromJson(e)).toList();

    return CitiesModel(
        data: dataList,
    );
  }
}

class Data {
  int id;
  String createdAt;
  String updateAt;
  String city;

  Data({required this.id, required this.createdAt, required this.updateAt, required this.city});

  factory Data.fromJson(Map<String, dynamic> json){

    return Data(
        id: json['id'],
        createdAt: json['created_at'],
        updateAt: json['updated_at'],
        city: json['city']);
  }
}
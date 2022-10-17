import 'dart:ui';

class LocationModel{
  List<Data> data;
  Links links;
  Meta meta;

  LocationModel({required this.data, required this.links, required this.meta});

  factory LocationModel.fromJson(Map<String, dynamic> json){

    final data = json['data'] as List;
    List<Data> dataList = data.map((e) => Data.fromJson(e)).toList();

    Links linksList = Links.fromJson(json['links']);

    Meta metaList = Meta.fromJson(json['meta']);

    return LocationModel(
        data: dataList,
        links: linksList,
        meta: metaList
    );
  }
}
class Data {
  int userId;
  int cityAreaId;
  int categoryId;
  String name;
  String address;
  String phone;
  String avgScore;
  String introduction;

  Data({required this.userId,
        required this.cityAreaId,
        required this.categoryId,
        required this.name,
        required this.address,
        required this.phone,
        required this.avgScore,
        required this.introduction});

  factory Data.fromJson(Map<String, dynamic> json){

    return Data(
        userId: json['user_id'],
        cityAreaId: json['city_area_id'],
        categoryId: json['category_id'],
        name: json['name'],
        address: json['address'],
        phone: json['phone'],
        avgScore: json['avgScore'],
        introduction: json['introduction'],
    );
  }
}
class Links {
  String first;
  String last;
  String prev;
  String next;

  Links({required this.first, required this.last, required this.prev, required this.next});

  factory Links.fromJson(Map<String, dynamic> json){
    return Links(
        first: json['first'],
        last: json['last'],
        prev: json['prev'] != null ? json['prev'] : "null",
        next: json['next'] != null ? json['next'] : "null"
    );
  }
}
class Meta {
  int currentPage;
  int from;
  int lastPage;
  List<Link> link;
  String path;
  int perPage;
  int to;
  int total;

  Meta(
      {required this.currentPage,
        required this.from,
        required this.lastPage,
        required this.link,
        required this.path,
        required this.perPage,
        required this.to,
        required this.total});

  factory Meta.fromJson(Map<String, dynamic> json){

    final origin = json['links'] as List;
    List<Link> linksData = origin.map((e) => Link.fromJson(e)).toList();

    return Meta(
      currentPage: json['current_page'],
      from: json['from'],
      lastPage: json['last_page'],
      link: linksData,
      path: json['path'],
      perPage: json['per_page'],
      to: json['to'],
      total: json['total'],
    );
  }
}
class Link {
  String url;
  String label;
  bool active;

  Link({required this.url, required this.label, required this.active});

  factory Link.fromJson(Map<String, dynamic> json){
    return Link(
      url: json['url'] != null ? json['url'] : "null",
      label: json['label'],
      active: json['active'],
    );
  }
}
//posts.json是一個具有列表的巢狀結構，本身還是一個Map(花括號開始就是Map,方括號開始就是list of map)

class PostModel{
  List<Data> data;
  Links links;
  Meta meta;

  PostModel({required this.data, required this.links, required this.meta});

  factory PostModel.fromJson(Map<String, dynamic> json){

    final data = json['data'] as List;
    List<Data> dataList = data.map((e) => Data.fromJson(e)).toList();

    Links linksList = Links.fromJson(json['links']);

    Meta metaList = Meta.fromJson(json['meta']);

    return PostModel(
      data: dataList,
      links: linksList,
      meta: metaList
    );
  }
}

class Data {
  String createdAt;
  User user;
  int storeId;
  int categoryId;
  String title;
  String content;
  String publishedAt;
  String slug;

  Data(
      {required this.createdAt,
        required this.user,
        required this.storeId,
        required this.categoryId,
        required this.title,
        required this.content,
        required this.publishedAt,
        required this.slug});

  factory Data.fromJson(Map<String, dynamic> json){

    User user = User.fromJson(json['user']);

    return Data(
      createdAt: json['created_at'],
      user: user,
      storeId: json['store_id'],
      categoryId: json['category_id'],
      title: json['title']as String,
      content: json['content']as String,
      publishedAt: json['published_at']as String,
      slug: json['slug']as String
    );
  }
}

class User {
  int id;
  String createdAt;
  String updatedAt;
  String name;
  String email;
  String emailVerifiedAt;
  bool isStore;
  int loginTypeId;

  User(
      { required this.id,
        required this.createdAt,
        required this.updatedAt,
        required this.name,
        required this.email,
        required this.emailVerifiedAt,
        required this.isStore,
        required this.loginTypeId});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json['id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      isStore: json['is_store'],
      loginTypeId: json['login_type_id']
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
  String perPage;
  int to;
  int total;

  Meta(
      { required this.currentPage,
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
      total: json['total']
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
      active: json['active']
    );
  }
}
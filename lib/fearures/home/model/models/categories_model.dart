class CategoriesModel {
  int? id;
  String? name;
  String? slug;
  int? parent;
  String? description;
  String? display;
  dynamic image;
  int? menuOrder;
  int? count;
  Links? links;

  CategoriesModel({
    this.id,
    this.name,
    this.slug,
    this.parent,
    this.description,
    this.display,
    this.image,
    this.menuOrder,
    this.count,
    this.links,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    parent: json["parent"],
    description: json["description"],
    display: json["display"],
    image: json["image"],
    menuOrder: json["menu_order"],
    count: json["count"],
    links: json["_links"] == null ? null : Links.fromJson(json["_links"]),
  );

}

class Links {
  List<Self>? self;
  List<Collection>? collection;

  Links({
    this.self,
    this.collection,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    self: json["self"] == null ? [] : List<Self>.from(json["self"]!.map((x) => Self.fromJson(x))),
    collection: json["collection"] == null ? [] : List<Collection>.from(json["collection"]!.map((x) => Collection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "self": self == null ? [] : List<dynamic>.from(self!.map((x) => x.toJson())),
    "collection": collection == null ? [] : List<dynamic>.from(collection!.map((x) => x.toJson())),
  };
}

class Collection {
  String? href;

  Collection({
    this.href,
  });

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "href": href,
  };
}

class Self {
  String? href;
  TargetHints? targetHints;

  Self({
    this.href,
    this.targetHints,
  });

  factory Self.fromJson(Map<String, dynamic> json) => Self(
    href: json["href"],
    targetHints: json["targetHints"] == null ? null : TargetHints.fromJson(json["targetHints"]),
  );

  Map<String, dynamic> toJson() => {
    "href": href,
    "targetHints": targetHints?.toJson(),
  };
}

class TargetHints {
  List<String>? allow;

  TargetHints({
    this.allow,
  });

  factory TargetHints.fromJson(Map<String, dynamic> json) => TargetHints(
    allow: json["allow"] == null ? [] : List<String>.from(json["allow"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "allow": allow == null ? [] : List<dynamic>.from(allow!.map((x) => x)),
  };
}
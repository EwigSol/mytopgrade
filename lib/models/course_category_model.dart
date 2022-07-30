
import 'dart:convert';

List<CourseCategoryModel> courseCategoryModelFromJson(String str) => List<CourseCategoryModel>.from(json.decode(str).map((x) => CourseCategoryModel.fromJson(x)));

class CourseCategoryModel {
  CourseCategoryModel({this.id, this.count, this.description, this.link, this.name,
    this.slug, this.taxonomy, this.parent, this.meta, this.links,
  });

  int? id;
  int? count;
  String? description;
  String? link;
  String? name;
  String? slug;
  String? taxonomy;
  int? parent;
  List<dynamic>? meta;
  Links? links;

  factory CourseCategoryModel.fromJson(Map<String, dynamic> json) => CourseCategoryModel(
    id: json["id"],
    count: json["count"],
    description: json["description"],
    link: json["link"],
    name: json["name"],
    slug: json["slug"],
    taxonomy: json["taxonomy"],
    parent: json["parent"],
    meta: List<dynamic>.from(json["meta"].map((x) => x)),
    links: Links.fromJson(json["_links"]),
  );
}

class Links {
  Links({this.self, this.collection, this.about, this.wpPostType, this.curies});

  List<About>? self;
  List<About>? collection;
  List<About>? about;
  List<About>? wpPostType;
  List<Cury>? curies;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    self: List<About>.from(json["self"].map((x) => About.fromJson(x))),
    collection: List<About>.from(json["collection"].map((x) => About.fromJson(x))),
    about: List<About>.from(json["about"].map((x) => About.fromJson(x))),
    wpPostType: List<About>.from(json["wp:post_type"].map((x) => About.fromJson(x))),
    curies: List<Cury>.from(json["curies"].map((x) => Cury.fromJson(x))),
  );
}

class About {
  About({this.href});

  String? href;

  factory About.fromJson(Map<String, dynamic> json) => About(href: json["href"]);

}

class Cury {
  Cury({this.name, this.href, this.templated});

  String? name;
  String? href;
  bool? templated;

  factory Cury.fromJson(Map<String, dynamic> json) => Cury(
    name: json["name"],
    href: json["href"],
    templated: json["templated"],
  );

}

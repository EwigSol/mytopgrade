

import 'dart:convert';

WishlistModel wishlistModelFromJson(String str) => WishlistModel.fromJson(json.decode(str));


class WishlistModel {
  WishlistModel({this.status, this.message, this.data});

  String? status;
  String? message;
  Data? data;

  factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  Data({this.items});

  List<DataItem>? items;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    items: List<DataItem>.from(json["items"].map((x) => DataItem.fromJson(x))),
  );
}

class DataItem {
  DataItem({this.id, this.name, this.slug, this.permalink, this.image,
    this.dateCreated, this.dateCreatedGmt, this.dateModified, this.dateModifiedGmt,
    this.onSale, this.status, this.content, this.excerpt, this.duration,
    this.countStudents, this.canFinish, this.canRetake, this.ratakeCount, this.rataken,
    this.rating, this.price, this.originPrice, this.salePrice, this.categories,
    this.tags, this.instructor, this.sections, this.courseData});

  int? id;
  String? name;
  String? slug;
  String? permalink;
  String? image;
  DateTime? dateCreated;
  DateTime? dateCreatedGmt;
  DateTime? dateModified;
  DateTime? dateModifiedGmt;
  bool? onSale;
  String? status;
  String? content;
  String? excerpt;
  String? duration;
  int? countStudents;
  bool? canFinish;
  bool? canRetake;
  int? ratakeCount;
  int? rataken;
  int? rating;
  int? price;
  int? originPrice;
  int? salePrice;
  List<Category>? categories;
  List<Category>? tags;
  Instructor? instructor;
  List<Section>? sections;
  CourseData? courseData;

  factory DataItem.fromJson(Map<String, dynamic> json) => DataItem(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    permalink: json["permalink"],
    image: json["image"],
    dateCreated: DateTime.parse(json["date_created"]),
    dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
    dateModified: DateTime.parse(json["date_modified"]),
    dateModifiedGmt: DateTime.parse(json["date_modified_gmt"]),
    onSale: json["on_sale"],
    status: json["status"],
    content: json["content"],
    excerpt: json["excerpt"],
    duration: json["duration"],
    countStudents: json["count_students"],
    canFinish: json["can_finish"],
    canRetake: json["can_retake"],
    ratakeCount: json["ratake_count"],
    rataken: json["rataken"],
    rating: json["rating"],
    price: json["price"],
    originPrice: json["origin_price"],
    salePrice: json["sale_price"],
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    tags: List<Category>.from(json["tags"].map((x) => Category.fromJson(x))),
    instructor: Instructor.fromJson(json["instructor"]),
    sections: List<Section>.from(json["sections"].map((x) => Section.fromJson(x))),
    courseData: CourseData.fromJson(json["course_data"]),
  );
}

class Category {
  Category({this.id, this.name, this.slug});

  int? id;
  String? name;
  String? slug;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
  );
}

class CourseData {
  CourseData({this.graduation, this.status, this.startTime, this.endTime, this.expirationTime, this.result});

  String? graduation;
  String? status;
  DateTime? startTime;
  dynamic endTime;
  DateTime? expirationTime;
  Result? result;

  factory CourseData.fromJson(Map<String, dynamic> json) => CourseData(
    graduation: json["graduation"],
    status: json["status"],
    startTime: DateTime.parse(json["start_time"]),
    endTime: json["end_time"],
    expirationTime: DateTime.parse(json["expiration_time"]),
    result: Result.fromJson(json["result"]),
  );
}

class Result {
  Result({this.result, this.pass, this.countItems, this.completedItems, this.items, this.evaluateType});

  int? result;
  int? pass;
  int? countItems;
  int? completedItems;
  Items? items;
  String? evaluateType;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    result: json["result"],
    pass: json["pass"],
    countItems: json["count_items"],
    completedItems: json["completed_items"],
    items: Items.fromJson(json["items"]),
    evaluateType: json["evaluate_type"],
  );
}

class Items {
  Items({this.lesson, this.quiz, this.assignment});

  Assignment? lesson;
  Assignment? quiz;
  Assignment? assignment;

  factory Items.fromJson(Map<String, dynamic> json) => Items(
    lesson: Assignment.fromJson(json["lesson"]),
    quiz: Assignment.fromJson(json["quiz"]),
    assignment: Assignment.fromJson(json["assignment"]),
  );
}

class Assignment {
  Assignment({this.completed, this.passed, this.total});

  int? completed;
  int? passed;
  int? total;

  factory Assignment.fromJson(Map<String, dynamic> json) => Assignment(
    completed: json["completed"],
    passed: json["passed"],
    total: json["total"],
  );
}

class Instructor {
  Instructor({this.avatar, this.id, this.name, this.description, this.social});

  String? avatar;
  int? id;
  String? name;
  String? description;
  Social? social;

  factory Instructor.fromJson(Map<String, dynamic> json) => Instructor(
    avatar: json["avatar"],
    id: json["id"],
    name: json["name"],
    description: json["description"],
    social: Social.fromJson(json["social"]),
  );
}

class Social {
  Social({this.facebook, this.twitter, this.youtube, this.linkedin});

  String? facebook;
  String? twitter;
  String? youtube;
  String? linkedin;

  factory Social.fromJson(Map<String, dynamic> json) => Social(
    facebook: json["facebook"],
    twitter: json["twitter"],
    youtube: json["youtube"],
    linkedin: json["linkedin"],
  );
}

class Section {
  Section({this.id, this.title, this.courseId, this.description, this.order, this.items});

  String? id;
  String? title;
  int? courseId;
  String? description;
  String? order;
  List<SectionItem>? items;

  factory Section.fromJson(Map<String, dynamic> json) => Section(
    id: json["id"],
    title: json["title"],
    courseId: json["course_id"],
    description: json["description"],
    order: json["order"],
    items: List<SectionItem>.from(json["items"].map((x) => SectionItem.fromJson(x))),
  );
}

class SectionItem {
  SectionItem({this.id, this.type, this.title, this.preview, this.duration, this.graduation, this.status, this.locked});

  int? id;
  Type? type;
  String? title;
  bool? preview;
  String? duration;
  String? graduation;
  String? status;
  bool? locked;

  factory SectionItem.fromJson(Map<String, dynamic> json) => SectionItem(
    id: json["id"],
    type: typeValues.map![json["type"]],
    title: json["title"],
    preview: json["preview"],
    duration: json["duration"],
    graduation: json["graduation"],
    status: json["status"],
    locked: json["locked"],
  );
}

enum Type { lesson, assignment, quiz }

final typeValues = EnumValues({
  "lp_assignment": Type.assignment,
  "lp_lesson": Type.lesson,
  "lp_quiz": Type.quiz
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map!.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}

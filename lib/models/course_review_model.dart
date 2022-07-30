

import 'dart:convert';

CourseReviewModel courseReviewModelFromJson(String str) => CourseReviewModel.fromJson(json.decode(str));


class CourseReviewModel {
  CourseReviewModel({this.status, this.message, this.data});

  String? status;
  String? message;
  Data? data;

  factory CourseReviewModel.fromJson(Map<String, dynamic> json) => CourseReviewModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  Data({this.rated, this.total, this.items, this.reviews, this.canReview});

  int? rated;
  int? total;
  Map<String, Item>? items;
  Reviews? reviews;
  bool? canReview;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    rated: json["rated"],
    total: json["total"],
    items: Map.from(json["items"]).map((k, v) => MapEntry<String, Item>(k, Item.fromJson(v))),
    reviews: Reviews.fromJson(json["reviews"]),
    canReview: json["can_review"],
  );
}

class Item {
  Item({this.rated, this.total, this.percent});

  int? rated;
  int? total;
  int? percent;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    rated: json["rated"],
    total: json["total"],
    percent: json["percent"],
  );
}

class Reviews {
  Reviews({this.reviews, this.paged, this.total, this.perPage});

  List<dynamic>? reviews;
  int? paged;
  int? total;
  int? perPage;

  factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
    reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
    paged: json["paged"],
    total: json["total"],
    perPage: json["per_page"],
  );

}

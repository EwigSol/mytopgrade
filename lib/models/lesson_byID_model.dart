


import 'dart:convert';

LessonByIdModel lessonByIdModelFromJson(String str) => LessonByIdModel.fromJson(json.decode(str));


class LessonByIdModel {
  LessonByIdModel({this.id, this.name, this.slug, this.permalink, this.dateCreated, this.dateCreatedGmt,
    this.dateModified, this.dateModifiedGmt, this.status, this.content, this.excerpt,
    this.canFinishCourse, this.duration, this.assigned, this.results, this.metaData,
  });

  int? id;
  String? name;
  String? slug;
  String? permalink;
  DateTime? dateCreated;
  DateTime? dateCreatedGmt;
  DateTime? dateModified;
  DateTime? dateModifiedGmt;
  String? status;
  String? content;
  String? excerpt;
  bool? canFinishCourse;
  String? duration;
  Assigned? assigned;
  Results? results;
  MetaData? metaData;

  factory LessonByIdModel.fromJson(Map<String, dynamic> json) => LessonByIdModel(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    permalink: json["permalink"],
    dateCreated: DateTime.parse(json["date_created"]),
    dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
    dateModified: DateTime.parse(json["date_modified"]),
    dateModifiedGmt: DateTime.parse(json["date_modified_gmt"]),
    status: json["status"],
    content: json["content"],
    excerpt: json["excerpt"],
    canFinishCourse: json["can_finish_course"],
    duration: json["duration"],
    assigned: Assigned.fromJson(json["assigned"]),
    results: Results.fromJson(json["results"]),
    metaData: MetaData.fromJson(json["meta_data"]),
  );
}

class Assigned {
  Assigned({this.course});

  Course? course;

  factory Assigned.fromJson(Map<String, dynamic> json) => Assigned(
    course: Course.fromJson(json["course"]),
  );
}

class Course {
  Course({this.id, this.title, this.slug, this.content, this.author});

  String? id;
  String? title;
  String? slug;
  String? content;
  String? author;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    content: json["content"],
    author: json["author"],
  );
}

class MetaData {
  MetaData({this.lpDuration, this.lpPreview});

  String? lpDuration;
  String? lpPreview;

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
    lpDuration: json["_lp_duration"],
    lpPreview: json["_lp_preview"],
  );
}

class Results {
  Results({this.status});

  String? status;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    status: json["status"],
  );
}


import 'dart:convert';

List<LessonsModel> lessonsModelFromJson(String str) => List<LessonsModel>.from(json.decode(str).map((x) => LessonsModel.fromJson(x)));


class LessonsModel {
  LessonsModel({this.id, this.name, this.slug, this.permalink, this.dateCreated, this.dateCreatedGmt,
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
  Status? status;
  String? content;
  String? excerpt;
  bool? canFinishCourse;
  String? duration;
  Assigned? assigned;
  Results? results;
  MetaData? metaData;

  factory LessonsModel.fromJson(Map<String, dynamic> json) => LessonsModel(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    permalink: json["permalink"],
    dateCreated: DateTime.parse(json["date_created"]),
    dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
    dateModified: DateTime.parse(json["date_modified"]),
    dateModifiedGmt: DateTime.parse(json["date_modified_gmt"]),
    status: statusValues.map![json["status"]],
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
  Title? title;
  Slug? slug;
  String? content;
  String? author;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    id: json["id"],
    title: titleValues.map![json["title"]],
    slug: slugValues.map![json["slug"]],
    content: json["content"],
    author: json["author"],
  );
}

enum Slug { ss1FreeVideoSampleLessonsEnglish, ss3OnlineVideoLessonsForHomeSchooling }

final slugValues = EnumValues({
  "sss1-free-video-sample-lessons-englishetc": Slug.ss1FreeVideoSampleLessonsEnglish,
  "sss3-online-video-lessons-for-homeschooling": Slug.ss3OnlineVideoLessonsForHomeSchooling
});

enum Title { ss1FreeLessons, ss3VideoLessons }

final titleValues = EnumValues({
  "SSS1 Free Lessons": Title.ss1FreeLessons,
  "SSS3 Video Lessons": Title.ss3VideoLessons
});

class MetaData {
  MetaData({this.lpDuration, this.lpPreview});

  String? lpDuration;
  LpPreview? lpPreview;

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
    lpDuration: json["_lp_duration"],
    lpPreview: lpPreviewValues.map![json["_lp_preview"]],
  );
}

enum LpPreview { no }

final lpPreviewValues = EnumValues({"no": LpPreview.no});

class Results {
  Results({this.status});

  String? status;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    status: json["status"],
  );
}

enum Status { publish }

final statusValues = EnumValues({"publish": Status.publish});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map!.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}

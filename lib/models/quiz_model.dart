

import 'dart:convert';

List<QuizModel> quizModelFromJson(String str) => List<QuizModel>.from(json.decode(str).map((x) => QuizModel.fromJson(x)));


class QuizModel {
  QuizModel({this.id, this.name, this.slug, this.permalink, this.dateCreated,
    this.dateCreatedGmt, this.dateModified, this.dateModifiedGmt, this.status, this.content, this.excerpt,
    this.canFinishCourse, this.duration, this.assigned, this.questions, this.results, this.metaData,
  });

  int? id;
  String? name;
  String? slug;
  bool? permalink;
  DateTime? dateCreated;
  DateTime? dateCreatedGmt;
  DateTime? dateModified;
  DateTime? dateModifiedGmt;
  Status? status;
  String? content;
  String? excerpt;
  bool? canFinishCourse;
  Duration? duration;
  List<dynamic>? assigned;
  List<dynamic>? questions;
  List<dynamic>? results;
  MetaData? metaData;

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
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
    duration: durationValues.map![json["duration"]],
    assigned: List<dynamic>.from(json["assigned"].map((x) => x)),
    questions: List<dynamic>.from(json["questions"].map((x) => x)),
    results: List<dynamic>.from(json["results"].map((x) => x)),
    metaData: MetaData.fromJson(json["meta_data"]),
  );
}

enum Duration { the10Minutes, the30Minutes, lifeTime }

final durationValues = EnumValues({
  "Lifetime": Duration.lifeTime,
  "10 minutes": Duration.the10Minutes,
  "30 minutes": Duration.the30Minutes
});

class MetaData {
  MetaData({this.lpRandomMode, this.lpDuration, this.lpPassingGrade,
    this.lpInstantCheck, this.lpNegativeMarking, this.lpMinusSkipQuestions,
    this.lpRetakeCount, this.lpPagination, this.lpReview, this.lpShowCorrectReview,
  });

  String? lpRandomMode;
  LpDuration? lpDuration;
  String? lpPassingGrade;
  String? lpInstantCheck;
  Lp? lpNegativeMarking;
  Lp? lpMinusSkipQuestions;
  String? lpRetakeCount;
  String? lpPagination;
  String? lpReview;
  String? lpShowCorrectReview;

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
    lpRandomMode: json["_lp_random_mode"],
    lpDuration: lpDurationValues.map![json["_lp_duration"]],
    lpPassingGrade: json["_lp_passing_grade"],
    lpInstantCheck: json["_lp_instant_check"],
    lpNegativeMarking: lpValues.map![json["_lp_negative_marking"]],
    lpMinusSkipQuestions: lpValues.map![json["_lp_minus_skip_questions"]],
    lpRetakeCount: json["_lp_retake_count"],
    lpPagination: json["_lp_pagination"],
    lpReview: json["_lp_review"],
    lpShowCorrectReview: json["_lp_show_correct_review"],
  );
}

enum LpDuration { the10Minutes, the30Minutes, empty }

final lpDurationValues = EnumValues({
  "": LpDuration.empty,
  "10 minute": LpDuration.the10Minutes,
  "30 minute": LpDuration.the30Minutes
});

enum Lp { no, empty }

final lpValues = EnumValues({
  "": Lp.empty,
  "no": Lp.no
});

enum Status { publish }

final statusValues = EnumValues({
  "publish": Status.publish
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

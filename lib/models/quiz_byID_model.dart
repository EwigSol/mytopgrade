

import 'dart:convert';

QuizByIdModel quizByIdModelFromJson(String str) => QuizByIdModel.fromJson(json.decode(str));


class QuizByIdModel {
  QuizByIdModel({this.id, this.name, this.slug, this.permalink, this.dateCreated,
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
  String? status;
  String? content;
  String? excerpt;
  bool? canFinishCourse;
  String? duration;
  List<dynamic>? assigned;
  List<dynamic>? questions;
  List<dynamic>? results;
  MetaData? metaData;

  factory QuizByIdModel.fromJson(Map<String, dynamic> json) => QuizByIdModel(
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
    assigned: List<dynamic>.from(json["assigned"].map((x) => x)),
    questions: List<dynamic>.from(json["questions"].map((x) => x)),
    results: List<dynamic>.from(json["results"].map((x) => x)),
    metaData: MetaData.fromJson(json["meta_data"]),
  );
}

class MetaData {
  MetaData({this.lpRandomMode, this.lpDuration,
    this.lpPassingGrade, this.lpInstantCheck, this.lpNegativeMarking, this.lpMinusSkipQuestions,
    this.lpRetakeCount, this.lpPagination, this.lpReview, this.lpShowCorrectReview,
  });

  String? lpRandomMode;
  String? lpDuration;
  String? lpPassingGrade;
  String? lpInstantCheck;
  String? lpNegativeMarking;
  String? lpMinusSkipQuestions;
  String? lpRetakeCount;
  String? lpPagination;
  String? lpReview;
  String? lpShowCorrectReview;

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
    lpRandomMode: json["_lp_random_mode"],
    lpDuration: json["_lp_duration"],
    lpPassingGrade: json["_lp_passing_grade"],
    lpInstantCheck: json["_lp_instant_check"],
    lpNegativeMarking: json["_lp_negative_marking"],
    lpMinusSkipQuestions: json["_lp_minus_skip_questions"],
    lpRetakeCount: json["_lp_retake_count"],
    lpPagination: json["_lp_pagination"],
    lpReview: json["_lp_review"],
    lpShowCorrectReview: json["_lp_show_correct_review"],
  );
}

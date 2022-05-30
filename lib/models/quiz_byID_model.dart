// To parse this JSON data, do
//
//     final quizByIdModel = quizByIdModelFromJson(jsonString);

import 'dart:convert';

QuizByIdModel quizByIdModelFromJson(String str) => QuizByIdModel.fromJson(json.decode(str));


class QuizByIdModel {
  QuizByIdModel({
    this.id,
    this.name,
    this.slug,
    this.permalink,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.status,
    this.content,
    this.excerpt,
    this.canFinishCourse,
    this.duration,
    this.assigned,
    this.questions,
    this.results,
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
  List<Question>? questions;
  Results? results;

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
    assigned: Assigned.fromJson(json["assigned"]),
    questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
    results: Results.fromJson(json["results"]),
  );

}

class Assigned {
  Assigned({
    this.course,
  });

  Course? course;

  factory Assigned.fromJson(Map<String, dynamic> json) => Assigned(
    course: Course.fromJson(json["course"]),
  );

}

class Course {
  Course({
    this.id,
    this.title,
    this.slug,
    this.content,
    this.author,
  });

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


class Question {
  Question({
    this.object,
    this.id,
    this.title,
    this.type,
    this.point,
    this.options,
  });

  Object? object;
  int? id;
  String? title;
  String? type;
  int? point;
  List<Option>? options;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    object: Object.fromJson(json["object"]),
    id: json["id"],
    title: json["title"],
    type: json["type"],
    point: json["point"],
    options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
  );

}

class Object {
  Object({
    this.questionType,
    this.objectType,
  });

  String? questionType;
  String? objectType;

  factory Object.fromJson(Map<String, dynamic> json) => Object(
    questionType: json["_question_type"],
    objectType: json["object_type"],
  );

}

class Option {
  Option({
    this.title,
    this.value,
    this.uid,
  });

  String? title;
  String? value;
  int? uid;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    title: json["title"],
    value: json["value"],
    uid: json["uid"],
  );

}

class Results {
  Results({
    this.passingGrade,
    this.negativeMarking,
    this.instantCheck,
    this.retakeCount,
    this.questionsPerPage,
    this.pageNumbers,
    this.reviewQuestions,
    this.supportOptions,
    this.duration,
    this.status,
    this.attempts,
    this.checkedQuestions,
    this.startTime,
    this.retaken,
    this.totalTime,
    this.answered,
    this.questionIds,
  });

  String? passingGrade;
  bool? negativeMarking;
  bool? instantCheck;
  int? retakeCount;
  int? questionsPerPage;
  bool? pageNumbers;
  bool? reviewQuestions;
  List<String>? supportOptions;
  int? duration;
  String? status;
  List<dynamic>? attempts;
  List<dynamic>? checkedQuestions;
  DateTime? startTime;
  int? retaken;
  int? totalTime;
  Answered? answered;
  List<int>? questionIds;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    passingGrade: json["passing_grade"],
    negativeMarking: json["negative_marking"],
    instantCheck: json["instant_check"],
    retakeCount: json["retake_count"],
    questionsPerPage: json["questions_per_page"],
    pageNumbers: json["page_numbers"],
    reviewQuestions: json["review_questions"],
    supportOptions: List<String>.from(json["support_options"].map((x) => x)),
    duration: json["duration"],
    status: json["status"],
    attempts: List<dynamic>.from(json["attempts"].map((x) => x)),
    checkedQuestions: List<dynamic>.from(json["checked_questions"].map((x) => x)),
    startTime: DateTime.parse(json["start_time"]),
    retaken: json["retaken"],
    totalTime: json["total_time"],
    answered: Answered.fromJson(json["answered"]),
    questionIds: List<int>.from(json["question_ids"].map((x) => x)),
  );

}

class Answered {
  Answered();

  factory Answered.fromJson(Map<String, dynamic> json) => Answered(
  );

  Map<String, dynamic> toJson() => {
  };
}

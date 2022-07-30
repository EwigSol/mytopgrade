// To parse this JSON data, do
//
//     final quizModel = quizModelFromJson(jsonString);

// ignore_for_file: constant_identifier_names, unnecessary_null_in_if_null_operators, unnecessary_new

import 'dart:convert';

List<QuizModel> quizModelFromJson(String str) =>
    List<QuizModel>.from(json.decode(str).map((x) => QuizModel.fromJson(x)));

class QuizModel {
  QuizModel(
      {this.id,
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
      this.results});

  int? id;
  String? name;
  String? slug;
  dynamic permalink;
  DateTime? dateCreated;
  DateTime? dateCreatedGmt;
  DateTime? dateModified;
  DateTime? dateModifiedGmt;
  Status? status;
  String? content;
  String? excerpt;
  bool? canFinishCourse;
  Duration? duration;
  dynamic assigned;
  List<Question>? questions;
  dynamic results;

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
        assigned: json["assigned"],
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
        results: json["results"],
      );
}

class AssignedClass {
  AssignedClass({this.course});

  Course? course;

  factory AssignedClass.fromJson(Map<String, dynamic> json) => AssignedClass(
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

enum Duration { the10Minutes, the30Minutes, lifeTime }

final durationValues = EnumValues({
  "Lifetime": Duration.lifeTime,
  "10 minutes": Duration.the10Minutes,
  "30 minutes": Duration.the30Minutes
});

class Question {
  Question(
      {this.object, this.id, this.title, this.type, this.point, this.options});

  Object? object;
  int? id;
  String? title;
  Type? type;
  int? point;
  List<Option>? options;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        object: Object.fromJson(json["object"]),
        id: json["id"],
        title: json["title"],
        type: typeValues.map![json["type"]],
        point: json["point"],
        options:
            List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
      );
}

class Object {
  Object({
    this.questionType,
    this.objectType,
  });

  Type? questionType;
  String? objectType;

  factory Object.fromJson(Map<String, dynamic> json) => Object(
        questionType: typeValues.map![json["_question_type"]],
        objectType: json["object_type"],
      );
}

enum Type {
  TRUE_OR_FALSE,
  SINGLE_CHOICE,
  MULTI_CHOICE,
  FILL_IN_BLANKS,
  SORTING_CHOICE
}

final typeValues = EnumValues({
  "fill_in_blanks": Type.FILL_IN_BLANKS,
  "multi_choice": Type.MULTI_CHOICE,
  "single_choice": Type.SINGLE_CHOICE,
  "sorting_choice": Type.SORTING_CHOICE,
  "true_or_false": Type.TRUE_OR_FALSE
});

class Option {
  Option({this.title, this.value, this.uid});

  String? title;
  String? value;
  int? uid;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        title: json["title"],
        value: json["value"],
        uid: json["uid"],
      );
}

class ResultsClass {
  ResultsClass({
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
  List<Type>? supportOptions;
  int? duration;
  String? status;
  List<dynamic>? attempts;
  List<dynamic>? checkedQuestions;
  DateTime? startTime;
  int? retaken;
  int? totalTime;
  Answered? answered;
  List<int>? questionIds;

  factory ResultsClass.fromJson(Map<String, dynamic> json) => ResultsClass(
        passingGrade: json["passing_grade"],
        negativeMarking: json["negative_marking"],
        instantCheck: json["instant_check"],
        retakeCount: json["retake_count"],
        questionsPerPage: json["questions_per_page"],
        pageNumbers: json["page_numbers"],
        reviewQuestions: json["review_questions"],
        supportOptions: List<Type>.from(
            json["support_options"].map((x) => typeValues.map![x])),
        duration: json["duration"],
        status: json["status"] ?? null,
        attempts: json["attempts"] == null
            ? null
            : List<dynamic>.from(json["attempts"].map((x) => x)),
        checkedQuestions: json["checked_questions"] == null
            ? null
            : List<dynamic>.from(json["checked_questions"].map((x) => x)),
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]),
        retaken: json["retaken"] ?? null,
        totalTime: json["total_time"] ?? null,
        answered: json["answered"] == null
            ? null
            : Answered.fromJson(json["answered"]),
        questionIds: json["question_ids"] == null
            ? null
            : List<int>.from(json["question_ids"].map((x) => x)),
      );
}

class Answered {
  Answered();

  factory Answered.fromJson(Map<String, dynamic> json) => Answered();

  Map<String, dynamic> toJson() => {};
}

enum Status { PUBLISH }

final statusValues = EnumValues({"publish": Status.PUBLISH});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map!.map((k, v) => new MapEntry(v, k));
    return reverseMap!;
  }
}

// ignore_for_file: file_names

import 'dart:convert';

AssignmentByIdModel assignmentByIdModelFromJson(String str) =>
    AssignmentByIdModel.fromJson(json.decode(str));

class AssignmentByIdModel {
  AssignmentByIdModel({
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
    this.assigned,
    this.retakeCount,
    this.retaken,
    this.duration,
    this.introdution,
    this.passingGrade,
    this.allowFileType,
    this.filesAmount,
    this.attachment,
    this.results,
    this.assignmentAnswer,
    this.evaluation,
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
  Assigned? assigned;
  int? retakeCount;
  int? retaken;
  Duration? duration;
  String? introdution;
  String? passingGrade;
  String? allowFileType;
  int? filesAmount;
  List<dynamic>? attachment;
  Results? results;
  AssignmentAnswer? assignmentAnswer;
  List<dynamic>? evaluation;

  factory AssignmentByIdModel.fromJson(Map<String, dynamic> json) =>
      AssignmentByIdModel(
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
        assigned: Assigned.fromJson(json["assigned"]),
        retakeCount: json["retake_count"],
        retaken: json["retaken"],
        duration: Duration.fromJson(json["duration"]),
        introdution: json["introdution"],
        passingGrade: json["passing_grade"],
        allowFileType: json["allow_file_type"],
        filesAmount: json["files_amount"],
        attachment: List<dynamic>.from(json["attachment"].map((x) => x)),
        results: Results.fromJson(json["results"]),
        // assignmentAnswer: json["assignment_answer"] != []
        //     ? AssignmentAnswer.fromJson(json["assignment_answer"])
        //     : null,
        evaluation: List<dynamic>.from(json["evaluation"].map((x) => x)),
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

class AssignmentAnswer {
  AssignmentAnswer({
    this.note,
    this.file,
  });

  String? note;
  Map<String, FileValue>? file;

  factory AssignmentAnswer.fromJson(Map<String, dynamic> json) =>
      AssignmentAnswer(
        note: json["note"],
        file: Map.from(json["file"]).map(
            (k, v) => MapEntry<String, FileValue>(k, FileValue.fromJson(v))),
      );
}

class FileValue {
  FileValue({
    this.file,
    this.url,
    this.type,
    this.filename,
    this.savedTime,
    this.size,
  });

  String? file;
  String? url;
  String? type;
  String? filename;
  DateTime? savedTime;
  int? size;

  factory FileValue.fromJson(Map<String, dynamic> json) => FileValue(
        file: json["file"],
        url: json["url"],
        type: json["type"],
        filename: json["filename"],
        savedTime: DateTime.parse(json["saved_time"]),
        size: json["size"],
      );
}

class Duration {
  Duration({
    this.format,
    this.time,
  });

  String? format;
  int? time;

  factory Duration.fromJson(Map<String, dynamic> json) => Duration(
        format: json["format"],
        time: json["time"],
      );
}

class Results {
  Results({
    this.status,
    this.startTime,
    this.expirationTime,
  });

  String? status;
  DateTime? startTime;
  DateTime? expirationTime;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        status: json["status"],
        startTime: DateTime.parse(json["start_time"]),
        expirationTime: DateTime.parse(json["expiration_time"]),
      );
}

// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

List<CoursesModel> coursesModelFromJson(String str) => List<CoursesModel>.from(
    json.decode(str).map((x) => CoursesModel.fromJson(x)));

class CoursesModel {
  CoursesModel({
    this.id,
    this.name,
    this.slug,
    this.permalink,
    this.image,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.onSale,
    this.status,
    this.content,
    this.excerpt,
    this.duration,
    this.countStudents,
    this.canFinish,
    this.canRetake,
    this.ratakeCount,
    this.rataken,
    this.rating,
    this.price,
    this.originPrice,
    this.salePrice,
    this.categories,
    this.tags,
    this.instructor,
    this.sections,
    this.courseData,
  });

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
  CoursesModelStatus? status;
  String? content;
  String? excerpt;
  CoursesModelDuration? duration;
  int? countStudents;
  bool? canFinish;
  var canRetake;
  int? ratakeCount;
  int? rataken;
  int? rating;
  int? price;
  int? originPrice;
  int? salePrice;
  List<Category>? categories;
  List<dynamic>? tags;
  Instructor? instructor;
  List<Section>? sections;
  CourseData? courseData;
  // MetaData? metaData;

  factory CoursesModel.fromJson(Map<String, dynamic> json) => CoursesModel(
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
        status: coursesModelStatusValues.map![json["status"]],
        content: json["content"],
        excerpt: json["excerpt"],
        duration: coursesModelDurationValues.map![json["duration"]],
        countStudents: json["count_students"],
        canFinish: json["can_finish"],
        canRetake: json["can_retake"],
        ratakeCount: json["ratake_count"],
        rataken: json["rataken"],
        rating: json["rating"],
        price: json["price"],
        originPrice: json["origin_price"],
        salePrice: json["sale_price"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        instructor: Instructor.fromJson(json["instructor"]),
        sections: List<Section>.from(
            json["sections"].map((x) => Section.fromJson(x))),
        courseData: CourseData.fromJson(json["course_data"]),
        // metaData: MetaData.fromJson(json["meta_data"]),
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
  CourseData({
    this.graduation,
    this.status,
    this.startTime,
    this.endTime,
    this.expirationTime,
    this.result,
  });

  CourseDataGraduation? graduation;
  CourseDataStatus? status;
  DateTime? startTime;
  var endTime;
  DateTime? expirationTime;
  Result? result;

  factory CourseData.fromJson(Map<String, dynamic> json) => CourseData(
        graduation: courseDataGraduationValues.map![json["graduation"]],
        status: courseDataStatusValues.map![json["status"]],
        startTime: DateTime.parse(json["start_time"]),
        endTime: json["end_time"],
        expirationTime: DateTime.parse(json["expiration_time"]),
        result: Result.fromJson(json["result"]),
      );
}

enum CourseDataGraduation { inProgress, empty }

final courseDataGraduationValues = EnumValues({
  "": CourseDataGraduation.empty,
  "in-progress": CourseDataGraduation.inProgress
});

class Result {
  Result({
    this.result,
    this.pass,
    this.countItems,
    this.completedItems,
    this.items,
    this.evaluateType,
  });

  double? result;
  int? pass;
  int? countItems;
  int? completedItems;
  Items? items;
  LpCourseResult? evaluateType;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        result: json["result"].toDouble(),
        pass: json["pass"],
        countItems: json["count_items"],
        completedItems: json["completed_items"],
        items: Items.fromJson(json["items"]),
        evaluateType: lpCourseResultValues.map![json["evaluate_type"]],
      );
}

enum LpCourseResult { evaluateLesson }

final lpCourseResultValues =
    EnumValues({"evaluate_lesson": LpCourseResult.evaluateLesson});

class Items {
  Items({
    this.lesson,
    this.quiz,
    this.assignment,
  });

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

  dynamic completed;
  dynamic passed;
  int? total;

  factory Assignment.fromJson(Map<String, dynamic> json) => Assignment(
        completed: json["completed"],
        passed: json["passed"],
        total: json["total"],
      );
}

enum CourseDataStatus { enrolled, empty }

final courseDataStatusValues = EnumValues(
    {"": CourseDataStatus.empty, "enrolled": CourseDataStatus.enrolled});

enum CoursesModelDuration { the30Days, the33Days, the35Days }

final coursesModelDurationValues = EnumValues({
  "30 days": CoursesModelDuration.the30Days,
  "33 days": CoursesModelDuration.the33Days,
  "35 days": CoursesModelDuration.the35Days
});

class Instructor {
  Instructor({this.avatar, this.id, this.name, this.description, this.social});

  String? avatar;
  int? id;
  Name? name;
  String? description;
  Social? social;

  factory Instructor.fromJson(Map<String, dynamic> json) => Instructor(
        avatar: json["avatar"],
        id: json["id"],
        name: nameValues.map![json["name"]],
        description: json["description"],
        social: Social.fromJson(json["social"]),
      );
}

enum Name { stanleyAkuJobi, admin }

final nameValues =
    EnumValues({"admin": Name.admin, "Stanley Akujiobi": Name.stanleyAkuJobi});

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

class MetaData {
  MetaData({
    this.lpDuration,
    this.lpBlockExpireDuration,
    this.lpBlockFinished,
    this.lpAllowCourseRepurchase,
    this.lpCourseRepurchaseOption,
    this.lpLevel,
    this.lpStudents,
    this.lpMaxStudents,
    this.lpRetakeCount,
    this.lpHasFinish,
    this.lpFeatured,
    this.lpFeaturedReview,
    this.lpExternalLinkBuyCourse,
    this.lpRegularPrice,
    this.lpSalePrice,
    this.lpSaleStart,
    this.lpSaleEnd,
    this.lpNoRequiredEnroll,
    this.lpRequirements,
    this.lpTargetAudiences,
    this.lpKeyFeatures,
    this.lpFaqs,
    this.lpCourseResult,
    this.lpPassingCondition,
    this.lpCourseAuthor,
  });

  LpDuration? lpDuration;
  Lp? lpBlockExpireDuration;
  Lp? lpBlockFinished;
  Lp? lpAllowCourseRepurchase;
  LpCourseRepurchaseOption? lpCourseRepurchaseOption;
  String? lpLevel;
  String? lpStudents;
  String? lpMaxStudents;
  String? lpRetakeCount;
  Lp? lpHasFinish;
  Lp? lpFeatured;
  String? lpFeaturedReview;
  String? lpExternalLinkBuyCourse;
  String? lpRegularPrice;
  String? lpSalePrice;
  String? lpSaleStart;
  String? lpSaleEnd;
  Lp? lpNoRequiredEnroll;
  List<dynamic>? lpRequirements;
  List<dynamic>? lpTargetAudiences;
  List<dynamic>? lpKeyFeatures;
  List<dynamic>? lpFaqs;
  LpCourseResult? lpCourseResult;
  String? lpPassingCondition;
  String? lpCourseAuthor;

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
        lpDuration: lpDurationValues.map![json["_lp_duration"]],
        lpBlockExpireDuration: lpValues.map![json["_lp_block_expire_duration"]],
        lpBlockFinished: lpValues.map![json["_lp_block_finished"]],
        lpAllowCourseRepurchase:
            lpValues.map![json["_lp_allow_course_repurchase"]],
        lpCourseRepurchaseOption: lpCourseRepurchaseOptionValues
            .map![json["_lp_course_repurchase_option"]],
        lpLevel: json["_lp_level"],
        lpStudents: json["_lp_students"],
        lpMaxStudents: json["_lp_max_students"],
        lpRetakeCount: json["_lp_retake_count"],
        lpHasFinish: lpValues.map![json["_lp_has_finish"]],
        lpFeatured: lpValues.map![json["_lp_featured"]],
        lpFeaturedReview: json["_lp_featured_review"],
        lpExternalLinkBuyCourse: json["_lp_external_link_buy_course"],
        lpRegularPrice: json["_lp_regular_price"],
        lpSalePrice: json["_lp_sale_price"],
        lpSaleStart: json["_lp_sale_start"],
        lpSaleEnd: json["_lp_sale_end"],
        lpNoRequiredEnroll: lpValues.map![json["_lp_no_required_enroll"]],
        lpRequirements:
            List<dynamic>.from(json["_lp_requirements"].map((x) => x)),
        lpTargetAudiences:
            List<dynamic>.from(json["_lp_target_audiences"].map((x) => x)),
        lpKeyFeatures:
            List<dynamic>.from(json["_lp_key_features"].map((x) => x)),
        lpFaqs: List<dynamic>.from(json["_lp_faqs"].map((x) => x)),
        lpCourseResult: lpCourseResultValues.map![json["_lp_course_result"]],
        lpPassingCondition: json["_lp_passing_condition"],
        lpCourseAuthor: json["_lp_course_author"],
      );
}

enum Lp { yes, no }

final lpValues = EnumValues({"no": Lp.no, "yes": Lp.yes});

enum LpCourseRepurchaseOption { reset }

final lpCourseRepurchaseOptionValues =
    EnumValues({"reset": LpCourseRepurchaseOption.reset});

enum LpDuration { the30Days, the33Days, the35Days }

final lpDurationValues = EnumValues({
  "30 day": LpDuration.the30Days,
  "33 day": LpDuration.the33Days,
  "35 day": LpDuration.the35Days
});

class Section {
  Section({
    this.id,
    this.title,
    this.courseId,
    this.description,
    this.order,
    this.percent,
    this.items,
  });

  String? id;
  String? title;
  int? courseId;
  String? description;
  String? order;
  var percent;
  List<Item>? items;

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["id"],
        title: json["title"],
        courseId: json["course_id"],
        description: json["description"],
        order: json["order"],
        percent: json["percent"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );
}

class Item {
  Item({
    this.id,
    this.type,
    this.title,
    this.preview,
    this.duration,
    this.graduation,
    this.status,
    this.locked,
  });

  int? id;
  Type? type;
  String? title;
  bool? preview;
  ItemDuration? duration;
  ItemGraduation? graduation;
  ItemStatus? status;
  bool? locked;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        type: typeValues.map![json["type"]],
        title: json["title"],
        preview: json["preview"],
        duration: itemDurationValues.map![json["duration"]],
        graduation: itemGraduationValues.map![json["graduation"]],
        status: itemStatusValues.map![json["status"]],
        locked: json["locked"],
      );
}

enum ItemDuration {
  the14Mins,
  the04Mins,
  the08Mins,
  the07Mins,
  the03Mins,
  the05Mins,
  the09Mins,
  the39Mins,
  empty,
  the13Mins,
  the06Mins,
  the02Mins,
  the01Mins,
  the18Mins,
  the30Mins,
  the12Mins,
  the17Mins,
  the10Mins
}

final itemDurationValues = EnumValues({
  "": ItemDuration.empty,
  "01 mins": ItemDuration.the01Mins,
  "02 mins": ItemDuration.the02Mins,
  "03 mins": ItemDuration.the03Mins,
  "04 mins": ItemDuration.the04Mins,
  "05 mins": ItemDuration.the05Mins,
  "06 mins": ItemDuration.the06Mins,
  "07 mins": ItemDuration.the07Mins,
  "08 mins": ItemDuration.the08Mins,
  "09 mins": ItemDuration.the09Mins,
  "10 mins": ItemDuration.the10Mins,
  "12 mins": ItemDuration.the12Mins,
  "13 mins": ItemDuration.the13Mins,
  "14 mins": ItemDuration.the14Mins,
  "17 mins": ItemDuration.the17Mins,
  "18 mins": ItemDuration.the18Mins,
  "30 mins": ItemDuration.the30Mins,
  "39 mins": ItemDuration.the39Mins
});

enum ItemGraduation { passed, empty }

final itemGraduationValues =
    EnumValues({"": ItemGraduation.empty, "passed": ItemGraduation.passed});

enum ItemStatus { completed, empty }

final itemStatusValues =
    EnumValues({"completed": ItemStatus.completed, "": ItemStatus.empty});

enum Type { lesson, assignment, quiz }

final typeValues = EnumValues({
  "lp_assignment": Type.assignment,
  "lp_lesson": Type.lesson,
  "lp_quiz": Type.quiz
});

enum CoursesModelStatus { publish }

final coursesModelStatusValues =
    EnumValues({"publish": CoursesModelStatus.publish});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map!.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

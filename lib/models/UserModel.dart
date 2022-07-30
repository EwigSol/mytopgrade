// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String? userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.id,
    this.username,
    this.name,
    this.firstName,
    this.lastName,
    this.email,
    this.url,
    this.description,
    this.link,
    this.nickname,
    this.slug,
    this.tabs,
    this.avatarUrl,
    this.avatarSize,
    // this.instructorData,
    this.customRegister,
    this.social,
    this.meta,
    this.isSuperAdmin,
    this.links,
  });

  int? id;
  String? username;
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  String? url;
  String? description;
  String? link;
  String? nickname;
  String? slug;
  Tabs? tabs;
  String? avatarUrl;
  AvatarSize? avatarSize;
  // InstructorData? instructorData;
  List<dynamic>? customRegister;
  Social? social;
  Meta? meta;
  bool? isSuperAdmin;
  Links? links;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        url: json["url"],
        description: json["description"],
        link: json["link"],
        nickname: json["nickname"],
        slug: json["slug"],
        tabs: Tabs.fromJson(json["tabs"]),
        avatarUrl: json["avatar_url"],
        avatarSize: AvatarSize.fromJson(json["avatar_size"]),
        // instructorData: InstructorData.fromJson(json["instructor_data"]),
        customRegister:
            List<dynamic>.from(json["custom_register"].map((x) => x)),
        social: Social.fromJson(json["social"]),
        meta: Meta.fromJson(json["meta"]),
        isSuperAdmin: json["is_super_admin"],
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "url": url,
        "description": description,
        "link": link,
        "nickname": nickname,
        "slug": slug,
        "tabs": tabs!.toJson(),
        "avatar_url": avatarUrl,
        "avatar_size": avatarSize!.toJson(),
        // "instructor_data": instructorData!.toJson(),
        "custom_register": List<dynamic>.from(customRegister!.map((x) => x)),
        "social": social!.toJson(),
        "meta": meta!.toJson(),
        "is_super_admin": isSuperAdmin,
        "_links": links!.toJson(),
      };
}

class AvatarSize {
  AvatarSize({
    this.width,
    this.height,
  });

  String? width;
  String? height;

  factory AvatarSize.fromJson(Map<String, dynamic> json) => AvatarSize(
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "width": width,
        "height": height,
      };
}

// class InstructorData {
//   InstructorData({
//     this.enrolledCourses,
//     this.activeCourses,
//     this.completedCourses,
//     this.totalCourses,
//     this.totalUsers,
//   });

//   int? enrolledCourses;
//   int? activeCourses;
//   int? completedCourses;
//   int? totalCourses;
//   int? totalUsers;

//   factory InstructorData.fromJson(Map<String, dynamic> json) => InstructorData(
//         enrolledCourses: json["enrolled_courses"],
//         activeCourses: json["active_courses"],
//         completedCourses: json["completed_courses"],
//         totalCourses: json["total_courses"],
//         totalUsers: json["total_users"],
//       );

//   Map<String, dynamic> toJson() => {
//         "enrolled_courses": enrolledCourses,
//         "active_courses": activeCourses,
//         "completed_courses": completedCourses,
//         "total_courses": totalCourses,
//         "total_users": totalUsers,
//       };
// }

class Links {
  Links({
    this.self,
    this.collection,
  });

  List<Collection>? self;
  List<Collection>? collection;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: List<Collection>.from(
            json["self"].map((x) => Collection.fromJson(x))),
        collection: List<Collection>.from(
            json["collection"].map((x) => Collection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": List<dynamic>.from(self!.map((x) => x.toJson())),
        "collection": List<dynamic>.from(collection!.map((x) => x.toJson())),
      };
}

class Collection {
  Collection({
    this.href,
  });

  String? href;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
      };
}

class Meta {
  Meta({
    this.bbpTopicCount,
    this.bbpReplyCount,
    this.bbpLastPosted,
  });

  int? bbpTopicCount;
  int? bbpReplyCount;
  int? bbpLastPosted;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        bbpTopicCount: json["_bbp_topic_count"],
        bbpReplyCount: json["_bbp_reply_count"],
        bbpLastPosted: json["_bbp_last_posted"],
      );

  Map<String, dynamic> toJson() => {
        "_bbp_topic_count": bbpTopicCount,
        "_bbp_reply_count": bbpReplyCount,
        "_bbp_last_posted": bbpLastPosted,
      };
}

class Social {
  Social({
    this.facebook,
    this.twitter,
    this.youtube,
    this.linkedin,
  });

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

  Map<String, dynamic> toJson() => {
        "facebook": facebook,
        "twitter": twitter,
        "youtube": youtube,
        "linkedin": linkedin,
      };
}

class Tabs {
  Tabs({
    this.courses,
    this.certificates,
    this.quizzes,
    this.wishlist,
    // this.orders,
    this.assignments,
    this.lpOrdersWoocommerce,
    this.orderDetails,
    this.settings,
    this.logout,
  });

  Courses? courses;
  Assignments? certificates;
  Quizzes? quizzes;
  Assignments? wishlist;
  // Orders? orders;
  Assignments? assignments;
  Assignments? lpOrdersWoocommerce;
  Assignments? orderDetails;
  Assignments? settings;
  Assignments? logout;

  factory Tabs.fromJson(Map<String, dynamic> json) => Tabs(
        courses: Courses.fromJson(json["courses"]),
        certificates: Assignments.fromJson(json["certificates"]),
        quizzes: Quizzes.fromJson(json["quizzes"]),
        wishlist: Assignments.fromJson(json["wishlist"]),
        // orders: Orders.fromJson(json["orders"]),
        assignments: Assignments.fromJson(json["assignments"]),
        lpOrdersWoocommerce:
            Assignments.fromJson(json["lp_orders_woocommerce"]),
        orderDetails: Assignments.fromJson(json["order-details"]),
        settings: Assignments.fromJson(json["settings"]),
        logout: Assignments.fromJson(json["logout"]),
      );

  Map<String, dynamic> toJson() => {
        "courses": courses!.toJson(),
        "certificates": certificates!.toJson(),
        "quizzes": quizzes!.toJson(),
        "wishlist": wishlist!.toJson(),
        // "orders": orders!.toJson(),
        "assignments": assignments!.toJson(),
        "lp_orders_woocommerce": lpOrdersWoocommerce!.toJson(),
        "order-details": orderDetails!.toJson(),
        "settings": settings!.toJson(),
        "logout": logout!.toJson(),
      };
}

class Assignments {
  Assignments({
    this.title,
    this.slug,
    this.priority,
    this.icon,
    this.content,
    this.section,
  });

  String? title;
  String? slug;
  int? priority;
  String? icon;
  String? content;
  Section? section;

  factory Assignments.fromJson(Map<String, dynamic> json) => Assignments(
        title: json["title"],
        slug: json["slug"],
        priority: json["priority"],
        icon: json["icon"],
        content: json["content"],
        section:
            json["section"] == null ? null : Section.fromJson(json["section"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "slug": slug,
        "priority": priority,
        "icon": icon,
        "content": content,
        "section": section == null ? null : section!.toJson(),
      };
}

class Section {
  Section({
    this.basicInformation,
    this.avatar,
    this.changePassword,
  });

  Avatar? basicInformation;
  Avatar? avatar;
  Avatar? changePassword;

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        basicInformation: Avatar.fromJson(json["basic-information"]),
        avatar: Avatar.fromJson(json["avatar"]),
        changePassword: Avatar.fromJson(json["change-password"]),
      );

  Map<String, dynamic> toJson() => {
        "basic-information": basicInformation!.toJson(),
        "avatar": avatar!.toJson(),
        "change-password": changePassword!.toJson(),
      };
}

class Avatar {
  Avatar({
    this.title,
    this.slug,
    this.priority,
  });

  String? title;
  String? slug;
  int? priority;

  factory Avatar.fromJson(Map<String, dynamic> json) => Avatar(
        title: json["title"],
        slug: json["slug"],
        priority: json["priority"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "slug": slug,
        "priority": priority,
      };
}

class Courses {
  Courses({
    this.title,
    this.slug,
    this.priority,
    this.icon,
    // this.content,
  });

  String? title;
  String? slug;
  int? priority;
  String? icon;
  // CoursesContent? content;

  factory Courses.fromJson(Map<String, dynamic> json) => Courses(
        title: json["title"],
        slug: json["slug"],
        priority: json["priority"],
        icon: json["icon"],
        // content: CoursesContent.fromJson(json["content"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "slug": slug,
        "priority": priority,
        "icon": icon,
        // "content": content!.toJson(),
      };
}

// class CoursesContent {
//   CoursesContent({
//     this.enrolled,
//     this.created,
//   });

//   List<dynamic>? enrolled;
//   Created? created;

//   factory CoursesContent.fromJson(Map<String, dynamic> json) => CoursesContent(
//         enrolled: List<dynamic>.from(json["enrolled"].map((x) => x)),
//         created: Created.fromJson(json["created"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "enrolled": List<dynamic>.from(enrolled!.map((x) => x)),
//         "created": created!.toJson(),
//       };
// }

class Created {
  Created({
    this.all,
    this.publish,
    this.pending,
  });

  List<dynamic>? all;
  List<dynamic>? publish;
  List<dynamic>? pending;

  factory Created.fromJson(Map<String, dynamic> json) => Created(
        all: List<dynamic>.from(json["all"].map((x) => x)),
        publish: List<dynamic>.from(json["publish"].map((x) => x)),
        pending: List<dynamic>.from(json["pending"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "all": List<dynamic>.from(all!.map((x) => x)),
        "publish": List<dynamic>.from(publish!.map((x) => x)),
        "pending": List<dynamic>.from(pending!.map((x) => x)),
      };
}

// class Orders {
//   Orders({
//     this.title,
//     this.slug,
//     this.priority,
//     this.icon,
//     this.content,
//   });

//   String? title;
//   String? slug;
//   int? priority;
//   String? icon;
//   List<dynamic>? content;

//   factory Orders.fromJson(Map<String, dynamic> json) => Orders(
//         title: json["title"],
//         slug: json["slug"],
//         priority: json["priority"],
//         icon: json["icon"],
//         content: List<dynamic>.from(json["content"].map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "title": title,
//         "slug": slug,
//         "priority": priority,
//         "icon": icon,
//         "content": List<dynamic>.from(content!.map((x) => x)),
//       };
// }

class Quizzes {
  Quizzes({
    this.title,
    this.slug,
    this.priority,
    this.icon,
    this.content,
  });

  String? title;
  String? slug;
  int? priority;
  String? icon;
  QuizzesContent? content;

  factory Quizzes.fromJson(Map<String, dynamic> json) => Quizzes(
        title: json["title"],
        slug: json["slug"],
        priority: json["priority"],
        icon: json["icon"],
        content: QuizzesContent.fromJson(json["content"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "slug": slug,
        "priority": priority,
        "icon": icon,
        "content": content!.toJson(),
      };
}

class QuizzesContent {
  QuizzesContent({
    this.all,
    this.finished,
    this.passed,
    this.failed,
    this.inProgress,
  });

  List<dynamic>? all;
  List<dynamic>? finished;
  List<dynamic>? passed;
  List<dynamic>? failed;
  List<dynamic>? inProgress;

  factory QuizzesContent.fromJson(Map<String, dynamic> json) => QuizzesContent(
        all: List<dynamic>.from(json["all"].map((x) => x)),
        finished: List<dynamic>.from(json["finished"].map((x) => x)),
        passed: List<dynamic>.from(json["passed"].map((x) => x)),
        failed: List<dynamic>.from(json["failed"].map((x) => x)),
        inProgress: List<dynamic>.from(json["in-progress"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "all": List<dynamic>.from(all!.map((x) => x)),
        "finished": List<dynamic>.from(finished!.map((x) => x)),
        "passed": List<dynamic>.from(passed!.map((x) => x)),
        "failed": List<dynamic>.from(failed!.map((x) => x)),
        "in-progress": List<dynamic>.from(inProgress!.map((x) => x)),
      };
}

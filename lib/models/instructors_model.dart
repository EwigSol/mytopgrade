

import 'dart:convert';

InstructorsModel instructorsModelFromJson(String str) => InstructorsModel.fromJson(json.decode(str));

class InstructorsModel {
  InstructorsModel({this.avatar, this.id, this.name, this.description, this.social});

  String? avatar;
  int? id;
  String? name;
  String? description;
  Social? social;

  factory InstructorsModel.fromJson(Map<String, dynamic> json) => InstructorsModel(
    avatar: json["avatar"],
    id: json["id"],
    name: json["name"],
    description: json["description"],
    social: Social.fromJson(json["social"]),
  );
}

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

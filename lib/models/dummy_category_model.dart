

import 'package:flutter/material.dart';

class DummyCategoryModel {
  String? id;
  Icon? icon;
  String? title;
  Color? color;

  DummyCategoryModel({this.id, this.icon, this.title, this.color});

  DummyCategoryModel.fromFireStore(Map<String, dynamic> doc) {
    id = doc['id'];
    icon = doc['icon'];
    title = doc['title'];
    color = doc['color'];
  }
}

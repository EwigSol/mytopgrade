

import 'package:flutter/material.dart';

class CategoryModel {
  String? id;
  Icon? icon;
  String? title;
  Color? color;

  CategoryModel({this.id, this.icon, this.title, this.color});

  CategoryModel.fromFireStore(Map<String, dynamic> doc) {
    id = doc['id'];
    icon = doc['icon'];
    title = doc['title'];
    color = doc['color'];
  }
}

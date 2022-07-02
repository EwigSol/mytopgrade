import 'package:flutter/foundation.dart';

class APIBase {
  static String get baseURL {
    if (kReleaseMode) {
      return "https://mytopgrade.com/wp-json/learnpress/v1";
    } else {
      return "https://mytopgrade.com/wp-json/learnpress/v1";
    }
  }
}



import 'package:flutter/foundation.dart';

class APIBase{
  static String get baseURL {
    if (kReleaseMode) {
      return "https://musing-gould.18-141-157-112.plesk.page/wp-json/learnpress/v1";
    } else {
      return "https://musing-gould.18-141-157-112.plesk.page/wp-json/learnpress/v1";
    }
  }

}

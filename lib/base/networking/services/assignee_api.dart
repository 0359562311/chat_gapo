import 'dart:convert';
import 'dart:math';

import 'package:base_flutter/models/api/assignee_response.dart';
import 'package:base_flutter/utils/string_utils.dart';
import 'package:flutter/services.dart';

class AssigneeAPI {
  Future<AssigneeResponse> fetchAssigneeList(String query) {
    return rootBundle
        .loadString("assets/json/assignee.json")
        .then((value) => (AssigneeResponse.fromJson(jsonDecode(value))))
        .then((value) {
      value.data = value.data
          // ?.where((element) => (element.displayName!).match(query))
          // .toList()
          ?.sublist(0, min(5, value.data?.length ?? 0));
      return value;
    });
  }
}

import 'dart:math';

import 'package:base_flutter/base/networking/services/assignee_api.dart';
import 'package:base_flutter/models/api/assignee_response.dart';
import 'package:base_flutter/screens/rich_input/rich_editing_input_controller.dart';
import 'package:base_flutter/theme/colors.dart';
import 'package:base_flutter/theme/text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

class RichInputController extends GetxController {
  late final RichTextEditingController textEditingController;
  final AssigneeAPI _api = AssigneeAPI();

  @override
  void onInit() {
    super.onInit();
    textEditingController = RichTextEditingController(onChange);
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  RxList<Assignee> suggestions = <Assignee>[].obs;

  void onChange(String tag) async {
    if (tag.isNotEmpty) {
      suggestions.value =
          await _api.fetchAssigneeList(tag).then((value) => value.data ?? []);
    } else {
      suggestions.value = [];
    }
  }

  void setTag(Assignee e) {
    textEditingController.setTag(e);
  }
}

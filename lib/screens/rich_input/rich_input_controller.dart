import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

RegExp regExp = RegExp(
  r"^@{1}(\w)+",
  caseSensitive: false,
  multiLine: false,
);

class RichInputController extends GetxController {
  late final TextEditingController textEditingController;

  void onInit() {
    super.onInit();
    textEditingController = TextEditingController();
  }

  RxList<String> suggestions = <String>[].obs;

  void onChange(String text) {
    String tagged = text.split(" ").last;
    if (regExp.hasMatch(tagged)) {
      print("$tagged");
      suggestions.value = ["tan kiem", "ne"];
    }
  }
}

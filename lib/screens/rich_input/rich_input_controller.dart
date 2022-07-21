import 'package:base_flutter/base/networking/services/assignee_api.dart';
import 'package:base_flutter/models/api/assignee_response.dart';
import 'package:base_flutter/theme/colors.dart';
import 'package:base_flutter/theme/text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

RegExp tagRegex = RegExp(
  r"@{1}[a-zA-Z]+\b",
  caseSensitive: false,
  multiLine: false,
);

RegExp phoneRegex = RegExp(
  r'^(?:\+?88|0088)?01[13-9]\d{8}$',
  caseSensitive: false,
  multiLine: false,
);

RegExp emailRegex = RegExp(
  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  caseSensitive: true,
  multiLine: false,
);

class RichInputController extends GetxController {
  late final RichTextEditingController textEditingController;
  final AssigneeAPI _api = AssigneeAPI();

  void onInit() {
    super.onInit();
    textEditingController = RichTextEditingController()
      ..addListener(() {
        print(textEditingController.selection.base.offset);
      });
  }

  RxList<Assignee> suggestions = <Assignee>[].obs;

  void onChange(String text) async {
    String tagged = text.split(" ").last;
    if (tagRegex.hasMatch(tagged)) {
      print("$tagged");
      suggestions.value = await _api
          .fetchAssigneeList(tagged.substring(1))
          .then((value) => value.data ?? []);
      print(suggestions.value);
    } else {
      suggestions.value = [];
    }
  }
}

class RichTextEditingController extends TextEditingController {
  final tags = <_SpecialInput>[];
  String _oldText = "";
  List<TextSpan> children = [];

  void setTag(Assignee assignee) {
    int start = selection.baseOffset - 1;
    while (text.characters.characterAt(start) != Characters('@')) {
      start--;
    }
  }

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    print(text);
    if (_oldText.length > text.length) {
      _oldText = text;
      int r = selection.baseOffset - 1;
      if (text.substring(r, r + 1) != " ") {
        String temp = "";
        while (r >= 0) {
          temp = text.substring(r, r + 1) + temp;
          if (text.substring(r, r + 1) == " ") break;
        }
        if (phoneRegex.hasMatch(temp)) {}
      }
    }
    return TextSpan(children: children);
    // temp.split(r"<com.tankiem.chat.tag>\w+</com.tankiem.chat.tag>");
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   selection = selection.copyWith(
    //       baseOffset: text.length - t.length + 1,
    //       extentOffset: text.length - t.length + 1);
    // });
    // return TextSpan(
    //     children: t
    //         .map((e) =>
    //             TextSpan(text: e, style: TextStyle(color: Colors.amberAccent)))
    //         .toList());
  }
}

abstract class _SpecialInput {
  final int start;
  final int end;

  _SpecialInput(this.start, this.end);
}

class _TagInput extends _SpecialInput {
  final Assignee assignee;

  _TagInput(this.assignee, int start, int end) : super(start, end);
}

class _PhoneInput extends _SpecialInput {
  _PhoneInput(int start, int end) : super(start, end);
}

class _LinkInput extends _SpecialInput {
  _LinkInput(int start, int end) : super(start, end);
}

import 'dart:math';

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
  r"^@{1}[a-zA-Z]+\b",
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
    textEditingController = RichTextEditingController(onChange);
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
}

class RichTextEditingController extends TextEditingController {
  final _specialInput = <_SpecialInput>[];
  String _oldText = "";
  final void Function(String) onMatchTag;

  RichTextEditingController(this.onMatchTag);

  @override
  set text(String newText) {
    value = value.copyWith(
      text: newText,
      selection:
          TextSelection.fromPosition(TextPosition(offset: newText.length)),
      composing: TextRange.empty,
    );
  }

  void setTag(Assignee assignee) {
    if (selection.baseOffset < 0) return;
    int start = max(0, selection.baseOffset - 1);
    while (start > 0 &&
        text.characters.characterAt(start - 1) != Characters(' ')) {
      start--;
    }
    if (tagRegex.hasMatch(text.substring(start, selection.baseOffset))) {
      text = text.replaceRange(
          start, selection.baseOffset, assignee.displayName! + " ");
      _oldText = text;
      // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //   selection = TextSelection.fromPosition(
      //       TextPosition(offset: assignee.displayName!.length + start));
      // });
      _specialInput.add(_TagInput(assignee, start, selection.baseOffset - 1));
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onMatchTag("");
    });
  }

  void _checkMatchTag() {
    if (selection.baseOffset < 0) return;
    int start = max(0, selection.baseOffset - 1);
    while (start > 0 &&
        text.characters.characterAt(start - 1) != Characters(' ')) {
      start--;
    }
    if (tagRegex.hasMatch(text.substring(start, selection.baseOffset))) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        onMatchTag(text.substring(start + 1, selection.baseOffset));
      });
      onMatchTag(text.substring(start + 1, selection.baseOffset));
    } else {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        onMatchTag("");
      });
    }
  }

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    _checkMatchTag();
    int current = selection.baseOffset;
    if (_oldText.length == text.length) {
      // cursor position changed
    } else if (_oldText.length < text.length) {
      // add a character
      _SpecialInput? temp;
      _specialInput.forEach((element) {
        if (element.start <= current && element.end > current) {
          temp = element;
        }
      });
      if (temp != null && temp is _TagInput) {
        _specialInput.remove(temp);
      }
      _specialInput.forEach((element) {
        if (element.start >= current) {
          element.start++;
          element.end++;
        }
      });
    } else {
      // delete a character
      _SpecialInput? temp;
      _specialInput.forEach((element) {
        if (element.start <= current && element.end > current) {
          temp = element;
        }
      });
      if (temp != null && temp is _TagInput) {
        _specialInput.remove(temp);
        if (temp!.end - 1 == current) {
          text = text.replaceRange(temp!.start, current, "");
          _specialInput.forEach((element) {
            if (element.start >= current) {
              element.start -= temp!.end - temp!.start + 1;
              element.end -= temp!.end - temp!.start;
            }
          });
        } else {
          _specialInput.forEach((element) {
            if (element.start >= current) {
              element.start--;
              element.end--;
            }
          });
        }
      }
    }

    if (_oldText != text) {
      _oldText = text;
    }

    List<TextSpan> children = [];
    int start = 0;
    _specialInput.forEach((input) {
      if (start < input.start) {
        children.add(TextSpan(
            text: text.substring(start, input.start),
            style: TextStyle(color: Colors.black)));
      }
      children.add(TextSpan(
          text: text.substring(input.start, input.end),
          style: TextStyle(color: GPColor.functionLinkPrimary)));
      start = input.end;
    });
    if (start < text.length) {
      children.add(TextSpan(
          text: text.substring(start, text.length),
          style: TextStyle(color: Colors.black)));
    }
    return TextSpan(children: children);
  }
}

abstract class _SpecialInput {
  int start;
  int end;

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

import 'dart:math';

import 'package:base_flutter/models/api/assignee_response.dart';
import 'package:base_flutter/theme/colors.dart';
import 'package:flutter/material.dart';

RegExp _tagRegex = RegExp(
  r"^@{1}[a-zA-Z]+\b",
  caseSensitive: false,
  multiLine: false,
);

RegExp _phoneRegex = RegExp(
  r'^(?:\+?88|0088)?01[13-9]\d{8}$',
  caseSensitive: false,
  multiLine: false,
);

RegExp _emailRegex = RegExp(
  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  caseSensitive: true,
  multiLine: false,
);

class RichTextEditingController extends TextEditingController {
  var _specialInput = <_SpecialInput>[];
  String _oldText = "";
  int _oldBaseOffset = 0;
  int _oldExtentOffset = 0;

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
    if (_tagRegex.hasMatch(text.substring(start, selection.baseOffset))) {
      text = text.replaceRange(
          start, selection.baseOffset, assignee.displayName! + " ");
      _oldText = text;
      _specialInput.add(
          _TagInput(assignee, start, assignee.displayName!.length + start));
      _specialInput.sort((a, b) => a.start - b.start);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        selection = TextSelection.fromPosition(
            TextPosition(offset: assignee.displayName!.length + start + 1));
      });
    }
    onMatchTag("");
  }

  void _checkMatchTag() {
    if (selection.baseOffset < 0) return;
    int start = max(0, selection.baseOffset - 1);
    while (start > 0 &&
        text.characters.characterAt(start - 1) != Characters(' ')) {
      start--;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_tagRegex.hasMatch(text.substring(start, selection.baseOffset))) {
        onMatchTag(text.substring(start + 1, selection.baseOffset));
      } else {
        onMatchTag("");
      }
    });
  }

  void _textChangeInRange(int start, int end, int offset) {
    List<_SpecialInput> temp = <_SpecialInput>[]..addAll(_specialInput);
    _specialInput.forEach((element) {
      if (element.start >= start || element.end <= end) {
        temp.remove(element);
      }
    });
    _specialInput = temp;
    _specialInput.forEach((element) {
      if (element.start > start) {
        element.start += offset;
        element.end += offset;
      }
    });
  }

  void _detectChangeOnTextLengthNotChanged() {
    if (_oldBaseOffset != _oldExtentOffset &&
        selection.extentOffset == _oldExtentOffset) {
      if (text.substring(_oldBaseOffset, _oldExtentOffset) !=
          text.substring(_oldBaseOffset, _oldExtentOffset)) {
        _textChangeInRange(_oldBaseOffset, _oldExtentOffset, 0);
      }
    }
  }

  void _onModifyNonSelection() {
    int current = selection.baseOffset;
    int offset = selection.baseOffset - _oldBaseOffset;
    if (_oldText.length < text.length) {
      // add characters
      _SpecialInput? temp;
      _specialInput.forEach((element) {
        if (element.start < current - offset && element.end >= current) {
          temp = element;
        }
      });
      if (temp != null && temp is _TagInput) {
        _specialInput.remove(temp);
      }
      _specialInput.forEach((element) {
        if (element.start + offset >= current) {
          element.start += offset;
          element.end += offset;
        }
      });
    } else {
      // delete characters
      _SpecialInput? temp;
      _specialInput.forEach((element) {
        if (element.start <= current && element.end > current) {
          temp = element;
        }
      });
      if (temp != null && temp is _TagInput) {
        _specialInput.remove(temp);
        if (temp!.end >= current && _oldBaseOffset > temp!.end) {
          text = text.replaceRange(temp!.start, current, "");
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            selection = TextSelection.fromPosition(
                TextPosition(offset: current - (temp!.end - temp!.start) + 1));
          });
          _specialInput.forEach((element) {
            if (element.start >= current) {
              element.start -= _oldBaseOffset - temp!.start;
              element.end -= _oldBaseOffset - temp!.start;
            }
          });
        } else {
          _specialInput.forEach((element) {
            if (element.start >= current) {
              element.start += offset;
              element.end += offset;
            }
          });
        }
      } else {
        _specialInput.forEach((element) {
          if (element.start >= current) {
            element.start += offset;
            element.end += offset;
          }
        });
      }
    }
  }

  void _onModifySelection() {
    _textChangeInRange(_oldBaseOffset, _oldExtentOffset,
        selection.baseOffset - _oldExtentOffset);
  }

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    _checkMatchTag();
    int current = selection.baseOffset;
    if (_oldText.length == text.length) {
      _detectChangeOnTextLengthNotChanged();
    } else {
      if (_oldBaseOffset == _oldExtentOffset) {
        // change more than one
        _onModifyNonSelection();
      } else {
        _onModifySelection();
      }
    }

    if (_oldText != text) {
      _oldText = text;
    }

    _oldBaseOffset = selection.baseOffset;
    _oldExtentOffset = selection.extentOffset;

    List<TextSpan> children = [];
    int start = 0;
    _specialInput.forEach((input) {
      if (start < input.start) {
        children.add(TextSpan(
            text: text.substring(start, input.start),
            style: const TextStyle(color: Colors.black)));
      }
      children.add(TextSpan(
          text: text.substring(input.start, input.end),
          style: const TextStyle(color: GPColor.functionLinkPrimary)));
      start = input.end;
    });
    if (start < text.length) {
      children.add(TextSpan(
          text: text.substring(start, text.length),
          style: const TextStyle(color: Colors.black)));
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

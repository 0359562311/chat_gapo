import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:base_flutter/configs/constants.dart';

String _convertToNonSpecialCase(String str) {
  str = str.toLowerCase();
  for (int i = 1; i < _vietnameseChar.length; i++) {
    for (int j = 0; j < _vietnameseChar[i].length; j++) {
      str = str.replaceAll(_vietnameseChar[i][j], _vietnameseChar[0][i - 1]);
    }
  }
  return str;
}

List<String> _vietnameseChar = [
  "aeouidy",
  "áàạảãâấầậẩẫăắằặẳẵ",
  "éèẹẻẽêếềệểễ",
  "óòọỏõôốồộổỗơớờợởỡ",
  "úùụủũưứừựửữ",
  "íìịỉĩ",
  "đ",
  "ýỳỵỷỹ",
];

extension StringExtension on String {
  /*
    Sử dụng để thêm params vào 1 string 
    Quy định cú pháp: "%{index}s", trong đó:
    - % là prefix
    - {index} là index của params cần thêm trong string
    - s là surfix
  */
  String _interpolate(String string, List<String> params) {
    String result = string;
    for (int i = 1; i < params.length + 1; i++) {
      result = result.replaceAll('%${i}s', params[i - 1]);
    }

    return result;
  }

  String format(List<String> params) => _interpolate(this, params);

  bool isValidEmail() {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
    return emailValid;
  }

  bool isValidPassword() {
    return length >= Constants.minPasswordLength && !contains(" ");
  }

  String hashSha256() {
    return sha256.convert(utf8.encode(this)).toString();
  }

  bool match(String other) {
    return _convertToNonSpecialCase(this)
        .contains(_convertToNonSpecialCase(other));
  }
}

extension DoubleExtension on double {
  String amountText() {
    RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
    String number =
        num.parse(toStringAsFixed(6)).toString().replaceAll(regex, '');
    return number;
  }

  String bigAmountText() {
    if (this >= 1000000) {
      return (this / 1000000).toStringAsFixed(1) + 'M';
    }
    if (this >= 1000) {
      return (this / 1000).round().toString() + 'K';
    }
    return num.parse(toStringAsFixed(3)).toString();
  }
}
extension StringExtension on String {
  bool match(String other) {
    return _convertToNonSpecialCase(this)
        .contains(_convertToNonSpecialCase(other));
  }
}

String _convertToNonSpecialCase(String str) {
  str = str.toLowerCase();
  for (int i = 1; i < vietnameseChar.length; i++) {
    for (int j = 0; j < vietnameseChar[i].length; j++)
      str = str.replaceAll(vietnameseChar[i][j], vietnameseChar[0][i - 1]);
  }
  return str;
}

List<String> vietnameseChar = [
  "aeouidy",
  "áàạảãâấầậẩẫăắằặẳẵ",
  "éèẹẻẽêếềệểễ",
  "óòọỏõôốồộổỗơớờợởỡ",
  "úùụủũưứừựửữ",
  "íìịỉĩ",
  "đ",
  "ýỳỵỷỹ",
];

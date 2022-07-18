import 'package:base_flutter/theme/colors.dart';
import 'package:base_flutter/theme/text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

class GPSnackbar {
  const GPSnackbar._();

  static void showUndoSnackBar(String message, VoidCallback onUndo) {
    Get.showSnackbar(GetSnackBar(
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.only(top: 20),
      icon: const Icon(
        Icons.done,
        size: 24,
        color: GPColor.functionLinkPrimary,
      ),
      messageText: Expanded(
        child: Text(
          "Lưu trữ cuộc hội thoại thành công",
          style:
              textStyle(GPTypography.bodyMedium)?.copyWith(color: Colors.white),
        ),
      ),
      mainButton: Row(
        children: [
          Container(
            width: 1,
            height: 20,
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 12),
          ),
          TextButton(
            child: Text(
              "Hoàn tác",
              style: textStyle(GPTypography.headingMedium)
                  ?.copyWith(color: GPColor.functionLinkPrimary),
            ),
            onPressed: onUndo,
          ),
        ],
      ),
      duration: const Duration(seconds: 2),
    ));
  }
}

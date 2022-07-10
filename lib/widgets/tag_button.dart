import 'package:flutter/material.dart';
import 'package:base_flutter/theme/colors.dart';
import 'package:base_flutter/theme/text_theme.dart';

class TagButton extends StatelessWidget {
  final String title;
  final Color borderColor;
  final Color selectedColor;
  late final Color? normalColor;
  final bool selected;
  final VoidCallback onPressed;
  final double height;
  final TextStyle? selectedStyle;
  final double borderWidth;

  TagButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.height = 32,
    this.borderColor = GPColor.workPrimary,
    this.selectedColor = GPColor.functionPositiveSecondary,
    this.selected = false,
    this.normalColor,
    this.selectedStyle,
    this.borderWidth = 1.5,
  }) : super(key: key) {
    normalColor = GPColor.bgSecondary;
  }

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      labelPadding: const EdgeInsets.all(0),
      label: Text(
        title,
        style: selected
            ? selectedStyle
            : textStyle(GPTypography.bodyMedium)
                ?.mergeColor(GPColor.contentPrimary),
      ),
      backgroundColor: selected ? selectedColor : normalColor,
      side: selected
          ? BorderSide(color: selectedColor, width: borderWidth)
          : BorderSide(
              color: GPColor.bgSecondary,
              width: borderWidth,
              style: BorderStyle.none),
      onPressed: onPressed,
    );
  }
}

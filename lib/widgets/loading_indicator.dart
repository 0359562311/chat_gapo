import 'package:chat_intern/theme/color_theme.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
              child: CircularProgressIndicator(
                color: AppColors.contentPrimary,
              ),
            );
  }
}
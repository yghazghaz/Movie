import 'package:flutter/material.dart';
import 'package:movie/core/utils/app_colors.dart';
import 'package:movie/core/utils/app_strings.dart';


class CustomTitleWidget extends StatelessWidget {
  const CustomTitleWidget({super.key, required this.title});
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Text(
      overflow: .visible,
      title ?? "Unknown Title",
      style: TextStyle(
        color: AppColors.white,
        fontWeight: .bold,
        fontSize: 19,
        fontFamily: AppStrings.fontMontserrat,
      ),
    );
  }
}

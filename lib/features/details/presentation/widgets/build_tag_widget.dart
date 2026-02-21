import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie/core/utils/app_colors.dart';
import 'package:movie/core/utils/app_strings.dart';



class BuildTagWidget extends StatelessWidget {
  const BuildTagWidget({super.key, required this.icon, required this.text});
  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(icon, height: 20),
        SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
            color: AppColors.gray,
            fontSize: 14,
            fontFamily: AppStrings.fontMontserrat,
          ),
        ),
      ],
    );
  }
}

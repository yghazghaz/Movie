import 'package:flutter/material.dart';
import 'package:movie/core/utils/app_colors.dart';


class TitleLoadingWidget extends StatelessWidget {
  const TitleLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: .only(top: 20),
      height: 20,
      width: 150,
      decoration: BoxDecoration(
        color: AppColors.gray,
        borderRadius: .circular(8),
      ),
    );
  }
}

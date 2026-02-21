import 'package:flutter/material.dart';
import 'package:movie/core/utils/app_colors.dart';


class LoadingTemplate extends StatelessWidget {
  const LoadingTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95,
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.gray,
        borderRadius: .circular(16),
      ),
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: AppColors.white,
        ),
      ),
    );
  }
}

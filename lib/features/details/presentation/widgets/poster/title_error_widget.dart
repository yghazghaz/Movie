import 'package:flutter/material.dart';
import 'package:movie/core/utils/app_colors.dart';

class TitleErrorWidget extends StatelessWidget {
  const TitleErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: .circular(16),
        color: AppColors.gray ,
      ),
      child: const Center(child: Icon(Icons.error, color: AppColors.red)),
    );
  }
}

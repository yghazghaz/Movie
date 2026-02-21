import 'package:flutter/material.dart';
import 'package:movie/core/utils/app_colors.dart';


class ErrorTemplate extends StatelessWidget {
  const ErrorTemplate({super.key, required this.error});
  final String error;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95,
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.gray,
        borderRadius: .circular(16),
      ),
      child: const Center(
        child: Icon(Icons.broken_image, color: AppColors.white),
      ),
    );
  }
}

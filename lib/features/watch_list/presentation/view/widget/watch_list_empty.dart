import 'package:flutter/material.dart';
import 'package:movie/core/utils/app_colors.dart';
import 'package:movie/core/utils/app_images.dart';
import 'package:movie/core/utils/app_strings.dart' show AppStrings;

class WatchListEmpty extends StatelessWidget {
  const WatchListEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.noSavedMovies),
            const SizedBox(height: 16),
            Text(
              AppStrings.watchListEmptyTitle,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              AppStrings.watchListEmptySubtitle,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.gray,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/core/utils/app_colors.dart';
import 'package:movie/core/utils/app_images.dart';
import 'package:movie/core/utils/app_strings.dart' ;

class WatchListEmpty extends StatelessWidget {
  const WatchListEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 32.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.noSavedMovies),
             SizedBox(height: 16.h),
            Text(
              AppStrings.watchListEmptyTitle,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
              textAlign: TextAlign.center,
            ),
             SizedBox(height: 8.h),
            Text(
              AppStrings.watchListEmptySubtitle,
              style: TextStyle(
                fontSize: 12.sp,
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

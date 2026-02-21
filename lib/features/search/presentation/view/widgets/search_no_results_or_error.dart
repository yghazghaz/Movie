import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_images.dart';

class SearchNoResultsOrError extends StatelessWidget {
  const SearchNoResultsOrError({
    super.key,
    required this.headMessage,
    this.subMessage = '',
    this.textColor,
  });
  final String headMessage;
  final String subMessage;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 252.w,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            Image.asset(
              AppImages.noSearchResults,
              width: 76.w,
              height: 76.h,
              fit: .contain,
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: 188.w,
              child: Text(
                headMessage,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: .w600,
                  letterSpacing: 0.12,
                  height: 1.5,
                  color: textColor ?? Color(0xffEBEBEF),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 8.h),
            SizedBox(
              width: 188.w,
              child: Text(
                subMessage,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: .w500,
                  color: Color(0xffEBEBEF),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

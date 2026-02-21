import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/utils/api_constants.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_icons.dart';

class SearchMovieWidget extends StatelessWidget {
  const SearchMovieWidget({
    super.key,
    this.imagePath,
    required this.movieTitle,
    required this.movieType,
    required this.movieRate,
    required this.movieDate,
    this.itemOnTap,
    this.movieDuration,
  });
  final String? imagePath;
  final String? movieTitle;
  final String? movieDate;
  final String? movieType;
  final double? movieRate;
  final int? movieDuration;

  final void Function()? itemOnTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: itemOnTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: SizedBox(
                  width: 95.w,
                  child: AspectRatio(
                    aspectRatio: 9 / 12,
                    child: CachedNetworkImage(
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height / 15,

                      imageUrl: (imagePath == null || imagePath!.isEmpty)
                          ? ""
                          : "${ApiConstants.imagePath}$imagePath",
                      placeholder: (context, url) => Center(
                        child: Skeletonizer(
                          enabled: true,
                          child: Container(color: AppColors.gray),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movieTitle ?? "",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: .w400,
                        color: AppColors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 14.h),
                    IconAndTextRowItem(
                      text: (movieRate == null || movieRate == 0)
                          ? "--"
                          : movieRate!.toStringAsFixed(1),
                      textColor: Color(0xffFF8700),
                      textFontWeight: .w600,
                      iconPath: AppIcons.star,
                    ),
                    SizedBox(height: 4.h),

                    IconAndTextRowItem(
                      text: movieType ?? "UnKnown",
                      iconPath: AppIcons.ticket,
                    ),
                    SizedBox(height: 4.h),
                    IconAndTextRowItem(
                      text: movieDate ?? "N/A",
                      iconPath: AppIcons.calendar,
                    ),

                    SizedBox(height: 4.h),

                    IconAndTextRowItem(
                      text: movieDuration == null
                          ? 'UnKnown'
                          :'${movieDuration.toString()}minutes' ,
                      iconPath: AppIcons.clock,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IconAndTextRowItem extends StatelessWidget {
  const IconAndTextRowItem({
    super.key,
    required this.text,
    required this.iconPath,
    this.textColor,
    this.textFontWeight,
  });
  final String text;
  final Color? textColor;
  final String iconPath;
  final FontWeight? textFontWeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        SvgPicture.asset(iconPath),
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12.sp,
              color: textColor ?? Color(0xffEEEEEE),
              fontWeight: textFontWeight ?? .w400,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

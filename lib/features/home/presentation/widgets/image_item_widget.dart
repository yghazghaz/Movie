import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie/core/utils/api_constants.dart';
import 'package:movie/core/utils/app_colors.dart';
import 'package:movie/core/utils/app_strings.dart';

import 'package:skeletonizer/skeletonizer.dart';

class TopMovieCard extends StatelessWidget {
  const TopMovieCard({
    super.key,
    required this.index,
    this.imageUrl,
    this.onTap,
  });
  final int index;
  final String? imageUrl;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width / 2.5,
        height: 210,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AspectRatio(
                aspectRatio: 144 / 210,
                child: CachedNetworkImage(
                  imageUrl: "${ApiConstants.imagePath}$imageUrl",
                  fit: BoxFit.cover,
                  placeholder: (_, _) => Center(
                    child: Skeletonizer(
                      enabled: true,
                      child: Container(color: AppColors.gray),
                    ),
                  ),
                  errorWidget: (_, _, _) => const ColoredBox(
                    color: AppColors.gray,
                    child: Center(
                      child: Icon(
                        Icons.broken_image_outlined,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: -10,
              bottom: -20,
              child: Stack(
                children: [
                  Text(
                    '${index + 1}',
                    style: TextStyle(
                      fontSize: MediaQuery.sizeOf(context).width / 3,
                      fontFamily: AppStrings.fontMontserrat,
                      fontWeight: FontWeight.w900,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 8
                        ..color = AppColors.blue,
                    ),
                  ),
                  Text(
                    '${index + 1}',
                    style: TextStyle(
                      fontSize: MediaQuery.sizeOf(context).width / 3,
                      fontFamily: AppStrings.fontMontserrat,
                      fontWeight: FontWeight.w900,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 4
                        ..color = const Color(0xFF1A202C),
                    ),
                  ),
                  Text(
                    '${index + 1}',
                    style: TextStyle(
                      fontSize: MediaQuery.sizeOf(context).width / 3,
                      fontFamily: AppStrings.fontMontserrat,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

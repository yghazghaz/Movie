
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie/core/utils/api_constants.dart';
import 'package:movie/core/utils/app_colors.dart';
import 'package:movie/core/utils/app_icons.dart';


class MovieBannerCustomWidget extends StatelessWidget {
  final String? backdropPath;
  final double rateValue;

  const MovieBannerCustomWidget({
    super.key,
    required this.backdropPath,
    required this.rateValue,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: .bottomRight,
      children: [
        SizedBox(
          height: 210,
          width: .infinity,
          child: CachedNetworkImage(
            imageUrl: "${ApiConstants.imagePath}$backdropPath",
            fit: .cover,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(color: AppColors.orange),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),

        Padding(
          padding: .only(right: 15, bottom: 10),
          child: ClipRRect(
            borderRadius: .circular(8),
            child: Container(
              padding: .symmetric(
                vertical: 5,
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: .circular(10),
              ),
              child: Row(
                mainAxisSize: .min,
                children: [
                  SvgPicture.asset(AppIcons.star),
                  SizedBox(width:  5),
                  Text(
                    rateValue.toStringAsFixed(1),
                    style: const TextStyle(
                      color: AppColors.orange,
                      fontWeight: .bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

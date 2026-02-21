import 'package:flutter/material.dart';
import 'package:movie/core/utils/app_colors.dart';
import 'package:movie/core/utils/app_icons.dart';
import 'package:movie/core/utils/app_strings.dart';
import 'package:movie/features/details/presentation/view/widgets/build_tag_widget.dart';

import '../../../domain/entities/movie_details_entity.dart';

class MovieDetailsStatusCustomWidget extends StatelessWidget {
  final MovieDetailsEntity movieDetailsEntity;

  const MovieDetailsStatusCustomWidget({
    super.key,
    required this.movieDetailsEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            mainAxisAlignment: .center,
            children: [
              BuildTagWidget(
                icon: AppIcons.calendar,
                text: movieDetailsEntity.releaseDate.split("-")[0],
              ),

              SizedBox(width: 10),
              Container(width: 2, height: 20, color: AppColors.gray),
              SizedBox(width: 10),

              BuildTagWidget(
                icon: AppIcons.clock,
                text: "${movieDetailsEntity.runtime} Min",
              ),

              SizedBox(width: 10),
              Container(width: 2, height: 20, color: AppColors.gray),
              SizedBox(width: 10),

              BuildTagWidget(
                icon: AppIcons.ticket,
                text: movieDetailsEntity.genres.isNotEmpty
                    ? movieDetailsEntity.genres.first
                    : "Unknown",
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            movieDetailsEntity.overview,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 13,
              fontFamily: AppStrings.fontMontserrat,
              fontWeight: FontWeight.w600,
            ),
            textAlign: .start,
          ),
        ],
      ),
    );
  }
}

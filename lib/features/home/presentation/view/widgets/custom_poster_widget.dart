import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie/core/utils/api_constants.dart';
import 'package:movie/core/utils/app_colors.dart';
import 'package:movie/core/utils/app_size.dart';
import 'package:movie/features/details/presentation/view/details_screen.dart';

import 'package:skeletonizer/skeletonizer.dart';


class CustomPosterWidget extends StatelessWidget {
  const CustomPosterWidget({super.key, this.state});
  final    state;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: state.listOfMovies.length,
      itemBuilder: (context, index) {
        final movie = state.listOfMovies[index];
        return InkWell(
          onTap: () {
            Navigator.of(
              context,
            ).pushNamed(DetailsScreen.routeName, arguments: movie.id);
          },
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(16),

            child: AspectRatio(
              aspectRatio: 100 / 146,
              child: CachedNetworkImage(
                imageUrl: ApiConstants.imagePath + movie.posterPath!,
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
        );
      },

      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(width: AppSizes.w20),
    );
  }
}

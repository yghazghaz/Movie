import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie/core/utils/api_constants.dart';
import 'package:movie/core/utils/app_colors.dart';
import 'package:movie/core/utils/app_strings.dart';
import 'package:movie/features/details/presentation/view/details_screen.dart';

import '../../../domain/entities/similar_movie_entity.dart';

class MovieRelatedListCustomWidget extends StatelessWidget {
  final List<SimilarMovieEntity> similarMovies;
  final bool isLoading;
  final String errorMessage;

  const MovieRelatedListCustomWidget({
    super.key,
    required this.similarMovies,
    this.isLoading = false,
    this.errorMessage = "",
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.orange),
      );
    }

    if (errorMessage.isNotEmpty) {
      return Text(errorMessage, style: const TextStyle(color: AppColors.red));
    }

    if (similarMovies.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: .only(left: 20, bottom: 10),
          child: Text(
            AppStrings.similar,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 15,
              fontWeight: .w500,
              fontFamily: AppStrings.fontMontserrat,
            ),
          ),
        ),

        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: .symmetric(horizontal: 15),
          itemCount: similarMovies.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.7,
            crossAxisSpacing: 4,
            mainAxisExtent: 145,
            mainAxisSpacing: 18,
          ),
          itemBuilder: (context, index) {
            final movie = similarMovies[index];

            return InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  DetailsScreen.routeName,
                  arguments: movie.id,
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 9),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: movie.posterPath != null
                      ? CachedNetworkImage(
                          imageUrl:
                              "${ApiConstants.imagePath}${movie.posterPath}",
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        )
                      : Container(color: AppColors.gray),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

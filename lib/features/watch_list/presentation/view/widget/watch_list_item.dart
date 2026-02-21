import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie/core/utils/api_constants.dart';
import 'package:movie/core/utils/app_colors.dart';
import 'package:movie/core/utils/app_icons.dart';
import 'package:movie/features/details/presentation/view/details_screen.dart';
import 'package:movie/features/search/presentation/view/widgets/search_movie_widget.dart';
import 'package:movie/features/watch_list/data/models/watch_list_model.dart';

class WatchListItem extends StatelessWidget {
  WatchListItem({
    super.key,

    required this.onRemove,
    required this.movieTitle,
    required this.movieType,
    required this.movieRate,
    required this.movieDate,
    required this.posterPath,
    required this.movieId,
  });

  final String? posterPath;
  final String? movieTitle;
  final String? movieType;
  final double? movieRate;
  final String? movieDate;
  final int? movieId;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          Expanded(
            child: SearchMovieWidget(
              imagePath: posterPath,
              movieTitle: movieTitle,
              movieType: movieType,
              movieRate: movieRate,
              movieDate: movieDate,
              itemOnTap: () => Navigator.pushNamed(
                context,
                DetailsScreen.routeName,
                arguments: movieId,
              ),
            ),
          ),
          IconButton(
            icon: SvgPicture.asset(AppIcons.saveFilled),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}

class _Poster extends StatelessWidget {
  const _Poster({required this.posterPath});
  final String? posterPath;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(12);
    if (posterPath == null || posterPath!.isEmpty) {
      return Container(
        width: 60,
        height: 90,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: AppColors.gray,
        ),
        child: const Icon(Icons.image_not_supported_outlined),
      );
    }
    return ClipRRect(
      borderRadius: borderRadius,
      child: CachedNetworkImage(
        width: 60,
        height: 90,
        fit: BoxFit.cover,
        imageUrl: '${ApiConstants.imagePath}$posterPath',
        errorWidget: (_, __, ___) => Container(
          width: 60,
          height: 90,
          color: AppColors.gray,
          child: const Icon(Icons.image_not_supported_outlined),
        ),
      ),
    );
  }
}

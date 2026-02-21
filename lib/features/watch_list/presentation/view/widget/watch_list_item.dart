import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie/core/dialogs/app_toast.dart';
import 'package:movie/core/utils/app_icons.dart';
import 'package:movie/features/details/presentation/view/details_screen.dart';
import 'package:movie/features/search/presentation/view/widgets/search_movie_widget.dart';
import 'package:toastification/toastification.dart';

class WatchListItem extends StatelessWidget {
  const WatchListItem({
    super.key,
    required this.onRemove,
    required this.movieTitle,
    required this.movieType,
    required this.movieRate,
    required this.movieDate,
    required this.posterPath,
    required this.movieId,
    this.movieDuration,
  });

  final String? posterPath;
  final String? movieTitle;
  final String? movieType;
  final double? movieRate;
  final int? movieDuration;
  final String? movieDate;
  final int? movieId;
  final void Function() onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 29.w, right: 15.w),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          Expanded(
            child: SearchMovieWidget(
              imagePath: posterPath,
              movieTitle: movieTitle,
              movieType: movieType,
              movieRate: movieRate,
              movieDate: movieDate,
              movieDuration: movieDuration,
              itemOnTap: () => Navigator.pushNamed(
                context,
                DetailsScreen.routeName,
                arguments: movieId,
              ),
            ),
          ),
          IconButton(
            icon: SvgPicture.asset(AppIcons.saveFilled),
            onPressed: () {
              onRemove();
              AppToast.showToast(
                context: context,
                title: "REMOVED",
                description: "Movie removed from watch list",
                type: ToastificationType.error,
              );
            },
          ),
        ],
      ),
    );
  }
}

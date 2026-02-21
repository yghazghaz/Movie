import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/features/watch_list/presentation/view/widget/watch_list_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WatchListLoading extends StatelessWidget {
  const WatchListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 24.h),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Skeletonizer(
          child: WatchListItem(
            movieTitle: "movieDescription",
            movieType: "movieType",
            movieRate: 5.5,
            movieDate: "movieDate",
            movieDuration: 139,
            onRemove: () {},
            posterPath: '',
            movieId: null,
          ),
        );
      },
    );
  }
}

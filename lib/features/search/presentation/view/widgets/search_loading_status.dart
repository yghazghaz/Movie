import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/features/search/presentation/view/widgets/search_movie_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchLoadingStatus extends StatelessWidget {
  const SearchLoadingStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 24.h,),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Skeletonizer(
          child: SearchMovieWidget(
            movieTitle: "UnKnown",
            movieType: "Action",
            movieRate: 3.5,
            movieDate: "2005",
            movieDuration: 139,
          ),
        );
      },
    );
  }
}

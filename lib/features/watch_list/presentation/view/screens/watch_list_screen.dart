// ignore_for_file: unnecessary_underscores

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/core/utils/app_colors.dart';
import 'package:movie/core/utils/app_strings.dart';
import 'package:movie/core/utils/genre_constants.dart';
import 'package:movie/features/watch_list/presentation/view/widget/watch_list_empty.dart';
import 'package:movie/features/watch_list/presentation/view/widget/watch_list_item.dart';
import 'package:movie/features/watch_list/presentation/view_model/watch_list_cubit.dart';
import 'package:movie/features/watch_list/presentation/view_model/watch_list_state.dart';

class WatchListScreen extends StatelessWidget {
  const WatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          AppStrings.watchList,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<WatchListCubit, WatchListState>(
        builder: (context, state) {
          if (state is WatchListError && state.items.isEmpty) {
            return Center(
              child: Text(state.error, textAlign: TextAlign.center),
            );
          }
          final items = state.items;

          if (items.isEmpty) {
            return const WatchListEmpty();
          }
          final listView = ListView.separated(
            itemBuilder: (context, index) {
              final item = items[index];
              return WatchListItem(
                movieId: item.id,
                posterPath: item.posterPath,
                onRemove: () =>
                    context.read<WatchListCubit>().removeMovie(item.id),
                movieTitle: item.title,
                movieType: item.genreIds != null && item.genreIds!.isNotEmpty
                    ? GenreConstants.movieGenres[item.genreIds!.first]
                    : "Unknown",
                movieDuration: item.runtime?.toInt(),
                movieRate: item.voteAverage,
                movieDate: _extractYear(item.releaseDate),
              );
            },
            separatorBuilder: (_, __) => SizedBox(height: 12.h),
            itemCount: items.length,
          );
          if (state is WatchListLoading) {
            return Stack(
              children: [
                listView,
                const Positioned.fill(
                  child: IgnorePointer(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
              ],
            );
          }
          if (state is WatchListError) {
            return Stack(
              children: [
                listView,
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 24,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      state.error,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
              ],
            );
          }
          return listView;
        },
      ),
    );
  }

String _extractYear(String? date) {
  if (date == null || date.trim().isEmpty) {
    return "N/A";
  }

  final parsedDate = DateTime.tryParse(date.trim());

  if (parsedDate == null) {
    return "N/A";
  }

  return parsedDate.year.toString();
}
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/utils/app_colors.dart';
import 'package:movie/core/utils/app_strings.dart';

import 'package:movie/features/watch_list/data/models/watch_list_model.dart';

import 'package:movie/features/watch_list/presentation/view/widget/watch_list_empty.dart';
import 'package:movie/features/watch_list/presentation/view/widget/watch_list_item.dart'
    show WatchListItem;
import 'package:movie/features/watch_list/presentation/view_model/watch_list_cubit.dart';
import 'package:movie/features/watch_list/presentation/view_model/watch_list_state.dart'
    show WatchListState, WatchListError, WatchListLoading;

class WatchListScreen extends StatelessWidget {
  const WatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          AppStrings.watchList,
          style: TextStyle(
            fontSize: 16,
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            itemBuilder: (context, index) {
              final item = items[index];
              return WatchListItem(
                movieId: item.id,
                posterPath: item.posterPath,
                onRemove: () =>
                    context.read<WatchListCubit>().removeMovie(item.id),
                movieTitle: item.title,
                movieType: item.title,
                movieRate: item.voteAverage,
                movieDate: item.releaseDate,
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 12),
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
}

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/di/di.dart';
import 'package:movie/core/dialogs/app_toast.dart';
import 'package:movie/core/utils/app_colors.dart';
import 'package:movie/core/utils/app_strings.dart';
import 'package:movie/features/details/presentation/view/widgets/app_bar/custom_app_bar.dart';
import 'package:movie/features/details/presentation/view/widgets/movie_banner_custom_widget.dart';
import 'package:movie/features/details/presentation/view/widgets/movie_details_status_custom_widget.dart';
import 'package:movie/features/details/presentation/view/widgets/movie_poster_title_custom_widget.dart';
import 'package:movie/features/details/presentation/view/widgets/movie_related_list_custom_widget.dart';
import 'package:movie/features/details/presentation/view_model/details_cubit.dart';
import 'package:movie/features/details/presentation/view_model/details_state.dart';
import 'package:toastification/toastification.dart';

import '../../../watch_list/data/models/watch_list_model.dart';
import '../../../watch_list/presentation/view_model/watch_list_cubit.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  static const routeName = 'DetailsScreen';

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late final DetailsCubit _detailsCubit;
  int? movieId;
  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    _detailsCubit = getIt<DetailsCubit>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;

    if (args != null && args is int) {
      if (movieId == null || movieId != args) {
        movieId = args;

        _detailsCubit.getMovieDetails(movieId!);
        _detailsCubit.getSimilarMovies(movieId!);

        final watchListCubit = context.read<WatchListCubit>();
        isSaved = watchListCubit.isMovieSaved(movieId!);
      }
    }
  }

  @override
  void dispose() {
    _detailsCubit.close();
    super.dispose();
  }

  Future<void> _toggleSaveMovie() async {
    if (movieId == null || _detailsCubit.state.movieDetails == null) return;

    final watchListCubit = context.read<WatchListCubit>();
    final movieDetails = _detailsCubit.state.movieDetails!;

    final watchListItem = WatchListModel(
      id: movieId!,
      title: movieDetails.title,
      posterPath: movieDetails.posterPath,
      backdropPath: movieDetails.backdropPath,
      releaseDate: movieDetails.releaseDate,
      voteAverage: movieDetails.voteAverage,
      genreIds: movieDetails.genreIds,
    );

    await watchListCubit.toggleMovie(watchListItem);

    final savedNow = watchListCubit.isMovieSaved(movieId!);

    setState(() {
      isSaved = savedNow;
    });

    AppToast.showToast(
      context: context,
      title: savedNow ? "SAVED" : "REMOVED",
      description: savedNow
          ? "Movie ${AppStrings.addedToWatchList}"
          : "Movie ${AppStrings.removedFromWatchList}",
      type: savedNow ? ToastificationType.success : ToastificationType.error,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (movieId == null) {
      return const Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(child: CircularProgressIndicator(color: AppColors.orange)),
      );
    }

    return BlocProvider(
      create: (_) => _detailsCubit,
      child: Scaffold(
        backgroundColor: AppColors.primary,
        appBar: CustomAppBar(isSaved: isSaved, onSaveTapped: _toggleSaveMovie),
        body: BlocConsumer<DetailsCubit, DetailsState>(
          listener: (context, state) {
            if (state.movieDetailsState == RequestState.error) {
              AppToast.showToast(
                context: context,
                title: "Oops!",
                description: state.movieDetailsMessage,
                type: ToastificationType.error,
              );
            }
          },
          builder: (context, state) {
            if (state.movieDetailsState == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.orange),
              );
            }

            if (state.movieDetailsState == RequestState.error) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.wifi_off_rounded,
                        color: AppColors.red,
                        size: 60,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.movieDetailsMessage,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state.movieDetailsState == RequestState.loaded) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MovieBannerCustomWidget(
                      rateValue: state.movieDetails!.voteAverage,
                      backdropPath: state.movieDetails!.backdropPath,
                    ),
                    MoviePosterTitleCustomWidget(
                      title: state.movieDetails!.title,
                      posterUrl: state.movieDetails!.posterPath,
                    ),
                    const SizedBox(height: 16),
                    MovieDetailsStatusCustomWidget(
                      movieDetailsEntity: state.movieDetails!,
                    ),
                    const SizedBox(height: 20),
                    MovieRelatedListCustomWidget(
                      similarMovies: state.similarMovies,
                      isLoading:
                          state.similarMoviesState == RequestState.loading,
                      errorMessage: state.similarMoviesMessage,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}

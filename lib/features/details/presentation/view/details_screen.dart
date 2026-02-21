import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/dialogs/app_toast.dart';
import 'package:movie/core/utils/app_colors.dart';
import 'package:movie/core/utils/app_strings.dart';
import 'package:movie/features/details/presentation/widgets/app_bar/custom_app_bar.dart';
import 'package:movie/features/details/presentation/widgets/movie_banner_custom_widget.dart';
import 'package:movie/features/watch_list/data/models/watch_list_model.dart';
import 'package:movie/features/watch_list/presentation/view_model/watch_list_cubit.dart';
import 'package:toastification/toastification.dart';
import '../../data/api/details_api.dart';
import '../../data/repository/data_source/details_data_source_imp.dart';
import '../../data/repository/repo/details_repo_imp.dart';
import '../../domain/use_case/get_movie_details_use_case.dart';
import '../../domain/use_case/get_similar_movies_use_case.dart';
import '../view_model/details_cubit.dart';
import '../view_model/details_state.dart';
import '../widgets/movie_details_status_custom_widget.dart';
import '../widgets/movie_poster_title_custom_widget.dart';
import '../widgets/movie_related_list_custom_widget.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  static String get routeName => 'DetailsScreen';

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isSaved = false;
  int? movieId; 
  late final DetailsCubit detailsCubit;

  @override
  void initState() {
    super.initState();
    final api = DetailsApi();
    final dataSource = DetailsDataSourceImpl(detailsApi: api);
    final repo = DetailsRepoImpl(dataSource);
    final detailsUseCase = GetMovieDetailsUseCase(repo);
    final similarUseCase = GetSimilarMoviesUseCase(repo);

    detailsCubit = DetailsCubit(detailsUseCase, similarUseCase);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is int) {
      if (movieId == null || movieId != args) {
        movieId = args;
        detailsCubit.getMovieDetails(movieId!);
        detailsCubit.getSimilarMovies(movieId!);
      }
    }
  }

  @override
  void dispose() {
    detailsCubit.close();
    super.dispose();
  }

  void _toggleSaveMovie() async {
    if (movieId == null || detailsCubit.state.movieDetails == null) return;

    final watchListCubit = context.read<WatchListCubit>();
    final movieDetails = detailsCubit.state.movieDetails!;

    final watchListEntity = WatchListModel(
      id: movieId!,
      title: movieDetails.title,
      posterPath: movieDetails.posterPath,
      backdropPath: movieDetails.backdropPath,
      releaseDate: movieDetails.releaseDate,
      voteAverage: movieDetails.voteAverage,
    );

    await watchListCubit.toggleMovie(watchListEntity);

    final isNowSaved = watchListCubit.isMovieSaved(movieId!);

    setState(() {
      isSaved = isNowSaved;
    });


    if (isNowSaved) {
      AppToast.showToast(
        context: context,
        title: "SAVED",
        description: "Movie added to watch list",
        type: ToastificationType.success,
      );
    } else {
      AppToast.showToast(
        context: context,
        title: "REMOVED",
        description: "Movie removed from watch list",
        type: ToastificationType.success,
      );
    }
  }

  void _showFloatingSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            message,
            style: const TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Show loading or error if movieId is null
    if (movieId == null) {
      return Scaffold(
        backgroundColor: AppColors.primary,
        body: const Center(
          child: CircularProgressIndicator(color: AppColors.orange),
        ),
      );
    }

    return BlocProvider.value(
      value: detailsCubit,
      child: Scaffold(
        backgroundColor: AppColors.primary,
        appBar: CustomAppBar(isSaved: isSaved, onSaveTapped: _toggleSaveMovie),
        body: BlocConsumer<DetailsCubit, DetailsState>(
          listener: (context, state) {
            if (state.movieDetailsState == RequestState.error) {
              _showFloatingSnackBar(state.movieDetailsMessage, AppColors.red);
            }
          },
          builder: (context, state) {
            if (state.movieDetailsState == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.orange),
              );
            } else if (state.movieDetailsState == RequestState.error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, color: AppColors.red, size: 50),
                    const SizedBox(height: 10),
                    Text(
                      state.movieDetailsMessage,
                      style: const TextStyle(color: AppColors.white),
                    ),
                    const SizedBox(height: 10),
                    MaterialButton(
                      color: AppColors.orange,
                      textColor: AppColors.white,
                      onPressed: () {
                        detailsCubit.getMovieDetails(movieId!);
                        detailsCubit.getSimilarMovies(movieId!);
                      },
                      child: const Text(AppStrings.addedToWatchList),
                    ),
                  ],
                ),
              );
            } else if (state.movieDetailsState == RequestState.loaded) {
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
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

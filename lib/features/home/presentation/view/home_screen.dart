// ignore_for_file: unnecessary_underscores

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/di/di.dart';
import 'package:movie/core/dialogs/app_toast.dart';
import 'package:movie/core/utils/api_constants.dart';
import 'package:movie/core/utils/app_colors.dart';
import 'package:movie/core/utils/app_size.dart';
import 'package:movie/core/utils/app_strings.dart';
import 'package:movie/features/details/presentation/view/details_screen.dart';
import 'package:movie/features/home/presentation/view/widgets/custom_poster_widget.dart';
import 'package:movie/features/home/presentation/view/widgets/image_item_widget.dart';
import 'package:movie/features/home/presentation/view_model/popular_cubit/home-cubit.dart';
import 'package:movie/features/home/presentation/view_model/popular_cubit/home_state.dart';
import 'package:movie/features/home/presentation/view_model/recommended_cubit/home_recommended_cubit.dart';
import 'package:movie/features/home/presentation/view_model/release_cubit/home_release_cubit.dart';
import 'package:toastification/toastification.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final RecommendedCubit _recommendedCubit;
  late final PopularCubit _popularCubit;
  late final ReleasesCubit _releasesCubit;
  bool _isToastShown = false;

  void _handleErrorState(BuildContext context, HomeState state) {
    if (state is HomeError && !_isToastShown) {
      _isToastShown = true;

      AppToast.showToast(
        context: context,
        title: "Oops!",
        description: state.message,
        type: ToastificationType.error,
      );

      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) _isToastShown = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _recommendedCubit = getIt<RecommendedCubit>()
      ..intent(RecommendedMoviesIntent());

    _popularCubit = getIt<PopularCubit>()..intent(PopularMoviesIntent());

    _releasesCubit = getIt<ReleasesCubit>()..intent(ReleasesMoviesIntent());
  }

  @override
  void dispose() {
    _recommendedCubit.close();
    _popularCubit.close();
    _releasesCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _recommendedCubit),
        BlocProvider.value(value: _popularCubit),
        BlocProvider.value(value: _releasesCubit),
      ],
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: MultiBlocListener(
          listeners: [
            BlocListener<RecommendedCubit, HomeState>(
              listener: _handleErrorState,
            ),
            BlocListener<PopularCubit, HomeState>(listener: _handleErrorState),
            BlocListener<ReleasesCubit, HomeState>(listener: _handleErrorState),
          ],
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                right: AppSizes.w25,
                left: AppSizes.w25,
                top: AppSizes.h35,
              ),
              child: Column(
                children: [
                  _buildSectionTitle(AppStrings.popular),
                  _buildRecommendedSection(),
                  _buildSectionTitle(AppStrings.release),
                  _buildPopularSection(),
                  _buildSectionTitle(AppStrings.recommended),
                  _buildReleasesSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          title,
          style: const TextStyle(color: AppColors.white, fontSize: 20),
        ),
      ),
    );
  }

  Widget _buildRecommendedSection() {
    return SizedBox(
      height: 300,
      child: BlocBuilder<RecommendedCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.orange),
            );
          }

          if (state is HomeSuccess) {
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: state.listOfMovies.length,
              itemBuilder: (context, index) {
                final movie = state.listOfMovies[index];
                return TopMovieCard(
                  index: index,
                  imageUrl: ApiConstants.imagePath + movie.posterPath!,
                  onTap: () {
                    Navigator.of(
                      context,
                    ).pushNamed(DetailsScreen.routeName, arguments: movie.id);
                  },
                );
              },
              separatorBuilder: (_, __) => SizedBox(width: AppSizes.w20),
            );
          }

          if (state is HomeError) {
            return const SizedBox();
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildPopularSection() {
    return SizedBox(
      height: 200,
      child: BlocBuilder<PopularCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.orange),
            );
          }

          if (state is HomeSuccess) {
            return CustomPosterWidget(state: state);
          }

          if (state is HomeError) {
            return const SizedBox();
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildReleasesSection() {
    return SizedBox(
      height: 200,
      child: BlocBuilder<ReleasesCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.orange),
            );
          }

          if (state is HomeSuccess) {
            return CustomPosterWidget(state: state);
          }

          if (state is HomeError) {
            return const SizedBox();
          }

          return const SizedBox();
        },
      ),
    );
  }
}

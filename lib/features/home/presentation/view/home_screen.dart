import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/utils/api_constants.dart';
import 'package:movie/core/utils/app_colors.dart';
import 'package:movie/core/utils/app_size.dart';
import 'package:movie/core/utils/app_strings.dart';
import 'package:movie/features/details/presentation/pages/details_screen.dart';

import 'package:movie/features/home/data/api/home_api.dart';
import 'package:movie/features/home/data/repository/data_source/home_data_source_imp.dart';
import 'package:movie/features/home/data/repository/repo/home_repo_imp.dart';
import 'package:movie/features/home/domain/repository/data_source/home_data_source.dart';
import 'package:movie/features/home/domain/repository/repo/home_repo.dart';
import 'package:movie/features/home/domain/use_case/popular_movies_use_case.dart';
import 'package:movie/features/home/domain/use_case/recommended_movies_use_case.dart';
import 'package:movie/features/home/domain/use_case/releases_movies_use_case.dart';
import 'package:movie/features/home/presentation/view_model/popular_cubit/home-cubit.dart';
import 'package:movie/features/home/presentation/view_model/popular_cubit/home_state.dart';
import 'package:movie/features/home/presentation/view_model/recommended_cubit/home_recommended_cubit.dart';
import 'package:movie/features/home/presentation/view_model/release_cubit/home_release_cubit.dart';
import 'package:movie/features/home/presentation/widgets/custom_poster_widget.dart';
import 'package:movie/features/home/presentation/widgets/image_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final RecommendedCubit _homeCubit;
  late final GetRecommendedMoviesUseCase recommandedUseCase;
  late final GetPopularMoviesUseCase _popularUseCase;
  late final GitReleasesMoviesUseCase _gitReleasesMoviesUseCase;
  late final HomeRepo repo;
  late final HomeDataSource dataSource;
  late final PopularCubit _popularCubit;
  late final ReleasesCubit _releasesCubit;
  @override
  void initState() {
    super.initState();
    final homeApi = HomeApi();
    dataSource = HomeDataSourceImp(homeApi);
    repo = HomeRepoImp(dataSource);
    recommandedUseCase = GetRecommendedMoviesUseCase(repo);
    _homeCubit = RecommendedCubit(recommandedUseCase);
    _homeCubit.intent(RecommendedMoviesIntent());
    _popularUseCase = GetPopularMoviesUseCase(repo);
    _popularCubit = PopularCubit(_popularUseCase);
    _popularCubit.intent(PopularMoviesIntent());
    _gitReleasesMoviesUseCase = GitReleasesMoviesUseCase(repo);
    _releasesCubit = ReleasesCubit(_gitReleasesMoviesUseCase);
    _releasesCubit.intent(ReleasesMoviesIntent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsetsGeometry.only(
            right: AppSizes.w25,
            left: AppSizes.w25,
            top: AppSizes.h35,
          ),

          child: Column(
            children: [
              Container(
                height: 40,
                alignment: Alignment.topLeft,
                child: Text(
                  AppStrings.popular,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                    fontFamily: AppStrings.fontPoppins,
                  ),
                ),
              ),
              SizedBox(
                height: 300,
                width: .infinity,
                child: BlocBuilder<RecommendedCubit, HomeState>(
                  bloc: _homeCubit,
                  builder: (context, state) {
                    if (state is HomeLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is HomeSuccess) {
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.listOfMovies.length,
                        itemBuilder: (context, index) {
                          final movie = state.listOfMovies[index];
                          return TopMovieCard(
                            index: index,
                            imageUrl:
                                ApiConstants.imagePath + movie.posterPath!,
                            onTap: () {
                              // Navigator.of(context).pushNamed(
                              //   DetailsScreen.routeName,
                              //   arguments: movie.id,
                              // );
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(width: AppSizes.w20),
                      );
                    }

                    if (state is HomeError) {
                      return Center(
                        child: Card(
                          child: Text(
                            state.message,
                            style: TextStyle(
                              color: Colors.purpleAccent,
                              fontSize: AppSizes.sp30,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Center(child: Text("Unexpected state"));
                    }
                  },
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  AppStrings.releases,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                    fontFamily: AppStrings.fontPoppins,
                  ),
                ),
              ),
              SizedBox(height: AppSizes.h19),
              BlocBuilder(
                bloc: _popularCubit,
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is HomeSuccess) {
                    return SizedBox(
                      height: 200,
                      width: .infinity,
                      child: CustomPosterWidget(state: state),
                    );
                  }
                  if (state is HomeError) {
                    return Center(
                      child: Card(
                        child: Text(
                          state.message,
                          style: TextStyle(
                            color: Colors.purpleAccent,
                            fontSize: AppSizes.sp30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Center(child: Text("Unexpected state"));
                  }
                },
              ),
              SizedBox(height: AppSizes.h19),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  AppStrings.recommended,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                    fontFamily: AppStrings.fontMontserrat,
                  ),
                ),
              ),
              SizedBox(height: AppSizes.h19),
              BlocBuilder(
                bloc: _releasesCubit,
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is HomeSuccess) {
                    return SizedBox(
                      height: 200,
                      width: .infinity,
                      child: CustomPosterWidget(state: state),
                    );
                  }
                  if (state is HomeError) {
                    return Center(
                      child: Card(
                        child: Text(
                          state.message,
                          style: TextStyle(
                            color: Colors.purpleAccent,
                            fontSize: AppSizes.sp30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Center(child: Text("Unexpected state"));
                  }
                },
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

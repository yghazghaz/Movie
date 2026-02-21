import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie/core/di/di.dart';
import 'package:movie/core/dialogs/app_toast.dart';
import 'package:movie/features/details/presentation/view/details_screen.dart';
import 'package:movie/features/search/presentation/view/widgets/search_loading_status.dart';
import 'package:movie/features/search/presentation/view/widgets/search_no_results_or_error.dart';
import 'package:movie/features/search/presentation/view/widgets/search_text_form_field.dart';
import 'package:movie/features/search/presentation/view_model/search_cubit.dart';
import 'package:toastification/toastification.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../view_model/search_state.dart';
import '../widgets/search_movie_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController searchController;
  late final SearchCubit searchCubit;
  @override
  void initState() {
    searchCubit = getIt<SearchCubit>();
    super.initState();
    searchController = TextEditingController();
  }

  String searchQuery = '';
  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    searchCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,

        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.only(
            left: 8.w,
            right: 8.w,
            top: 10.h,
            bottom: 20.h,
          ),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              SvgPicture.asset(
                AppIcons.menu,

                width: 36.w,
                height: 36.h,
                fit: .contain,
              ),
              Text(
                AppStrings.search,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: .w600,
                  color: AppColors.text,
                ),
              ),
              SvgPicture.asset(
                AppIcons.menu,

                width: 36.w,
                height: 36.h,
                fit: .contain,
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 29.w, right: 15.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            SearchTextFormWidget(
              onSubmitted: (value) {
                searchQuery = value;
                searchCubit.intent(searchQuery);
              },
              onChanged: (value) {
                searchQuery = value;
                searchCubit.intent(searchQuery);
              },
              onPressed: () {
                searchQuery = searchController.text;
                searchCubit.intent(searchQuery);
              },
              controller: searchController,
            ),

            SizedBox(height: 24.h),

            Expanded(
              child: BlocConsumer<SearchCubit, SearchState>(
                bloc: searchCubit,
                listener: (context, state) {
                  if (state is SearchError) {
                    AppToast.showToast(
                      context: context,
                      title: 'Oops!',
                      description: state.messageError,
                      type: ToastificationType.error,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is SearchInitial) {
                    return const SizedBox();
                  }

                  if (state is SearchEmpty) {
                    return SearchNoResultsOrError(
                      headMessage: 'Please enter movie name',
                    );
                  }
                  if (state is SearchNoResults) {
                    return SearchNoResultsOrError(
                      headMessage: 'We Are Sorry, We Can Not Find The Movie :(',
                      subMessage:
                          'Find your movie by Type title, categories, years, etc ',
                    );
                  }

                  if (state is SearchLoading) {
                    return SearchLoadingStatus();
                  }
                  if (state is SearchError) {
                    return SearchNoResultsOrError(
                      headMessage: 'Something went wrong',
                      subMessage: state.messageError,
                    );
                  }
                  if (state is SearchSuccess) {
                    final duration = 139;
                    return ListView.separated(
                      itemCount: state.movies.length,
                      separatorBuilder: (_, _) => SizedBox(height: 24.h),
                      itemBuilder: (context, index) {
                        final movie = state.movies[index];

                        return SearchMovieWidget(
                          itemOnTap: () {
                            Navigator.of(context).pushNamed(
                              DetailsScreen.routeName,
                              arguments: movie.id,
                            );
                          },
                          imagePath: movie.posterPath,
                          movieTitle: movie.title,
                          movieType: movie.genreName,
                          movieRate: movie.voteAverage,
                          movieDate: movie.year,
                          movieDuration: duration,
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

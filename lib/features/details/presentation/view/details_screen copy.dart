// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';

// import 'package:movie/core/di/di.dart';
// import 'package:movie/core/error/failure.dart';
// import 'package:movie/core/utils/api_constants.dart';

// import 'package:movie/core/utils/app_colors.dart';
// import 'package:movie/core/utils/app_icons.dart';


// import 'package:movie/features/details/presentation/view_model/details_cubit.dart';
// import 'package:movie/features/details/presentation/widgets/app_bar/custom_app_bar.dart';
// import 'package:movie/features/details/presentation/widgets/movie_details_status_custom_widget.dart';

// import 'package:movie/features/details/presentation/widgets/movie_poster_title_custom_widget.dart';

// class DetailsScreen2 extends StatefulWidget {
//   final int movieId;

//   const DetailsScreen2({super.key, required this.movieId});

//   @override
//   State<DetailsScreen2> createState() => _DetailsScreenState2();
// }

// class _DetailsScreenState2 extends State<DetailsScreen2> {
//   late final DetailsCubit _detailsCubit;

//   @override
//   void initState() {
//     super.initState();
//     _detailsCubit = getIt<DetailsCubit>();
//     _detailsCubit.intent(GetDetailsEvent(movieId: widget.movieId));
//   }

//   @override
//   void dispose() {
//     _detailsCubit.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.primary,
//       appBar: CustomAppBar(isSaved: false, onSaveTapped: () {}),
//       body: BlocBuilder<DetailsCubit, DetailsState>(
//         bloc: _detailsCubit,
//         builder: (context, state) {
//           if (state is DetailsLoading) {
//             return const Center(
//               child: CircularProgressIndicator(color: AppColors.white),
//             );
//           }

//           if (state is DetailsFailure) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     state.message is ServerFailure
//                         ? (state.message as ServerFailure).message
//                         : 'An unexpected error occurred',
//                     style: const TextStyle(color: AppColors.white),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () {
//                       _detailsCubit.intent(
//                         GetDetailsEvent(movieId: widget.movieId),
//                       );
//                     },
//                     child: const Text("Retry"),
//                   ),
//                 ],
//               ),
//             );
//           }

//           if (state is GetDetailsSuccess) {
//             final movie = state.details;

//             return SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   MovieImage(movie: movie),
//                   PosterAndTitleDetails(movie: movie),
//                 ],
//               ),
//             );
//           }

//           return const SizedBox();
//         },
//       ),
//     );
//   }
// }

// class PosterAndTitleDetails extends StatelessWidget {
//   const PosterAndTitleDetails({
//     super.key,
//     required this.movie,
//   });

//   final DetailsResponseEntity movie;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         children: [
//           Row(
//             spacing: 10,
//             crossAxisAlignment: .start,
//             children: [
//               Transform.translate(
//                 offset: Offset(0, -375 / 5.5),
//                 child: Align(
//                   alignment: .topCenter,
//                   heightFactor: 0,
//                   child: ClipRRect(
//                     borderRadius: .circular(16),
//                     child: PosterImage(movie: movie),
//                   ),
//                 ),
//               ),
              
//               Text(
//                 overflow: .clip,
//                 movie.title,
//                 style: TextStyle(
//                   color: AppColors.white,
//                   fontWeight: .bold,
//                   fontSize: 19,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 30,),
//           Row(
//             mainAxisAlignment: .center,
//             children: [
//               SvgPicture.asset(AppIcons.calendar,),
//               SizedBox(width: 5,),
//               Text(movie.releaseDate.substring(0, 4),style: TextStyle(color: AppColors.gray),),
//               SizedBox(width: 12,),
//               Text("|",style: TextStyle(color: AppColors.gray),),
//               SizedBox(width: 12,),
//               SvgPicture.asset(AppIcons.clock),
//               SizedBox(width: 5,),
//               Text("${movie.runtime} Min",style: TextStyle(color: AppColors.gray),),
//               SizedBox(width: 12,),
//               Text("|",style: TextStyle(color: AppColors.gray),),
//               SizedBox(width: 12,),
//               SvgPicture.asset(AppIcons.ticket),
//               SizedBox(width: 5,),
//               Text(movie.genres[0],style: TextStyle(color: AppColors.gray),),
//             ],
//           ),
//           SizedBox(height: 12,),
//           Text(
//             movie.overview,
//             style: TextStyle(color: AppColors.white, height: 1.5, fontSize: 12,fontWeight: .w400),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class PosterImage extends StatelessWidget {
//   const PosterImage({super.key, required this.movie});

//   final DetailsResponseEntity movie;

//   @override
//   Widget build(BuildContext context) {
//     return CachedNetworkImage(
//       imageUrl: "${ApiConstants.imagePath}${movie.posterPath}",
//       imageBuilder: (context, imageProvider) => Container(
//         width: 95,
//         height: 120,
//         decoration: BoxDecoration(
//           borderRadius: .circular(16),
//           image: DecorationImage(image: imageProvider, fit: .cover),
//         ),
//       ),
//       placeholder: (context, url) =>
//           CircularProgressIndicator(strokeWidth: 2, color: AppColors.white),
//     );
//   }
// }

// class MovieImage extends StatelessWidget {
//   const MovieImage({super.key, required this.movie});

//   final DetailsResponseEntity movie;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: .bottomRight,
//       children: [
//         SizedBox(
//           width: double.infinity,
//           child: CachedNetworkImage(
//             imageUrl: "${ApiConstants.imagePath}${movie.backdropPath}",
//             fit: BoxFit.cover,
//             placeholder: (context, url) => Center(
//               child: CircularProgressIndicator(color: AppColors.orange),
//             ),
//             errorWidget: (context, url, error) => const Icon(Icons.error),
//           ),
//         ),
//         Padding(
//           padding: .only(right: 15, bottom: 10),
//           child: ClipRRect(
//             borderRadius: .circular(8),
//             child: Container(
//               padding: .symmetric(vertical: 5, horizontal: 10),
//               decoration: BoxDecoration(
//                 color: AppColors.black,
//                 borderRadius: .circular(10),
//               ),
//               child: Row(
//                 mainAxisSize: .min,
//                 mainAxisAlignment: .end,
//                 children: [
//                   SvgPicture.asset(AppIcons.star),
//                   const SizedBox(width: 4),
//                   Text(
//                     movie.voteAverage.toStringAsFixed(1),
//                     style: const TextStyle(
//                       color: AppColors.orange,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

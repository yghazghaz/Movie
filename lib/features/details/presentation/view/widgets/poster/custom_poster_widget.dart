
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie/core/utils/api_constants.dart';
import 'package:movie/features/details/presentation/view/widgets/poster/error_template.dart';
import 'package:movie/features/details/presentation/view/widgets/poster/loading_template.dart';



class CustomPosterWidget extends StatelessWidget {
  const CustomPosterWidget({super.key, required this.posterUrl});
  final String? posterUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "${ApiConstants.imagePath}${posterUrl ?? ""}",
      imageBuilder: (context, imageProvider) => Container(
        width: 95,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: .circular(16),
          image: DecorationImage(image: imageProvider, fit: .cover),
        ),
      ),
      placeholder: (context, _) => LoadingTemplate(),
      errorWidget: (context, _, error) =>
          ErrorTemplate(error: error.toString()),
    );
  }
}

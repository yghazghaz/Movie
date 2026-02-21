import 'package:flutter/material.dart';
import 'package:movie/features/details/presentation/view/widgets/poster/custom_body_widget.dart';
import 'package:movie/features/details/presentation/view/widgets/poster/custom_poster_widget.dart';
import 'package:movie/features/details/presentation/view/widgets/poster/custom_title_widget.dart';
import 'package:movie/features/details/presentation/view/widgets/poster/error_template.dart';
import 'package:movie/features/details/presentation/view/widgets/poster/loading_template.dart';
import 'package:movie/features/details/presentation/view/widgets/poster/title_error_widget.dart';
import 'package:movie/features/details/presentation/view/widgets/poster/title_loading_widget.dart';


class MoviePosterTitleCustomWidget extends StatefulWidget {
  const MoviePosterTitleCustomWidget({
    super.key,
    this.title,
    this.posterUrl,
    this.loadingTemplate = false,
    this.errorTemplate = false,
    this.errorMsg = "",
  });

  final String? title;
  final String? posterUrl;
  final bool loadingTemplate;
  final bool errorTemplate;
  final String errorMsg;

  @override
  State<MoviePosterTitleCustomWidget> createState() =>
      _MoviePosterCustomWidgetState();
}

class _MoviePosterCustomWidgetState
    extends State<MoviePosterTitleCustomWidget> {
  @override
  Widget build(BuildContext context) {
    Widget? targetWidget;
    Widget? targetTextWidget;

    if (widget.loadingTemplate) {
      targetWidget = LoadingTemplate();
      targetTextWidget = TitleLoadingWidget();
    }

    if (widget.errorTemplate) {
      targetWidget = ErrorTemplate(error: widget.errorMsg);
      targetTextWidget = TitleErrorWidget();
    }

    return CustomBodyWidget(
      title: targetTextWidget ?? CustomTitleWidget(title: widget.title),
      child: targetWidget ?? CustomPosterWidget(posterUrl: widget.posterUrl),
    );
  }
}

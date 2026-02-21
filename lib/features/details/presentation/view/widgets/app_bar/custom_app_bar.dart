import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie/core/utils/app_colors.dart';
import 'package:movie/core/utils/app_icons.dart';
import 'package:movie/core/utils/app_strings.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isSaved;
  final VoidCallback onSaveTapped;

  const CustomAppBar({
    super.key,
    required this.isSaved,
    required this.onSaveTapped,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      scrolledUnderElevation: 0,
      leading: null,
      automaticallyImplyLeading: false,
      elevation: 0,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(AppIcons.back),
          ),
          const Text(
            AppStrings.details,
            style: TextStyle(
              color: AppColors.white,
              fontFamily: AppStrings.fontMontserrat,
            ),
          ),
          GestureDetector(
            onTap: onSaveTapped,
            child: isSaved
                ? SvgPicture.asset(AppIcons.saveFilled)
                : SvgPicture.asset(AppIcons.save),
          ),
        ],
      ),
    );
  }
}

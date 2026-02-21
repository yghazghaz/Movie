import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie/core/utils/app_strings.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_icons.dart';

class SearchTextFormWidget extends StatefulWidget {
  const SearchTextFormWidget({
    super.key,
    required this.onSubmitted,
    this.onChanged,
    this.onPressed,
    this.obscureText = false,
    required this.controller,
  });
  final TextEditingController controller;
  final bool obscureText;
  final Function(String)? onSubmitted;
  final void Function()? onPressed;
  final Function(String)? onChanged;

  @override
  State<SearchTextFormWidget> createState() => _SearchTextFormWidgetState();
}

class _SearchTextFormWidgetState extends State<SearchTextFormWidget> {
  late bool _isObscure;
  @override
  void initState() {
    _isObscure = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * (42 / 812),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        onSubmitted: widget.onSubmitted,
        onChanged: widget.onChanged,
        obscureText: _isObscure,
        controller: widget.controller,
        cursorColor: AppColors.white,
        cursorHeight: 20,
        keyboardType: .text,
        style: const TextStyle(color: AppColors.white),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 25.w, top: 11.h, bottom: 10.h),
          hintText: AppStrings.search,
          hintStyle: TextStyle(color: Color(0xff707070)),
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 15.w, top: 13.h, bottom: 13.h),
            child: GestureDetector(
              onTap: widget.onPressed,
              child: SvgPicture.asset(
                AppIcons.searchRight,
                width: 16.w,
                height: 16.h,
                fit: .contain,
              ),
            ),
          ),
          filled: true,
          fillColor: AppColors.textFormBg,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(color: AppColors.selected, width: 1.dg),
          ),
        ),
      ),
    );
  }
}

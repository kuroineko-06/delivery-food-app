import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/constants/constants.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget(
      {super.key,
      this.keyBoardType,
      this.controller,
      this.obscureText,
      this.suffixIcon,
      this.validator,
      this.prefixIcon,
      this.hintText,
      this.maxLines});

  final TextInputType? keyBoardType;
  final TextEditingController? controller;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hintText;
  final int? maxLines;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0.h),
      padding: EdgeInsets.only(left: 6.h),
      decoration: BoxDecoration(
          border: Border.all(color: kGray, width: 0.4),
          borderRadius: BorderRadius.circular(9.r)),
      child: TextFormField(
        maxLines: maxLines ?? 1,
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        keyboardType: keyBoardType,
        obscureText: obscureText ?? false,
        cursorHeight: 20.h,
        style: appStyle(11, kDark, FontWeight.normal),
        validator: validator,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintStyle: appStyle(11, kGray, FontWeight.normal),
          hintText: hintText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }
}

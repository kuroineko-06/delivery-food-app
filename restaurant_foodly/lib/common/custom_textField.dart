// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_foodly/common/app_style.dart';
import 'package:restaurant_foodly/constants/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hinText,
      required this.prefixIcon,
      this.maxLine,
      this.onEdittingComplete,
      this.keyboardType,
      this.controller});

  final String hinText;
  final Widget prefixIcon;
  final int? maxLine;
  final void Function()? onEdittingComplete;
  final TextInputType? keyboardType;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: appStyle(12, kDark, FontWeight.normal),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter some text";
        }
        return null;
      },
      cursorColor: kDark,
      maxLines: maxLine ?? 1,
      onEditingComplete: onEdittingComplete,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hinText,
        prefixIcon: prefixIcon,
        isDense: true,
        contentPadding: maxLine != null ? EdgeInsets.zero : EdgeInsets.all(6.r),
        hintStyle: appStyle(12, kGray, FontWeight.normal),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: kPrimary, width: 0.5.w)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: kRed, width: 0.5.w)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: kPrimary, width: 0.5.w)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: kRed, width: 0.5.w)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: kGray, width: 0.5.w)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: kPrimary, width: 0.5.w)),
      ),
    );
  }
}

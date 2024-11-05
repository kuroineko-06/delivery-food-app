import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_foodly/common/app_style.dart';
import 'package:restaurant_foodly/common/reusable_text.dart';
import 'package:restaurant_foodly/constants/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.onTap,
      this.btnWidth,
      this.btnHight,
      this.btnColor,
      this.btnRadius,
      required this.text});

  final void Function()? onTap;
  final double? btnWidth, btnHight, btnRadius;
  final Color? btnColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: btnWidth ?? width,
        height: btnHight ?? 28.h,
        decoration: BoxDecoration(
            color: btnColor ?? kPrimary,
            borderRadius: BorderRadius.circular(btnRadius ?? 12.r)),
        child: Center(
          child: ReusableText(
              text: text, style: appStyle(12, kLightWhite, FontWeight.w500)),
        ),
      ),
    );
  }
}

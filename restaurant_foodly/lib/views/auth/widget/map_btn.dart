// ignore_for_file: prefer_collection_literals

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_foodly/common/app_style.dart';
import 'package:restaurant_foodly/common/reusable_text.dart';
import 'package:restaurant_foodly/constants/constants.dart';

class MapBtn extends StatelessWidget {
  const MapBtn({
    super.key,
    required this.text,
    this.onTap,
  });

  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 25.h,
        width: 70.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.r),
            border: Border.all(color: kOffWhite, width: 0.5.w)),
        child: Center(
          child: ReusableText(
              text: text, style: appStyle(13, kLightWhite, FontWeight.w600)),
        ),
      ),
    );
  }
}

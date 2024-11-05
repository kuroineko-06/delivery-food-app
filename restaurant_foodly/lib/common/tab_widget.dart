import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.w),
      width: MediaQuery.of(context).size.width / 4.5,
      height: 19.h,
      child: Center(
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

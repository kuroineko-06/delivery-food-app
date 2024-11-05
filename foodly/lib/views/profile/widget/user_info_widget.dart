import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/common/reusable_text.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/models/login_response.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({super.key, this.user});

  final LoginResponse? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.06,
      width: width,
      decoration: const BoxDecoration(
        color: kLightWhite,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Row(
                children: [
                  Container(
                    height: 35.h,
                    width: 35.w,
                    child: CircleAvatar(
                      radius: 25.r,
                      backgroundColor: kGrayLight,
                      backgroundImage: NetworkImage(user!.profile),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ReusableText(
                            text: user!.username,
                            style: appStyle(12, kGray, FontWeight.w600)),
                        ReusableText(
                            text: user!.email,
                            style: appStyle(12, kGray, FontWeight.w400)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 12.w),
              child: const Icon(
                Icons.edit_calendar_outlined,
                size: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}

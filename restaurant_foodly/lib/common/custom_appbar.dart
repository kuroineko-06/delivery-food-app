import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:restaurant_foodly/common/app_style.dart';
import 'package:restaurant_foodly/common/reusable_text.dart';
import 'package:restaurant_foodly/constants/constants.dart';
import 'package:restaurant_foodly/controllers/restaurant_controller.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RestaurantController());
    controller.getRestaurantData();
    return Container(
      width: width,
      padding: EdgeInsets.fromLTRB(12.w, 45.h, 12.w, 0),
      height: 130.h,
      color: kPrimary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(controller.restaurant!.logoUrl),
              ),
              SizedBox(
                width: 10.w,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 3.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                        text: controller.restaurant!.title,
                        style: appStyle(14, Colors.white, FontWeight.bold)),
                    SizedBox(
                      width: width * 0.7,
                      child: ReusableText(
                          textOverflow: TextOverflow.ellipsis,
                          text: controller.restaurant!.coords.address,
                          maxLine: 1,
                          style: appStyle(12, Colors.white, FontWeight.normal)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SvgPicture.asset(
            "assets/icons/open_sign.svg",
            height: 35.h,
            width: 35.w,
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/common/reusable_text.dart';

class FoodWidget extends StatelessWidget {
  const FoodWidget(
      {super.key,
      required this.images,
      required this.title,
      required this.time,
      required this.price,
      this.onTap});

  final String images;
  final String title;
  final String time;
  final String price;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.only(right: 12.w),
          child: Container(
            width: width * .75,
            height: 180.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: kOffWhite,
            ),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: SizedBox(
                          height: 112.h,
                          width: width * 0.8,
                          child: Image.network(
                            images,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(
                              text: title,
                              style: appStyle(12, kDark, FontWeight.w500)),
                          ReusableText(
                              text: "\$ ${price}",
                              style: appStyle(12, kPrimary, FontWeight.w600)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(
                              text: "Delivery time: ",
                              style: appStyle(9, kGray, FontWeight.w500)),
                          ReusableText(
                              text: time,
                              style: appStyle(10, kDark, FontWeight.w500)),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

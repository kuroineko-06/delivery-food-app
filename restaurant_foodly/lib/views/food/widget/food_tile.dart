// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_foodly/common/app_style.dart';
import 'package:restaurant_foodly/common/reusable_text.dart';
import 'package:restaurant_foodly/constants/constants.dart';
import 'package:restaurant_foodly/models/food_model.dart';

class FoodTile extends StatelessWidget {
  FoodTile({
    super.key,
    required this.food,
  });

  FoodModel food;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 4.h),
      child: Container(
        height: 80.h,
        decoration: BoxDecoration(
          color: kOffWhite,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.w),
                  child: SizedBox(
                    width: 65.w,
                    height: 65.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.network(
                        food.imageUrl[0],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ReusableText(
                        text: food.title,
                        style: appStyle(12, kDark, FontWeight.w500)),
                    Row(
                      children: [
                        ReusableText(
                            text: "Delivery time: ${food.time}",
                            style: appStyle(10, kGray, FontWeight.w500)),
                        SizedBox(
                          width: 10.w,
                        ),
                        ReusableText(
                            text: "Foods count: ${food.countInStock}",
                            style: appStyle(10, kGray, FontWeight.w500)),
                      ],
                    ),
                    SizedBox(
                      height: 17.h,
                      width: width * 0.7,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: food.additives.length,
                        itemBuilder: (context, index) {
                          String title = food.additives[index].title;
                          return Container(
                            margin: EdgeInsets.only(right: 5.w),
                            decoration: BoxDecoration(
                                color: kSecondaryLight,
                                borderRadius: BorderRadius.circular(9.r)),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                                child: ReusableText(
                                    text: title,
                                    style: appStyle(9, kGray, FontWeight.w400)),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
            Positioned(
                right: 8.w,
                top: 7.h,
                child: Container(
                  height: 19.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                    color: kPrimary,
                    borderRadius: BorderRadius.circular(12.w),
                  ),
                  child: Center(
                    child: ReusableText(
                        text: "\$${food.price}",
                        style: appStyle(12, kLightWhite, FontWeight.bold)),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

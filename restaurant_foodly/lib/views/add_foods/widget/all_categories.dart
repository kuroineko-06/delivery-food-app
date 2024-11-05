import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:restaurant_foodly/common/app_style.dart';
import 'package:restaurant_foodly/common/reusable_text.dart';
import 'package:restaurant_foodly/constants/constants.dart';
import 'package:restaurant_foodly/controllers/food_controller.dart';
import 'package:restaurant_foodly/hooks/category_list_hook.dart';
import 'package:restaurant_foodly/shimmers/foodlist_shimmer.dart';

class ChooseCategory extends HookWidget {
  const ChooseCategory({
    super.key,
    required this.next,
  });

  final Function() next;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FoodController());
    final hookResults = fetchCategories();
    final categories = hookResults.data;
    final isLoading = hookResults.isLoading;
    final error = hookResults.error;

    if (isLoading) {
      return const FoodsListShimmer();
    }
    if (error != null) {
      return Center(
        child: Text(error.toString()),
      );
    }

    return SizedBox(
      height: height,
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.w, top: 12.h, bottom: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableText(
                    text: "Pick category",
                    style: appStyle(16, kGray, FontWeight.w600)),
                ReusableText(
                    text:
                        "You are to pick a category to continue adding a food item",
                    style: appStyle(11, kGray, FontWeight.normal)),
              ],
            ),
          ),
          SizedBox(
              height: height * 0.8,
              child: ListView.builder(
                itemCount: categories!.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return ListTile(
                    onTap: () {
                      controller.setCategory = category.id;
                      next();
                    },
                    leading: CircleAvatar(
                      radius: 18.r,
                      backgroundColor: kPrimary,
                      child: Image.network(
                        category.imageUrl,
                        fit: BoxFit.contain,
                      ),
                    ),
                    title: ReusableText(
                        text: category.title,
                        style: appStyle(12, kGray, FontWeight.normal)),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 15.sp,
                      color: kGray,
                    ),
                  );
                },
              ))
        ],
      ),
    );
  }
}

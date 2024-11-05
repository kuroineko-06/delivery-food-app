import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly/common/shimmers/foodlist_shimmer.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/common/background_container.dart';
import 'package:foodly/common/reusable_text.dart';
import 'package:foodly/hooks/fetch_all_category.dart';
import 'package:foodly/models/category.dart';
import 'package:get/get.dart';

import 'widgets/category_tile.dart';

class AllCategories extends HookWidget {
  const AllCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchAllCategories();
    List<CategoryModel>? categories = hookResults.data;
    final isLoading = hookResults.isLoading;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: kDark,
              )),
          backgroundColor: kOffWhite,
          title: ReusableText(
              text: "All Categories",
              style: appStyle(12, kGray, FontWeight.w600))),
      body: BackgroundContainer(
        color: Colors.white,
        child: Container(
          height: height,
          padding: EdgeInsets.only(left: 12.w, top: 10.h),
          child: isLoading
              ? const FoodsListShimmer()
              : ListView(
                  scrollDirection: Axis.vertical,
                  children: List.generate(categories!.length, (i) {
                    CategoryModel category = categories[i];
                    return CategoryTile(category: category);
                  }),
                ),
        ),
      ),
    );
  }
}

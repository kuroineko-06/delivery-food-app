import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_foodly/common/app_style.dart';
import 'package:restaurant_foodly/common/background_container.dart';
import 'package:restaurant_foodly/common/reusable_text.dart';
import 'package:restaurant_foodly/constants/constants.dart';
import 'package:restaurant_foodly/hooks/food_list_hook.dart';
import 'package:restaurant_foodly/shimmers/foodlist_shimmer.dart';
import 'package:restaurant_foodly/views/food/widget/food_tile.dart';

class FoodPage extends HookWidget {
  const FoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults = fetchFoods();
    final foods = hookResults.data;
    final isLading = hookResults.isLoading;
    final error = hookResults.error;

    if (isLading) {
      return Scaffold(
        backgroundColor: kSecondary,
        appBar: AppBar(
          backgroundColor: kSecondary,
          centerTitle: true,
          title: ReusableText(
              text: "Food List",
              style: appStyle(18, kLightWhite, FontWeight.w600)),
        ),
        body: const BackgroundContainer(child: FoodsListShimmer()),
      );
    }
    if (error != null) {
      return Center(
        child: Text(error.message),
      );
    }

    return Scaffold(
      backgroundColor: kSecondary,
      appBar: AppBar(
        backgroundColor: kSecondary,
        centerTitle: true,
        title: ReusableText(
            text: "Food List",
            style: appStyle(18, kLightWhite, FontWeight.w600)),
      ),
      body: BackgroundContainer(
          child: ListView.builder(
        padding: EdgeInsets.only(top: 20.h),
        scrollDirection: Axis.vertical,
        itemCount: foods!.length,
        itemBuilder: (context, index) {
          print(foods.length);
          final food = foods[index];
          return FoodTile(
            food: food,
          );
        },
      )),
    );
  }
}

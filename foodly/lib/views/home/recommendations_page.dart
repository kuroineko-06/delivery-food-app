import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly/common/shimmers/foodlist_shimmer.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/common/background_container.dart';
import 'package:foodly/common/reusable_text.dart';
import 'package:foodly/hooks/fetch_all_food.dart';
import 'package:foodly/models/food.dart';
import 'package:foodly/views/home/widgets/food_tile.dart';

class RecommendationsPage extends HookWidget {
  const RecommendationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchAllFood("100000");
    List<FoodModel>? foods = hookResults.data;
    final isLoading = hookResults.isLoading;

    return Scaffold(
      backgroundColor: kSecondary,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: kSecondary,
          centerTitle: true,
          title: ReusableText(
              text: "Recommendations",
              style: appStyle(13, kLightWhite, FontWeight.w600))),
      body: BackgroundContainer(
        color: Colors.white,
        child: isLoading
            ? const FoodsListShimmer()
            : Padding(
                padding: EdgeInsets.all(12.h),
                child: ListView(
                  children: List.generate(foods!.length, (i) {
                    FoodModel food = foods[i];
                    return FoodTile(
                      food: food,
                    );
                  }),
                ),
              ),
      ),
    );
  }
}

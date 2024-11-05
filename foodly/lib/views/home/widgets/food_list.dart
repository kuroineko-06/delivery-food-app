import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly/common/shimmers/nearby_shimmer.dart';
import 'package:foodly/hooks/fetch_food.dart';
import 'package:foodly/models/food.dart';
import 'package:foodly/views/food/food_page.dart';
import 'package:foodly/views/home/widgets/food_widget.dart';
import 'package:get/get.dart';

class FoodList extends HookWidget {
  const FoodList({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchFood("100000");
    List<FoodModel>? foods = hookResults.data;
    final isLoading = hookResults.isLoading;

    print("test data: ${foods}");

    return isLoading
        ? const NearbyShimmer()
        : Container(
            height: 184.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(3, (i) {
                FoodModel food = foods![i];
                return FoodWidget(
                    onTap: () {
                      Get.to(() => FoodPage(food: food));
                    },
                    images: food.imageUrl[0],
                    title: food.title,
                    time: food.time,
                    price: food.price.toStringAsFixed(2));
              }),
            ),
          );
  }
}

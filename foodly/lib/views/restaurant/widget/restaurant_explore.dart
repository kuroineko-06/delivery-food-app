import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodly/common/shimmers/foodlist_shimmer.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/hooks/fetch_food.dart';
import 'package:foodly/models/food.dart';
import 'package:foodly/views/home/widgets/food_tile.dart';

class RestaurantExplore extends HookWidget {
  const RestaurantExplore({
    super.key,
    required this.code,
  });

  final String code;

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchFood(code);
    final foods = hookResults.data;
    final isLoading = hookResults.isLoading;
    return Scaffold(
      backgroundColor: kLightWhite,
      body: isLoading
          ? const FoodsListShimmer()
          : SizedBox(
              height: height * 0.7,
              child: ListView(
                padding: EdgeInsets.zero,
                children: List.generate(foods!.length, (index) {
                  final FoodModel food = foods[index];
                  return FoodTile(food: food);
                }),
              ),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodly/common/shimmers/foodlist_shimmer.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/hooks/food_by_restaurant.dart';
import 'package:foodly/models/food.dart';
import 'package:foodly/views/home/widgets/food_tile.dart';

class RestaurantMenu extends HookWidget {
  const RestaurantMenu({
    super.key,
    required this.restaurantId,
  });

  final String restaurantId;

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchFoodByRestaurant(restaurantId);
    final foods = hookResults.data;
    final isLoading = hookResults.isLoading;
    return Scaffold(
      backgroundColor: kLightWhite,
      body: isLoading
          ? const FoodsListShimmer()
          : Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  height: height,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: List.generate(foods!.length, (index) {
                      final FoodModel food = foods[index];
                      return FoodTile(food: food);
                    }),
                  ),
                ),
              ),
            ),
    );
  }
}

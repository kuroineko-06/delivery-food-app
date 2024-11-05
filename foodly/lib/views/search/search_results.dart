import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/controller/search_controller.dart';
import 'package:foodly/models/food.dart';
import 'package:foodly/views/home/widgets/food_tile.dart';
import 'package:get/get.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchFoodsController());
    return Container(
      padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.h, 0),
      height: height,
      child: ListView.builder(
        itemCount: controller.searchResults!.length,
        itemBuilder: (context, index) {
          FoodModel foods = controller.searchResults![index];
          return FoodTile(food: foods);
        },
      ),
    );
  }
}

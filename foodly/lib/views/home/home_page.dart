import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/common/custom_appbar.dart';
import 'package:foodly/common/custom_container.dart';
import 'package:foodly/common/heading.dart';
import 'package:foodly/controller/category_controller.dart';
import 'package:foodly/views/home/all_fast_foods.dart';
import 'package:foodly/views/home/all_nearby_restaurant.dart';
import 'package:foodly/views/home/recommendations_page.dart';
import 'package:foodly/views/home/widgets/category_foods_list.dart';
import 'package:foodly/views/home/widgets/category_list.dart';
import 'package:foodly/views/home/widgets/food_list.dart';
import 'package:foodly/views/home/widgets/nearby_restaurant_list.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());

    return Scaffold(
        backgroundColor: kPrimary,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(107.h), child: const CustomAppbar()),
        body: RefreshIndicator(
          onRefresh: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => HomePage())),
          child: SafeArea(
              child: CustomContainer(
                  containerContent: Column(
            children: [
              const CategoryList(),
              Obx(() => controller.categoryValue == ""
                  ? Column(
                      children: [
                        //try something new
                        Heading(
                          text: "Try Something New",
                          onTap: () {
                            Get.to(() => const RecommendationsPage(),
                                transition: Transition.fadeIn,
                                duration: const Duration(microseconds: 900));
                          },
                        ),
                        const FoodList(),

                        //nearby restaurant
                        Heading(
                          text: "Nearby Restaurant",
                          onTap: () {
                            Get.to(() => const AllNearbyRestaurant(),
                                transition: Transition.fadeIn,
                                duration: const Duration(microseconds: 900));
                          },
                        ),
                        const NearbyRestaurants(),

                        //foods close
                        Heading(
                          text: "Food close for you",
                          onTap: () {
                            Get.to(() => const AllFastFoods(),
                                transition: Transition.fadeIn,
                                duration: const Duration(microseconds: 900));
                          },
                        ),
                        const FoodList(),
                      ],
                    )
                  : CustomContainer(
                      containerContent: Column(
                      children: [
                        Heading(
                          more: true,
                          text: "Explore ${controller.titleValue} Category",
                          onTap: () {
                            Get.to(() => const RecommendationsPage(),
                                transition: Transition.fadeIn,
                                duration: const Duration(microseconds: 900));
                          },
                        ),
                        const CategoryFoodsList(),
                      ],
                    )))
            ],
          ))),
        ));
  }
}

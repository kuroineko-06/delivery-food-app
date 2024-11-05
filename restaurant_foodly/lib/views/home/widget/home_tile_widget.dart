import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:restaurant_foodly/common/home_tile.dart';
import 'package:restaurant_foodly/constants/constants.dart';
import 'package:restaurant_foodly/controllers/login_controller.dart';
import 'package:restaurant_foodly/views/add_foods/add_foods.dart';
import 'package:restaurant_foodly/views/food/food_page.dart';

class HomeTileWidget extends StatelessWidget {
  const HomeTileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 5.h),
      height: 70.h,
      decoration: BoxDecoration(
          color: kOffWhite, borderRadius: BorderRadius.circular(12.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HomeTile(
              onTap: () {
                Get.to(() => const AddFoods());
              },
              text: "Add Foods",
              iconPaths: 'assets/icons/taco.svg'),
          HomeTile(
              onTap: () {},
              text: "Wallet",
              iconPaths: 'assets/icons/wallet.svg'),
          HomeTile(
              onTap: () {
                Get.to(() => const FoodPage(),
                    transition: Transition.fadeIn,
                    duration: const Duration(microseconds: 600));
              },
              text: "Foods",
              iconPaths: 'assets/icons/french_fries.svg'),
          HomeTile(
              onTap: () {},
              text: "Self Delivery",
              iconPaths: 'assets/icons/delivery_truck.svg'),
          HomeTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                        "Sign out",
                      ),
                      content: const Text(
                          "Would you like to sign out this session?"),
                      actions: <Widget>[
                        ElevatedButton(
                          child: const Text("Cancel"),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                        ),
                        ElevatedButton(
                          child: const Text("Continue"),
                          onPressed: () {
                            controller.logout();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              text: "Setting",
              iconPaths: 'assets/icons/setting.svg'),
        ],
      ),
    );
  }
}

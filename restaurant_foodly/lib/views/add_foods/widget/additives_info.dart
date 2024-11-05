import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:restaurant_foodly/common/app_style.dart';
import 'package:restaurant_foodly/common/custom_button.dart';
import 'package:restaurant_foodly/common/custom_textField.dart';
import 'package:restaurant_foodly/common/reusable_text.dart';
import 'package:restaurant_foodly/constants/constants.dart';
import 'package:restaurant_foodly/controllers/food_controller.dart';
import 'package:restaurant_foodly/models/addittives.dart';

class AdditivesInfo extends StatelessWidget {
  const AdditivesInfo(
      {super.key,
      required this.addttivesPrice,
      required this.addttivesTitle,
      required this.back,
      required this.submit,
      required this.countInStock});

  final TextEditingController addttivesPrice;
  final TextEditingController addttivesTitle;
  final TextEditingController countInStock;

  final Function back, submit;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FoodController());
    return SizedBox(
      height: height,
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.w, top: 15.h, bottom: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableText(
                    text: "Add Addittives Info",
                    style: appStyle(16, kGray, FontWeight.w600)),
                ReusableText(
                    text:
                        "You are required to add additives info for your product if it has any",
                    style: appStyle(11, kGray, FontWeight.normal)),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.35,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 25.h,
                  ),
                  CustomTextField(
                      controller: addttivesTitle,
                      hinText: "Addittives Title",
                      prefixIcon: const Icon(Icons.keyboard_capslock)),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomTextField(
                      controller: addttivesPrice,
                      hinText: "Addittives Price (Number)",
                      keyboardType: TextInputType.number,
                      prefixIcon: const Icon(Icons.keyboard_capslock)),
                  SizedBox(
                    height: 15.h,
                  ),
                  Obx(
                    () => controller.addittiveList.isNotEmpty
                        ? SizedBox(
                            height: 90.h,
                            child: ListView(
                              scrollDirection: Axis.vertical,
                              children: [
                                Column(
                                  children: List.generate(
                                    controller.addittiveList.length,
                                    (index) {
                                      final addittive =
                                          controller.addittiveList[index];
                                      return Container(
                                          margin: EdgeInsets.only(bottom: 8.h),
                                          decoration: BoxDecoration(
                                            color: kLightWhite,
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 2.h, horizontal: 5.w),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ReusableText(
                                                    text: addittive.title,
                                                    style: appStyle(11, kDark,
                                                        FontWeight.w600)),
                                                ReusableText(
                                                    text:
                                                        "\$ ${addittive.price.toString()}",
                                                    style: appStyle(11, kDark,
                                                        FontWeight.w600)),
                                              ],
                                            ),
                                          ));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomButton(
                    text: "A D D   A D D I T T I V E S",
                    btnWidth: width,
                    btnColor: kSecondary,
                    btnRadius: 9,
                    onTap: () {
                      if (addttivesPrice.text.isNotEmpty &&
                          addttivesTitle.text.isNotEmpty) {
                        Addittives addittive = Addittives(
                            id: controller.generateId(),
                            title: addttivesTitle.text,
                            price: addttivesPrice.text);

                        controller.addAddittives = addittive;
                        addttivesTitle.text = '';
                        addttivesPrice.text = '';
                      } else {
                        Get.snackbar("You need data to add addittives",
                            "Please fill all fields",
                            icon: const Icon(Icons.error_outline),
                            colorText: kLightWhite,
                            backgroundColor: kRed);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.w, top: 12.h, bottom: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableText(
                    text: "Foods count in Stock",
                    style: appStyle(16, kGray, FontWeight.w600)),
                ReusableText(
                    text:
                        "You are required foods count in stock in your restaurant.",
                    style: appStyle(11, kGray, FontWeight.normal)),
              ],
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.h),
            child: Column(
              children: [
                CustomTextField(
                    controller: countInStock,
                    hinText: "Add Foods Count",
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(Icons.keyboard_capslock)),
                SizedBox(height: 15.h),
              ],
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Padding(
            padding: EdgeInsets.all(12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  text: "Back",
                  btnWidth: width / 2.3,
                  btnRadius: 9,
                  onTap: () {
                    back();
                  },
                ),
                CustomButton(
                  text: "Submit",
                  btnWidth: width / 2.3,
                  btnRadius: 6,
                  onTap: () {
                    submit();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

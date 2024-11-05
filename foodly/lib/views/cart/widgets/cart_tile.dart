import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/common/reusable_text.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/controller/cart_controller.dart';
import 'package:foodly/models/cart_response.dart';
import 'package:get/get.dart';

class CartTile extends StatelessWidget {
  const CartTile({super.key, required this.cart, this.color, this.refetch});

  final CartResponse cart;
  final Color? color;
  final Function? refetch;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    return GestureDetector(
      onTap: () {
        // Get.to(() => FoodPage(cart: cart));
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 8.h),
            height: 90.h,
            width: width,
            decoration: BoxDecoration(
              color: color ?? kGrayLight,
              borderRadius: BorderRadius.circular(9.r),
            ),
            child: Container(
              padding: EdgeInsets.all(4.r),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Stack(
                      clipBehavior: Clip.hardEdge,
                      children: [
                        SizedBox(
                          width: 75.w,
                          height: 80.h,
                          child: Image.network(
                            cart.productId.imageUrl[0],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            padding: EdgeInsets.only(left: 1.w, bottom: 2.h),
                            color: kGray,
                            height: 16.w,
                            width: width,
                            child: RatingBarIndicator(
                              rating: 5,
                              itemCount: 5,
                              itemBuilder: (context, index) =>
                                  const Icon(Icons.star, color: kSecondary),
                              itemSize: 14.h,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Container(
                    width: width * 0.47,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableText(
                            maxLine: 1,
                            textOverflow: TextOverflow.ellipsis,
                            text: cart.productId.title,
                            style: appStyle(14, kDark, FontWeight.w500)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 3.h, 3.w, 3.h),
                          height: 20.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13.r),
                          ),
                          child: ReusableText(
                              text: "Count in Stock: ${cart.quantity}",
                              style: appStyle(13, kGray, FontWeight.w600)),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                            width: width * 0.5,
                            height: 20.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: cart.additives.length,
                              itemBuilder: (context, index) {
                                var additive = cart.additives[index];
                                return Container(
                                  margin: EdgeInsets.only(right: 5.w),
                                  decoration: BoxDecoration(
                                      color: kSecondaryLight,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(9.r))),
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(4.h),
                                      child: ReusableText(
                                          text: additive,
                                          style: appStyle(
                                              10, kGray, FontWeight.w600)),
                                    ),
                                  ),
                                );
                              },
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              right: 10.w,
              top: 6.h,
              child: Container(
                width: 50.w,
                height: 20.h,
                decoration: BoxDecoration(
                  color: kPrimary,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: ReusableText(
                      text: "\$${cart.totalPrice.toStringAsFixed(2)}",
                      style: appStyle(12, kLightWhite, FontWeight.w600)),
                ),
              )),
          Positioned(
              right: 70.w,
              top: 6.h,
              child: GestureDetector(
                onTap: () {
                  controller.removeFromCart(cart.id, refetch!);
                },
                child: Container(
                  width: 19.w,
                  height: 19.h,
                  decoration: BoxDecoration(
                    color: kRed,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                      child: Center(
                    child: Icon(
                      MaterialCommunityIcons.trash_can,
                      size: 15.h,
                      color: kLightWhite,
                    ),
                  )),
                ),
              )),
        ],
      ),
    );
  }
}

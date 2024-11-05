import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_foodly/common/app_style.dart';
import 'package:restaurant_foodly/common/reusable_text.dart';
import 'package:restaurant_foodly/constants/constants.dart';
import 'package:restaurant_foodly/models/order_model.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    // final location = Get.put(UserLocationController());
    // final controller = Get.put(OrdersController());

    // DistanceTime distance = Distance().calculateDistanceTime(
    //     location.currentLocation.latitude,
    //     location.currentLocation.longitude,
    //     order.recipientCoords[0],
    //     order.restaurantCoords[1],
    //     5,
    //     5);

    // DistanceTime distance2 = Distance().calculateDistanceTime(
    //     order.restaurantCoords[0],
    //     order.restaurantCoords[1],
    //     order.recipientCoords[0],
    //     order.recipientCoords[1],
    //     5,
    //     5);

    // double distanceToRestaurant = distance.distance + 1;
    // double distanceFromRestaurantToClient = distance2.distance + 1;

    return GestureDetector(
      onTap: () {
        // controller.order = order;
        // controller.setDistance =
        //     distanceToRestaurant + distanceFromRestaurantToClient;
        // Get.to(() => ActivePage(),
        //     transition: kTransition, duration: kDuration);
      },
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 8.h),
            height: 90.h,
            width: width,
            decoration: BoxDecoration(
                color: kOffWhite,
                // controller.order == null
                //     ? kOffWhite
                //     : controller.order!.id == order.id
                //         ? kSecondaryLight
                //         : kOffWhite,
                borderRadius: BorderRadius.circular(9.r)),
            child: Container(
              padding: EdgeInsets.all(6.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    child: SizedBox(
                      height: 70.h,
                      width: 70.w,
                      child: Image.network(
                        order.orderItems[0].foodId.imageUrl[0],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.h,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 6.h,
                      ),
                      ReusableText(
                          text: order.orderItems[0].foodId.title,
                          style: appStyle(13, kDark, FontWeight.w600)),
                      ReusableText(
                        text: "📦 Order id: ${order.id}",
                        style: appStyle(12, kGray, FontWeight.w400),
                      ),
                      Container(
                        width: width * 0.7,
                        child: ReusableText(
                          textOverflow: TextOverflow.ellipsis,
                          text: "🏡 ${order.deliveryAddress.addressLine1}",
                          style: appStyle(12, kGray, FontWeight.w400),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            margin: EdgeInsets.only(right: 2.w),
                            decoration: BoxDecoration(
                              color: kOffWhite,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.r)),
                            ),
                            child: ReusableText(
                                textOverflow: TextOverflow.ellipsis,
                                maxLine: 1,
                                text:
                                    "\$ ${order.deliveryFee.toStringAsFixed(2)}",
                                style: appStyle(10, kGray, FontWeight.w400)),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            margin: EdgeInsets.only(right: 2.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: ReusableText(
                                text: "⏰ 25 min",
                                style: appStyle(9, kGray, FontWeight.w400)),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

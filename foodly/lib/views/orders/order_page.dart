import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/common/background_container.dart';
import 'package:foodly/common/custom_button.dart';
import 'package:foodly/common/reusable_text.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/controller/food_controller.dart';
import 'package:foodly/controller/order_controller.dart';
import 'package:foodly/models/address_response.dart';
import 'package:foodly/models/distance_time.dart';
import 'package:foodly/models/food.dart';
import 'package:foodly/models/order_request.dart';
import 'package:foodly/models/restaurant.dart';
import 'package:foodly/services/distance.dart';
import 'package:foodly/views/orders/payments/payment_page.dart';
import 'package:foodly/views/orders/widget/order_tile.dart';
import 'package:foodly/views/restaurant/restaurant_page.dart';
import 'package:get/get.dart';

class OrderPage extends StatefulWidget {
  const OrderPage(
      {super.key,
      this.restaurant,
      required this.foods,
      required this.items,
      required this.address});
  final RestaurantModel? restaurant;
  final FoodModel foods;
  final OrderItem items;
  final AddressResponse? address;

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    final foodControler = Get.put(FoodController());
    // final distanceController = Get.put(UserLocationController());

    DistanceTime data = Distance().calculateDistanceTime(
        widget.restaurant!.coords.latitude,
        widget.restaurant!.coords.longitude,
        widget.address!.latitude,
        widget.address!.longitude,
        50,
        0.2);

    double grandTotal() {
      return data.distance + widget.items.price;
    }

    int totalCount() {
      int total = widget.foods.countInStock - widget.items.quantity;
      return total;
    }

    print("counttttt: ${widget.foods.countInStock}");
    print("count add placed: ${widget.items.foodId}");

    print(totalCount());

    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        backgroundColor: kPrimary,
        centerTitle: true,
        title: ReusableText(
          text: "Complete Ordering",
          style: appStyle(13, kLightWhite, FontWeight.w600),
        ),
      ),
      body: BackgroundContainer(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              OrderTile(food: widget.foods),
              Container(
                padding: EdgeInsets.all(10.h),
                width: width,
                // height: height / 3.8,
                decoration: BoxDecoration(
                    color: kOffWhite,
                    borderRadius: BorderRadius.circular(12.r)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableText(
                            text: widget.restaurant!.title,
                            style: appStyle(20, kGray, FontWeight.bold)),
                        CircleAvatar(
                          radius: 18.r,
                          backgroundColor: kPrimary,
                          backgroundImage:
                              NetworkImage(widget.restaurant!.logoUrl),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    RowText(
                        first: "Business Hours",
                        sencond: widget.restaurant!.time),
                    SizedBox(
                      height: 5.h,
                    ),
                    RowText(
                        first: "Distance from Restaurant",
                        sencond: "${data.time.toStringAsFixed(2)} km"),
                    SizedBox(
                      height: 5.h,
                    ),
                    RowText(
                        first: "Price from Restaurant",
                        sencond: "\$ ${data.price.toStringAsFixed(2)}"),
                    SizedBox(
                      height: 5.h,
                    ),
                    RowText(
                        first: "Order Total",
                        sencond: "\$${widget.items.price.toString()}"),
                    SizedBox(
                      height: 5.h,
                    ),
                    // DistanceTime.calculateDistanceTime()
                    RowText(
                        first: "Grand Total",
                        sencond: "\$${grandTotal().toStringAsFixed(2)}"),
                    SizedBox(
                      height: 15.h,
                    ),
                    ReusableText(
                        text: "Additives",
                        style: appStyle(20, kGray, FontWeight.bold)),
                    SizedBox(
                      height: 5.h,
                    ),
                    SizedBox(
                        width: width,
                        height: 20.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.items.additives.length,
                          itemBuilder: (context, index) {
                            String additive = widget.items.additives[index];
                            return Container(
                              margin: EdgeInsets.only(right: 5.w),
                              decoration: BoxDecoration(
                                  color: kSecondaryLight,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(9.r))),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(5.h),
                                  child: ReusableText(
                                      text: additive,
                                      style:
                                          appStyle(9, kGray, FontWeight.w400)),
                                ),
                              ),
                            );
                          },
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomButton(
                text: "Procesd to Payment",
                btnHeight: 45,
                btnColor: kPrimary,
                onTap: () {
                  OrderRequest order = OrderRequest(
                    userId: widget.address!.userId,
                    orderItems: [widget.items],
                    orderTotal: widget.items.price,
                    deliveryFee: data.price.toDouble(),
                    grandTotal: grandTotal(),
                    deliveryAddress: widget.address!.id,
                    restaurantAddress: widget.restaurant!.coords.address,
                    // paymentMethod: paymentMethod,
                    // paymentStatus: paymentStatus,
                    // orderStatus: orderStatus,
                    restaurantId: widget.restaurant!.id,
                    restaurantCoords: [
                      widget.restaurant!.coords.latitude,
                      widget.restaurant!.coords.longitude
                    ],
                    recipientCoords: [
                      widget.address!.latitude,
                      widget.address!.longitude
                    ],
                    // driverId: driverId,
                    // rating: rating,
                    // feedback: feedback,
                    // promoCode: promoCode,
                    // discountAmount: discountAmount,
                    // note: note
                  );

                  String orderData = orderRequestToJson(order);
                  controller.createOrder(orderData, order);
                  foodControler.updateCountInStock(
                      totalCount(), widget.items.foodId);

                  Get.to(
                      () => PaymentPage(
                            orderId: widget.address!.id,
                            resId: widget.restaurant!.id,
                            amount:
                                double.parse(grandTotal().toStringAsFixed(2)),
                          ),
                      transition: Transition.fadeIn,
                      duration: const Duration(microseconds: 900));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/common/reusable_text.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/constants/uidata.dart';
import 'package:foodly/models/address_response.dart';
import 'package:foodly/models/distance_time.dart';
import 'package:foodly/models/restaurant.dart';
import 'package:foodly/services/distance.dart';
import 'package:foodly/views/restaurant/direction_page.dart';
import 'package:foodly/views/restaurant/widget/restaurant_bottom_bar.dart';
import 'package:foodly/views/restaurant/widget/restaurant_explore.dart';
import 'package:foodly/views/restaurant/widget/restaurant_menu.dart';
import 'package:get/get.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key, this.restaurant, this.address});

  final RestaurantModel? restaurant;
  final AddressResponse? address;

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage>
    with TickerProviderStateMixin {
  late TabController _tabController = TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    DistanceTime data = Distance().calculateDistanceTime(
        widget.restaurant!.coords.latitude,
        widget.restaurant!.coords.longitude,
        widget.address!.latitude,
        widget.address!.longitude,
        50,
        10000);
    print(restaurants);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: kLightWhite,
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 230.h,
                  width: width,
                  child: CachedNetworkImage(
                    imageUrl: widget.restaurant!.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      width: width,
                      height: 40.h,
                      decoration: BoxDecoration(
                          color: kPrimary.withOpacity(0.4),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.r),
                            topRight: Radius.circular(10.r),
                          )),
                      child: RestaurantBottomBar(widget: widget),
                    )),
                Positioned(
                    top: 40.h,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(
                              Ionicons.chevron_back_circle,
                              size: 28,
                              color: kLightWhite,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const DirectionPage());
                            },
                            child: const Icon(
                              Ionicons.location,
                              size: 28,
                              color: kLightWhite,
                            ),
                          )
                        ],
                      ),
                    )),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8.h),
              child: ReusableText(
                  maxLine: 2,
                  textOverflow: TextOverflow.ellipsis,
                  text: widget.restaurant!.title,
                  style: appStyle(18, kDark, FontWeight.w600)),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                children: [
                  RowText(
                      first: "Distance to restaurant",
                      sencond: "${data.distance.toStringAsFixed(2)} km"),
                  SizedBox(
                    height: 3.h,
                  ),
                  RowText(
                      first: "Estimated Price",
                      sencond: "${data.price.toStringAsFixed(0)} đ"),
                  SizedBox(
                    height: 3.h,
                  ),
                  RowText(
                      first: "Estimated Time",
                      sencond: "${data.time.toStringAsFixed(2)} hours"),
                  const Divider(
                    thickness: 0.7,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Container(
                height: 25.h,
                width: width,
                decoration: BoxDecoration(
                    color: kOffWhite,
                    borderRadius: BorderRadius.circular(25.r)),
                child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: kPrimary,
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    labelPadding: EdgeInsets.zero,
                    labelStyle: appStyle(12, kLightWhite, FontWeight.normal),
                    labelColor: kLightWhite,
                    unselectedLabelColor: kGrayLight,
                    dividerColor: Colors.transparent,
                    tabs: [
                      Tab(
                        child: SizedBox(
                          width: width / 2,
                          height: 25.h,
                          child: const Center(
                            child: Text("Menu"),
                          ),
                        ),
                      ),
                      Tab(
                        child: SizedBox(
                          width: width / 2,
                          height: 25.h,
                          child: const Center(
                            child: Text("Explore"),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: SizedBox(
                height: height,
                child: TabBarView(controller: _tabController, children: [
                  RestaurantMenu(restaurantId: widget.restaurant!.id),
                  RestaurantExplore(code: widget.restaurant!.code),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RowText extends StatelessWidget {
  const RowText({super.key, required this.first, required this.sencond});

  final String first;
  final String sencond;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ReusableText(text: first, style: appStyle(10, kGray, FontWeight.w500)),
        ReusableText(
            text: sencond, style: appStyle(10, kGray, FontWeight.w500)),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly/common/shimmers/nearby_shimmer.dart';
import 'package:foodly/hooks/fetch_default_address.dart';
import 'package:foodly/hooks/fetch_restaurant.dart';
import 'package:foodly/models/address_response.dart';
import 'package:foodly/models/restaurant.dart';
import 'package:foodly/views/home/widgets/restaurant_widget.dart';
import 'package:foodly/views/restaurant/restaurant_page.dart';
import 'package:get/get.dart';

class NearbyRestaurants extends HookWidget {
  const NearbyRestaurants({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchRestaurant("100000");
    List<RestaurantModel>? restaurants = hookResult.data;
    final isLoading = hookResult.isLoading;

    final data = fetchDefaultAddresses(context);
    AddressResponse? address = data.data;

    return isLoading
        ? const NearbyShimmer()
        : Container(
            height: 190.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(3, (i) {
                RestaurantModel restaurant = restaurants![i];
                return RestaurantWidget(
                    onTap: () {
                      Get.to(() => RestaurantPage(
                            restaurant: restaurant,
                            address: address,
                          ));
                    },
                    images: restaurant.imageUrl,
                    logo: restaurant.logoUrl,
                    title: restaurant.title,
                    time: restaurant.time,
                    rating: restaurant.rating,
                    ratingCount: restaurant.ratingCount);
              }),
            ),
          );
  }
}

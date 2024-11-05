import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_foodly/constants/constants.dart';
import 'package:restaurant_foodly/hooks/order_list_hook.dart';
import 'package:restaurant_foodly/shimmers/foodlist_shimmer.dart';
import 'package:restaurant_foodly/views/home/widget/order_tile.dart';

class Delivered extends HookWidget {
  const Delivered({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults = fetchOrders("Delivered");
    final isLoading = hookResults.isLoading;
    final data = hookResults.data;
    final error = hookResults.error;

    if (isLoading) {
      return const FoodsListShimmer();
    }

    if (error != null) {
      return Center(
        child: Text(error.message),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15.r),
        topRight: Radius.circular(15.r),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: kGrayLight.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: ListView(
          children: List.generate(data!.length, (index) {
            final order = data[index];
            return Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: OrderTile(
                  order: order,
                ));
          }),
        ),
      ),
    );
  }
}

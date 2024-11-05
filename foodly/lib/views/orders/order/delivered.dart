import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodly/common/shimmers/foodlist_shimmer.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/hooks/fetch_orders.dart';
import 'package:foodly/models/client_order.dart';
import 'package:foodly/views/orders/widget/client_order_tile.dart';

class Delivered extends HookWidget {
  const Delivered({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchOrders("Delivered", "Completed");
    List<ClientOrders> orders = hookResults.data;
    final isLoading = hookResults.isLoading;

    if (isLoading) {
      return const FoodsListShimmer();
    }
    return SizedBox(
      height: height * 0.8,
      child: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return ClientOrderTile(
            food: orders[index].orderItems[0],
            grandTotal: orders[index],
          );
        },
      ),
    );
  }
}

// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/common/background_container.dart';
import 'package:foodly/common/reusable_text.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/views/orders/order/cancelled.dart';
import 'package:foodly/views/orders/order/delivered.dart';
import 'package:foodly/views/orders/order/delivering.dart';
import 'package:foodly/views/orders/order/pending.dart';
import 'package:foodly/views/orders/order/preparing.dart';
import 'package:foodly/views/orders/widget/order_tabs.dart';

class UserOrder extends StatefulWidget {
  const UserOrder({super.key});

  @override
  State<UserOrder> createState() => _UserOrderState();
}

class _UserOrderState extends State<UserOrder> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: orderList.length, vsync: this);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kOffWhite,
        title: ReusableText(
            text: "My Orders", style: appStyle(14, kPrimary, FontWeight.w600)),
        centerTitle: true,
      ),
      body: BackgroundContainer(
          color: kLightWhite,
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                OrderTabs(tabController: _tabController),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height: height * 0.7,
                  width: width,
                  child:
                      TabBarView(controller: _tabController, children: const [
                    Pending(),
                    Preparing(),
                    Delivering(),
                    Delivered(),
                    Cancelled(),
                  ]),
                )
              ],
            ),
          )),
    );
  }
}

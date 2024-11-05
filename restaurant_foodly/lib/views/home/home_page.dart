import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_foodly/common/background_container.dart';
import 'package:restaurant_foodly/common/custom_appbar.dart';
import 'package:restaurant_foodly/constants/constants.dart';
import 'package:restaurant_foodly/views/home/widget/home_tabs.dart';
import 'package:restaurant_foodly/views/home/widget/home_tile_widget.dart';
import 'package:restaurant_foodly/views/home/widget/orders/cancelled.dart';
import 'package:restaurant_foodly/views/home/widget/orders/delivered.dart';
import 'package:restaurant_foodly/views/home/widget/orders/new_orders.dart';
import 'package:restaurant_foodly/views/home/widget/orders/picked_up.dart';
import 'package:restaurant_foodly/views/home/widget/orders/preparing.dart';
import 'package:restaurant_foodly/views/home/widget/orders/ready_order.dart';
import 'package:restaurant_foodly/views/home/widget/orders/self_deliveries.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: orderList.length, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        flexibleSpace: const CustomAppbar(),
        elevation: 0,
        backgroundColor: kPrimary,
      ),
      body: BackgroundContainer(
          child: ListView(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: 15.h,
          ),
          const HomeTileWidget(),
          SizedBox(
            height: 15.h,
          ),
          //tabBar
          HomeTabs(tabController: _tabController),
          SizedBox(
            height: 15.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12.w),
            height: height * 0.7,
            color: Colors.transparent,
            child: TabBarView(controller: _tabController, children: const [
              NewOrders(),
              Preparing(),
              ReadyOrder(),
              PickedUp(),
              SelfDeliveries(),
              Delivered(),
              Cancelled(),
            ]),
          ),
        ],
      )),
    );
  }
}

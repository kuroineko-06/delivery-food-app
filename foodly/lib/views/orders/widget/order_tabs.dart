import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/common/tab_widget.dart';
import 'package:foodly/constants/constants.dart';

class OrderTabs extends StatelessWidget {
  const OrderTabs({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        dividerColor: Colors.transparent,
        tabAlignment: TabAlignment.start,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: kPrimary,
        ),
        labelColor: Colors.white,
        labelStyle: appStyle(12, kLightWhite, FontWeight.normal),
        unselectedLabelColor: kGrayLight,
        tabs: List.generate(
            orderList.length, (index) => TabWidget(text: orderList[index])),
      ),
    );
  }
}

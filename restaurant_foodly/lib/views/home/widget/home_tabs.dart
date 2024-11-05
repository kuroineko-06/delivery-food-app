import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_foodly/common/app_style.dart';
import 'package:restaurant_foodly/common/tab_widget.dart';
import 'package:restaurant_foodly/constants/constants.dart';

class HomeTabs extends StatelessWidget {
  const HomeTabs({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 13.w),
      child: Container(
        height: 25.h,
        width: width,
        decoration: BoxDecoration(
            color: kOffWhite, borderRadius: BorderRadius.circular(25.r)),
        child: TabBar(
          controller: _tabController,
          labelColor: kLightWhite,
          dividerColor: Colors.transparent,
          unselectedLabelColor: kGrayLight,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          labelPadding: EdgeInsets.zero,
          labelStyle: appStyle(12, kLightWhite, FontWeight.normal),
          unselectedLabelStyle: appStyle(12, kGrayLight, FontWeight.w600),
          indicator: BoxDecoration(
              color: kPrimary, borderRadius: BorderRadius.circular(25.r)),
          tabs: List.generate(orderList.length, (index) {
            return TabWidget(text: orderList[index]);
          }),
        ),
      ),
    );
  }
}

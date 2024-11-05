// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/common/reusable_text.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/models/address_response.dart';
import 'package:foodly/views/profile/widget/detail_address.dart';
import 'package:get/get.dart';

class AddressTile extends StatelessWidget {
  const AddressTile({super.key, required this.address});

  final AddressResponse address;

  @override
  Widget build(BuildContext context) {
    print(address.addressResponseDefault);
    return Column(
      children: [
        address.addressResponseDefault == true
            ? Container(
                child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    height: 15.h,
                    width: width,
                    child: ReusableText(
                        text: "Default address",
                        style: appStyle(13, kDark, FontWeight.w500)),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  ListTile(
                    onTap: () {
                      print(address.id);

                      Get.to(() => DetailAddress(address: address));
                    },
                    visualDensity: VisualDensity.compact,
                    leading: Icon(SimpleLineIcons.location_pin,
                        color: kPrimary, size: 20.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    title: ReusableText(
                        text: address.addressLine1,
                        style: appStyle(13, kDark, FontWeight.w500)),
                    minVerticalPadding: 10.h,
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableText(
                            text: address.postalCode,
                            style: appStyle(11, kGray, FontWeight.w500)),
                        SizedBox(height: 3.h),
                        ReusableText(
                            text: "Default address",
                            style: appStyle(9, kGray, FontWeight.w500)),
                      ],
                    ),
                  ),
                ],
              ))
            : Container(
                child: Column(children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    height: 15.h,
                    width: width,
                    child: ReusableText(
                        text: "Another address",
                        style: appStyle(13, kDark, FontWeight.w500)),
                  ),
                  ListTile(
                    onTap: () {
                      print(address.id);
                      Get.to(() => DetailAddress(address: address));
                    },
                    visualDensity: VisualDensity.compact,
                    leading: Icon(SimpleLineIcons.location_pin,
                        color: kPrimary, size: 20.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    title: ReusableText(
                        text: address.addressLine1,
                        style: appStyle(13, kDark, FontWeight.w500)),
                    minVerticalPadding: 10.h,
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 3.h),
                        ReusableText(
                            text: address.postalCode,
                            style: appStyle(11, kGray, FontWeight.w500)),
                        SizedBox(height: 3.h),
                        ReusableText(
                            text: "Tap to set as default",
                            style: appStyle(9, kGray, FontWeight.w500)),
                      ],
                    ),
                  ),
                ]),
              )
      ],
    );
  }
}

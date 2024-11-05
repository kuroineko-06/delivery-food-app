import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/common/background_container.dart';
import 'package:foodly/common/custom_button.dart';
import 'package:foodly/common/reusable_text.dart';
import 'package:foodly/common/shimmers/foodlist_shimmer.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/hooks/fetch_address.dart';
import 'package:foodly/models/address_response.dart';
import 'package:foodly/views/profile/shipping_address.dart';
import 'package:foodly/views/profile/widget/address_list.dart';
import 'package:get/get.dart';

class AddressPage extends HookWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults = fetchAddresses();
    final List<AddressResponse> addresses = hookResults.data ?? [];
    final isLoading = hookResults.isLoading;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kOffWhite,
        centerTitle: true,
        title: ReusableText(
            text: "Addresses", style: appStyle(13, kGray, FontWeight.w600)),
      ),
      body: BackgroundContainer(
          color: kOffWhite,
          child: Stack(
            children: [
              isLoading
                  ? const FoodsListShimmer()
                  : Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: AddressListWidget(addresses: addresses),
                    ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 30.h),
                  child: CustomButton(
                    onTap: () {
                      Get.to(() => const ShippingAddress(),
                          transition: Transition.rightToLeft,
                          duration: const Duration(milliseconds: 500));
                    },
                    text: "Add Address",
                    btnHeight: 30,
                  ),
                ),
              )
            ],
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:foodly/common/custom_button.dart';
import 'package:foodly/common/profile_app_bar.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/common/custom_container.dart';
import 'package:foodly/controller/login_controller.dart';
import 'package:foodly/models/login_response.dart';
import 'package:foodly/views/auth/login_redirect.dart';
import 'package:foodly/views/orders/user_order.dart';
import 'package:foodly/views/profile/address_page.dart';
import 'package:foodly/views/profile/widget/profile_tile_widget.dart';
import 'package:foodly/views/profile/widget/user_info_widget.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginResponse? user;
    final controller = Get.put(LoginController());
    final box = GetStorage();
    String? token = box.read('token');

    if (token != null) {
      user = controller.getUserInfo();
      print(user!.email);
      print("token: ${token}");
    }

    if (token == null) {
      return const LoginRedirect();
    }
    return Scaffold(
        backgroundColor: kPrimary,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(40.h), child: const ProfileAppBar()),
        body: SafeArea(
            child: Container(
          height: height - 171.h,
          child: CustomContainer(
              containerContent: Column(
            children: [
              UserInfoWidget(
                user: user,
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 175.h,
                decoration: const BoxDecoration(
                  color: kLightWhite,
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ProfileTileWidget(
                        onTap: () {
                          Get.to(() => UserOrder(),
                              transition: Transition.cupertino,
                              duration: const Duration(microseconds: 600));
                        },
                        title: "My Orders",
                        icon: Ionicons.fast_food_outline),
                    ProfileTileWidget(
                        onTap: () {
                          Get.to(() => const LoginRedirect());
                        },
                        title: "My Favorite Places",
                        icon: Ionicons.heart_outline),
                    ProfileTileWidget(
                        onTap: () {},
                        title: "Review",
                        icon: Ionicons.chatbubble_outline),
                    ProfileTileWidget(
                        onTap: () {},
                        title: "Coupons",
                        icon: MaterialCommunityIcons.tag_outline),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                height: 175.h,
                decoration: const BoxDecoration(
                  color: kLightWhite,
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ProfileTileWidget(
                        onTap: () {
                          Get.to(() => const AddressPage(),
                              transition: Transition.rightToLeft,
                              duration: const Duration(milliseconds: 500));
                        },
                        title: "Shipping Address",
                        icon: SimpleLineIcons.location_pin),
                    ProfileTileWidget(
                        onTap: () {},
                        title: "Service Center",
                        icon: AntDesign.customerservice),
                    ProfileTileWidget(
                        onTap: () {},
                        title: "Payment Method",
                        icon: MaterialIcons.payment),
                    ProfileTileWidget(
                        onTap: () {},
                        title: "Settings",
                        icon: AntDesign.setting),
                  ],
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              CustomButton(
                onTap: () {
                  controller.logout();
                },
                text: "Logout",
                btnRadius: 0,
                btnHeight: 30.h,
                btnColor: kRed,
              )
            ],
          )),
        )));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/common/custom_button.dart';
import 'package:foodly/common/custom_container.dart';
import 'package:foodly/common/reusable_text.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/views/auth/login_page.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoginRedirect extends StatelessWidget {
  const LoginRedirect({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(75.h),
          child: AppBar(
            backgroundColor: Colors.white,
            title: ReusableText(
              text: "Please login to access this page",
              style: appStyle(12, kDark, FontWeight.normal),
            ),
            centerTitle: true,
          )),
      body: CustomContainer(
        color: Colors.white,
        containerContent: Column(
          children: [
            Lottie.asset("assets/anime/delivery.json"),
            SizedBox(
              height: 20.h,
            ),
            CustomButton(
              text: "L O G I N",
              onTap: () {
                Get.to(() => const LoginPage(),
                    transition: Transition.cupertino,
                    duration: const Duration(microseconds: 900));
              },
              btnHeight: 40.h,
              btnWidth: width - 20,
            ),
          ],
        ),
      ),
    );
  }
}

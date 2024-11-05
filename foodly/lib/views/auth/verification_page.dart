import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/common/custom_button.dart';
import 'package:foodly/common/custom_container.dart';
import 'package:foodly/common/reusable_text.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/controller/verification_controller.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerificationController());
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        title: ReusableText(
            text: "Please Verify Your Account",
            style: appStyle(12, kGray, FontWeight.w600)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: CustomContainer(
        color: Colors.white,
        containerContent: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Container(
            height: height,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Lottie.asset("assets/anime/delivery.json"),
                SizedBox(
                  height: 10.h,
                ),
                ReusableText(
                    text: "Verify Your Account",
                    style: appStyle(12, kPrimary, FontWeight.w600)),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                    "Enter the 6-digit code sent to your email, if you don't see the code, please check your spam folder.",
                    textAlign: TextAlign.justify,
                    style: appStyle(10, kGray, FontWeight.normal)),
                SizedBox(
                  height: 20.h,
                ),
                OtpTextField(
                    numberOfFields: 6,
                    borderColor: kPrimary,
                    borderWidth: 2.0,
                    textStyle: appStyle(17, kDark, FontWeight.w600),
                    onCodeChanged: (String code) {},
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    onSubmit: (String verificationCode) {
                      controller.setCode = verificationCode;
                    }),
                SizedBox(
                  height: 30.h,
                ),
                CustomButton(
                  text: "V E R I F Y   A C C O U N T ",
                  onTap: () {
                    controller.verificationFunction(); //146828
                  },
                  btnHeight: 35.h,
                  btnWidth: width,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

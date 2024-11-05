import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:otp_text_field_v2/otp_field_v2.dart';
import 'package:restaurant_foodly/common/app_style.dart';
import 'package:restaurant_foodly/common/custom_button.dart';
import 'package:restaurant_foodly/common/reusable_text.dart';
import 'package:restaurant_foodly/constants/constants.dart';
import 'package:restaurant_foodly/controllers/email_verification_controller.dart';
import 'package:restaurant_foodly/controllers/login_controller.dart';
import 'package:restaurant_foodly/models/login_response.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  @override
  Widget build(BuildContext context) {
    OtpFieldControllerV2 otpController = OtpFieldControllerV2();

    final controller = Get.put(EmailVerificationController());
    final userController = Get.put(LoginController());
    LoginResponse? user = userController.getUserData();
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          SizedBox(
            height: 100.h,
          ),
          Lottie.asset("assets/anime/delivery.json"),
          SizedBox(
            height: 30.h,
          ),
          ReusableText(
              text: "Verify Your Account",
              style: appStyle(20, kPrimary, FontWeight.w600)),
          Text(
              "Enter the 6-digit code sent to email ${user!.email}, if you don't see the code, please check your spam folder.",
              textAlign: TextAlign.justify,
              style: appStyle(10, kGray, FontWeight.normal)),
          SizedBox(
            height: 20.h,
          ),
          OTPTextFieldV2(
            controller: otpController,
            length: 6,
            width: MediaQuery.of(context).size.width,
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldWidth: 45,
            fieldStyle: FieldStyle.box,
            outlineBorderRadius: 15,
            style: appStyle(17, kDark, FontWeight.w500),
            onCompleted: (pin) {
              controller.setCode(pin);
              controller.verifyEmail(pin);
            },
          ),
          SizedBox(
            height: 30.h,
          ),
          CustomButton(
            text: "V E R I F Y   A C C O U N T ",
            onTap: () {
              controller.verifyEmail(controller.code); //146828
            },
            btnHight: 35.h,
            btnWidth: width,
          ),
          SizedBox(
            height: 30.h,
          ),
          Text(
              "The email has been sent to ${user.email}, if the email is not correct, please delete this account and create a new one with the correct email. Alternatively, you can logout and browser the app without an account.",
              textAlign: TextAlign.justify,
              style: appStyle(10, kGray, FontWeight.normal)),
          SizedBox(
            height: 15.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  userController.logout();
                },
                child: ReusableText(
                    text: "LOGOUT",
                    style: appStyle(12, kSecondary, FontWeight.w600)),
              ),
              GestureDetector(
                onTap: () {
                  // userController.deleteAccount();
                },
                child: ReusableText(
                    text: "DELETE ACCOUNT",
                    style: appStyle(12, kRed, FontWeight.w600)),
              )
            ],
          )
        ],
      ),
    );
  }
}

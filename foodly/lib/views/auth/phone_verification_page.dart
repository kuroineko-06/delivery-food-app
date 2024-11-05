import 'package:flutter/material.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/controller/phone_verification_controller.dart';
import 'package:foodly/services/verification_services.dart';
import 'package:get/get.dart';
import 'package:phone_otp_verification/phone_verification.dart';

class PhoneVerificationPage extends StatefulWidget {
  const PhoneVerificationPage({super.key});

  @override
  State<PhoneVerificationPage> createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  VerificationServices _verificationServices = VerificationServices();
  String _verificationId = "";

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PhoneVerificationController());
    return Obx(
      () => controller.isLoading == false
          ? PhoneVerification(
              isFirstPage: false,
              enableLogo: false,
              themeColor: Colors.blueAccent,
              backgroundColor: kLightWhite,
              initialPageText: "Verify Phone Number",
              initialPageTextStyle: appStyle(20, kPrimary, FontWeight.bold),
              textColor: kDark,
              onSend: (String value) {
                print('Phone number: $value');
                controller.setPhoneNumber = value;
                _verifyPhoneNumber(value);
              },
              onVerification: (String value) {
                _submitVerificationCode(value);
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  void _verifyPhoneNumber(String phoneNumber) async {
    final controller = Get.put(PhoneVerificationController());

    await _verificationServices.verifyPhoneNumber(controller.phone,
        codeSent: (String verificationId, int? resendToken) {
      setState(() {
        _verificationId = verificationId;
      });
    });
  }

  void _submitVerificationCode(String code) async {
    await _verificationServices.verifySmsCode(_verificationId, code);
  }
}

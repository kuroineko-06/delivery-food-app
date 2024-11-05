import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';

String googleApiKey = 'AlzaSyqUd4bD_IVUi1_zFLUQm6DHYBvADIDj_Mq';

const kPrimary = Color(0xFF30b9b2);
const kPrimaryLight = Color(0xFF40F3EA);
const kSecondary = Color(0xffffa44f);
const kSecondaryLight = Color(0xFFffe5db);
const kTertiary = Color(0xff0078a6);
const kGray = Color(0xff83829A);
const kGrayLight = Color(0xffC1C0C8);
const kLightWhite = Color(0xffFAFAFC);
const kWhite = Color(0xfffFFFFF);
const kDark = Color(0xff000000);
const kRed = Color(0xffe81e4d);
const kOffWhite = Color(0xffF3F4F8);

double height = 825.h;
double width = 375.w;

const String appBaseUrl = "http://192.168.77.20:8000";

final List<String> verificationReasons = [
  'Real-time Updates: Get instant notifications about your order status.',
  'Direct Communication: A verified number ensure seamless communication.',
  'Enhanced Security: Protect your account and confirm orders securely.',
  'Effortless Rescheduling: Easily address issues with a quick call.',
  'Exclusive Offers: Stay in the loop for special deals and promotions.'
];

final List<String> reasonToAddress = [
  'Ensures that food orders are delivered accurately to the customers location.',
  'Allows users to check if the delivery service is available in their area.',
  'Provides a personalized experience by showing nearby restaurant, estimated delivery times, and special offers.',
  'Streamlines the checkout process by saving addresses for quicker order placement.',
  'Enables management of multiple address (e.g., home, work) for easy switching.'
];

List<String> orderList = [
  "Pending",
  "Preparing",
  "Delivering",
  "Delivered",
  "Cancelled",
];

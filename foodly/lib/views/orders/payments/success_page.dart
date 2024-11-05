import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/common/reusable_text.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/views/entrypoint.dart';
import 'package:get/get.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage(
      {super.key,
      required this.orderId,
      required this.resId,
      required this.amount});

  final String orderId;
  final String resId;
  final double amount;

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
              child: GestureDetector(
                onTap: () {
                  Get.offAll(() => MainScreen());
                },
                child: const Icon(
                  AntDesign.closecircleo,
                  color: kGrayLight,
                ),
              ),
            )
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/restaurant_bk.png"),
                  fit: BoxFit.cover)),
          child: Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: height * 0.3.h,
                  width: width - 40,
                  decoration: BoxDecoration(
                    color: kOffWhite,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        ReusableText(
                            text: "Payment Successful",
                            style: appStyle(13, kGray, FontWeight.normal)),
                        const Divider(
                          thickness: 2,
                          color: kGray,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Table(
                            children: [
                              TableRow(children: [
                                ReusableText(
                                    text: "Order ID",
                                    style:
                                        appStyle(11, kGray, FontWeight.normal)),
                                ReusableText(
                                    text: widget.orderId,
                                    style:
                                        appStyle(11, kGray, FontWeight.normal)),
                              ]),
                              TableRow(children: [
                                ReusableText(
                                    text: "Payment ID",
                                    style:
                                        appStyle(11, kGray, FontWeight.normal)),
                                ReusableText(
                                    text: "113456",
                                    style:
                                        appStyle(11, kGray, FontWeight.normal)),
                              ]),
                              TableRow(children: [
                                ReusableText(
                                    text: "Payment Method",
                                    style:
                                        appStyle(11, kGray, FontWeight.normal)),
                                ReusableText(
                                    text: "Paypal",
                                    style:
                                        appStyle(11, kGray, FontWeight.normal)),
                              ]),
                              TableRow(children: [
                                ReusableText(
                                    text: "Amount",
                                    style:
                                        appStyle(11, kGray, FontWeight.normal)),
                                ReusableText(
                                    text: "\$ ${widget.amount}",
                                    //"${orderController.order!.grandTotal}",
                                    style:
                                        appStyle(11, kGray, FontWeight.normal)),
                              ]),
                              TableRow(children: [
                                ReusableText(
                                    text: "Restaurant",
                                    style:
                                        appStyle(11, kGray, FontWeight.normal)),
                                ReusableText(
                                    text: widget.resId,
                                    style:
                                        appStyle(11, kGray, FontWeight.normal)),
                              ]),
                              TableRow(children: [
                                ReusableText(
                                    text: "Date",
                                    style:
                                        appStyle(11, kGray, FontWeight.normal)),
                                ReusableText(
                                    text: DateTime.now()
                                        .toString()
                                        .substring(0, 10),
                                    style:
                                        appStyle(11, kGray, FontWeight.normal)),
                              ]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

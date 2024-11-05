import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/common/reusable_text.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/controller/order_controller.dart';
import 'package:foodly/views/entrypoint.dart';
import 'package:get/get.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            orderController.setPaymentUrl = '';
            Get.off(() => MainScreen());
          },
          child: Icon(AntDesign.clockcircleo, color: Colors.black),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/No.png",
            color: Colors.red,
          ),
          ReusableText(
              text: "Payment Failed",
              style: appStyle(28, kDark, FontWeight.bold))
        ],
      ),
    );
  }
}

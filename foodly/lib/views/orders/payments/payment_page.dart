import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly/views/orders/payments/payment_result.dart';
import 'package:get/get.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage(
      {super.key,
      required this.orderId,
      required this.resId,
      required this.amount});
  final String orderId;
  final String resId;
  final double amount;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Method"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: TextButton(
              onPressed: () {
                Get.to(() => PaypalPayment(
                      orderId: widget.orderId,
                      resId: widget.resId,
                      amount: widget.amount,
                      currency: 'usd',
                    ));
              },
              style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.resolveWith((state) => Colors.blue)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    "https://www.paypalobjects.com/marketing/web23/us/en/ppe/mobile-apps/card-wrapped-content-section-01_size-all.png",
                    height: 40.h,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  const Text(
                    "Pay with Paypal",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

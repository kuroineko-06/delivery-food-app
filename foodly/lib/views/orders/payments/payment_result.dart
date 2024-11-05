import 'package:flutter/material.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/views/orders/payments/error_page.dart';
import 'package:foodly/views/orders/payments/success_page.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaypalPayment extends StatefulWidget {
  final double amount;
  final String currency;
  final String orderId;
  final String resId;

  const PaypalPayment(
      {Key? key,
      required this.amount,
      required this.currency,
      required this.orderId,
      required this.resId})
      : super(key: key);

  @override
  State<PaypalPayment> createState() => _PaypalPaymentState();
}

class _PaypalPaymentState extends State<PaypalPayment> {
  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print(progress);
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains('http://return_url/?status=success')) {
              print('return url on success');
              Get.snackbar(
                  "Placed order successfully", "Enjoy your awesome experience",
                  colorText: kLightWhite,
                  backgroundColor: kPrimary,
                  icon: const Icon(Icons.done_outlined));
              Get.to(() => SuccessPage(
                    amount: widget.amount,
                    orderId: widget.orderId,
                    resId: widget.resId,
                  ));
            }
            if (request.url.contains('http://cancel_url')) {
              Navigator.pop(context);
              Get.to(() => const ErrorPage());
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://1589-2402-9d80-24c-9e1d-641e-7135-f2d2-e637.ngrok-free.app/api/payment/createpayment?amount=${widget.amount}&currency=${widget.currency}'));
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: WebViewWidget(
          controller: controller,
        ));
  }
}

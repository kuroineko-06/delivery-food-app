import 'package:flutter/material.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/models/api_error.dart';
import 'package:foodly/models/order_request.dart';
import 'package:foodly/models/order_response.dart';
import 'package:foodly/models/payment_request.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class OrderController extends GetxController {
  final box = GetStorage();

  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  set setLoading(bool newState) {
    _isLoading.value = newState;
  }

  RxString _paymentUrl = "".obs;
  String get paymentUrl => _paymentUrl.value;

  set setPaymentUrl(String newState) {
    _paymentUrl.value = newState;
  }

  String orderId = '';
  String get getOrderId => orderId;
  set setOrderId(String value) {
    orderId = value;
  }

  OrderRequest? order;

  void createOrder(String data, OrderRequest item) async {
    setLoading = true;
    String accessToken = box.read("token");

    Uri url = Uri.parse("$appBaseUrl/api/orders");

    Map<String, String> headers = {
      'Content-Type': "application/json",
      "Authorization": "Bearer $accessToken"
    };

    try {
      var response = await http.post(url, headers: headers, body: data);
      print("Status Code: ${response.statusCode}");
      if (response.statusCode == 200) {
        OrderResponse data = OrderResponseFromJson(response.body);
        String orderId = data.orderId;
        Payment payment = Payment(userId: item.userId, cartItems: [
          CartItem(
              name: item.orderItems[0].foodId,
              id: orderId,
              price: item.grandTotal.toStringAsFixed(2),
              quantity: 1,
              restaurantId: item.restaurantId),
        ]);

        String paymentData = paymentToJson(payment);
        print("aaaaaaaaaaaaaaaaaaaaaa: ${paymentData}");

        //paymentFunction(paymentData);

        setLoading = false;
      } else {
        var error = apiErrorFromJson(response.body);
        Get.snackbar("Failed to placed order ", error.message,
            colorText: kLightWhite,
            backgroundColor: kRed,
            icon: const Icon(Icons.error_outline));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // void paymentFunction(String payment) async {
  //   setLoading = true;

  //   var url = Uri.parse(
  //       "https://409c-171-241-18-71.ngrok-free.app/api/payment/createpayment");

  //   try {
  //     var response = await http.post(url,
  //         headers: {
  //           'Content-Type': "application/json",
  //         },
  //         body: payment);

  //     print("Res of payment: ${response.body}");

  //     if (response.statusCode == 200) {
  //       var urlData = jsonDecode(response.body);
  //       setPaymentUrl = urlData['url'];
  //       setLoading = false;
  //     }
  //   } catch (e) {
  //     setLoading = false;
  //     debugPrint("Error from payment: ${e.toString()}");
  //   } finally {
  //     setLoading = false;
  //   }
  // }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_foodly/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_foodly/models/succes_model.dart';
import 'package:restaurant_foodly/views/auth/login_page.dart';

class RegisterController extends GetxController {
  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  set isLoading(bool value) => _isLoading.value = value;

  void registerFunction(String data) async {
    isLoading = true;

    var url = Uri.parse("$appBaseUrl/register");

    Map<String, String> headers = {"Content-Type": "application/json"};

    try {
      var response = await http.post(url, body: data, headers: headers);
      print(response);
      print(response.statusCode);

      if (response.statusCode == 201) {
        var data = successResponseFromJson(response.body);

        Get.snackbar("Success", data.message,
            backgroundColor: kPrimary,
            colorText: kLightWhite,
            icon: const Icon(Icons.done));
        isLoading = false;
        Get.to(() => const LoginPage(),
            transition: kTransition, duration: kDuration);
      } else {
        var data = successResponseFromJson(response.body);
        Get.snackbar("Error", data.message,
            backgroundColor: kRed,
            colorText: kLightWhite,
            icon: const Icon(Icons.error_outline));
        isLoading = false;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: kRed,
          colorText: kLightWhite,
          icon: const Icon(Icons.error_outline));
    }
  }
}

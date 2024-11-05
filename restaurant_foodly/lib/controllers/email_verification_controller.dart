import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:restaurant_foodly/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_foodly/models/login_response.dart';
import 'package:restaurant_foodly/models/succes_model.dart';
import 'package:restaurant_foodly/views/auth/login_page.dart';
import 'package:restaurant_foodly/views/auth/restaurant_registration.dart';

class EmailVerificationController extends GetxController {
  final box = GetStorage();
  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  set isLoading(bool value) => _isLoading.value = value;

  RxString _code = ''.obs;
  String get code => _code.value;

  void setCode(String value) => _code.value = value;

  void loginFunction(String data) async {}

  void verifyEmail(String code) async {
    isLoading = true;
    String accessToken = box.read('accessToken');

    var url = Uri.parse("$appBaseUrl/api/users/verify/$code");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    try {
      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        LoginResponse data = loginResponseFromJson(response.body);

        box.write(data.id, json.encode(data));
        box.write('accessToken', data.userToken);
        box.write('e-verification', data.verification);

        Get.snackbar("Successfully verified your account",
            "Enjoy your awesome experience",
            colorText: kLightWhite,
            backgroundColor: kPrimary,
            icon: const Icon(Icons.done));

        if (data.userType == "Client") {
          Get.offAll(() => const RestaurantRegistration(),
              transition: kTransition, duration: kDuration);
        } else {
          Get.offAll(() => const LoginPage(),
              transition: kTransition, duration: kDuration);
        }

        isLoading = false;
      } else {
        var data = successResponseFromJson(response.body);
        Get.snackbar("Error", data.message,
            colorText: kLightWhite,
            backgroundColor: kRed,
            icon: const Icon(Icons.error_outline));
        isLoading = false;
      }
    } catch (e) {
      Get.snackbar("Failed to verify account", e.toString(),
          colorText: kLightWhite,
          backgroundColor: kRed,
          icon: const Icon(Icons.error_outline));
      isLoading = false;
    }
  }
}

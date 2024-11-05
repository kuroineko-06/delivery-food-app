// ignore_for_file: unnecessary_null_comparison

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:restaurant_foodly/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_foodly/models/api_error.dart';
import 'package:restaurant_foodly/models/restarant_response.dart';
import 'package:restaurant_foodly/models/succes_model.dart';
import 'package:restaurant_foodly/views/auth/login_page.dart';

class RestaurantController extends GetxController {
  final box = GetStorage();
  RestaurantResponse? restaurant;

  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  set isLoading(bool value) => _isLoading.value = value;

  void restaurantRegistration(String data) async {
    isLoading = true;

    Uri url = Uri.parse("$appBaseUrl/api/restaurant");
    String accessToken = box.read("accessToken");

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    try {
      var response = await http.post(url, headers: headers, body: data);

      if (response.statusCode == 201) {
        var data = successResponseFromJson(response.body);
        isLoading = false;
        Get.snackbar(data.message,
            "Restaurant Registered. Continue to login the service",
            colorText: kLightWhite,
            backgroundColor: kPrimary,
            icon: const Icon(Icons.done));
        Get.offAll(() => const LoginPage(),
            transition: kTransition, duration: kDuration);
      } else {
        var data = apiErrorFromJson(response.body);
        Get.snackbar(
            data.message, "Failed to register restaurant, please try again",
            colorText: kLightWhite,
            backgroundColor: kRed,
            icon: const Icon(Icons.error_outline));
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
      Get.snackbar(
          e.toString(), "Failed to register restaurant, please try again",
          colorText: kLightWhite,
          backgroundColor: kRed,
          icon: const Icon(Icons.error_outline));
    }
  }

  int generateId() {
    int min = 0;
    int max = 10000;

    return min + Random().nextInt(max - min);
  }

  RestaurantResponse? getRestaurantData() {
    String id = box.read("restaurantId");

    if (id != null) {
      String data = box.read(id);
      restaurant = restaurantResponseFromJson(data);
    }
    return restaurant;
  }
}

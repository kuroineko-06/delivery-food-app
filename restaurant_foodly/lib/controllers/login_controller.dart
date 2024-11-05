import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:restaurant_foodly/constants/constants.dart';
import 'package:restaurant_foodly/controllers/restaurant_controller.dart';
import 'package:restaurant_foodly/main.dart';
import 'package:restaurant_foodly/models/api_error.dart';
import 'package:restaurant_foodly/models/login_response.dart';
import 'package:restaurant_foodly/models/restarant_response.dart';
import 'package:restaurant_foodly/models/succes_model.dart';
import 'package:restaurant_foodly/views/auth/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_foodly/views/auth/restaurant_registration.dart';
import 'package:restaurant_foodly/views/auth/verification_page.dart';
import 'package:restaurant_foodly/views/auth/waiting_page.dart';
import 'package:restaurant_foodly/views/home/home_page.dart';

class LoginController extends GetxController {
  final box = GetStorage();
  RestaurantResponse? restaurant;
  final controller = Get.put(RestaurantController());

  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  set isLoading(bool value) => _isLoading.value = value;

  void loginFunction(String data) async {
    isLoading = true;

    var url = Uri.parse("$appBaseUrl/login");

    Map<String, String> headers = {"Content-Type": "application/json"};

    try {
      var response = await http.post(url, body: data, headers: headers);

      if (response.statusCode == 200) {
        var data = loginResponseFromJson(response.body);

        box.write(data.id, json.encode(data));
        box.write('userId', data.id);
        box.write('accessToken', data.userToken);
        box.write('e-verification', data.verification);

        if (data.verification == false) {
          Get.snackbar("Verification", "Please verification your email",
              backgroundColor: kPrimary,
              colorText: kLightWhite,
              icon: const Icon(Icons.done));

          Get.offAll(() => const VerificationPage(),
              transition: kTransition, duration: kDuration);
        } else if (data.verification == true && data.userType == 'Client') {
          defaultHome = const LoginPage();
          Get.offAll(() => const RestaurantRegistration(),
              transition: kTransition, duration: kDuration);
        } else if (data.verification == true && data.userType == 'Vendor') {
          getVendorInfo(data.userToken);
        }

        isLoading = false;
      } else {
        var data = successResponseFromJson(response.body);
        Get.snackbar("Login Failed", data.message,
            backgroundColor: kRed,
            colorText: kLightWhite,
            icon: const Icon(Icons.error_outline));
        isLoading = false;
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar("Error", e.toString(),
          backgroundColor: kRed,
          colorText: kLightWhite,
          icon: const Icon(Icons.error_outline));
    }
  }

  void logout() async {
    box.erase();
    defaultHome = const LoginPage();
    Get.offAll(() => defaultHome,
        transition: Transition.fadeIn,
        duration: const Duration(microseconds: 600));
    Get.snackbar("Done!", "You log out succefully",
        colorText: kLightWhite,
        backgroundColor: kPrimary,
        icon: const Icon(Icons.done));
  }

  LoginResponse? getUserData() {
    String? id = box.read("userId");

    if (id != null) {
      return loginResponseFromJson(box.read(id));
    } else {
      return null;
    }
  }

  void getVendorInfo(String accessToken) async {
    isLoading = true;

    var url = Uri.parse("$appBaseUrl/api/restaurant/owner/profile");

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    try {
      var response = await http.get(url, headers: headers);

      print("aaaaaaaa: ${response.statusCode}");
      print("aaaaaaaa: ${response.body}");

      if (response.statusCode == 200) {
        RestaurantResponse restaurantData =
            restaurantResponseFromJson(response.body);
        restaurant = restaurantData;
        controller.restaurant = restaurantData;
        box.write("restaurantId", restaurantData.id);
        box.write("verification", restaurantData.verification);

        String data = restaurantResponseToJson(restaurantData);

        box.write(restaurantData.id, data);

        if (restaurantData.verification != "Verified") {
          Get.offAll(() => const WaitingPage(),
              transition: kTransition, duration: kDuration);
        } else {
          defaultHome = const HomePage();
          Get.offAll(() => const HomePage(),
              transition: kTransition, duration: kDuration);
        }

        isLoading = false;
      } else {
        var data = apiErrorFromJson(response.body);
        Get.snackbar("Opps! Failed", data.message,
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

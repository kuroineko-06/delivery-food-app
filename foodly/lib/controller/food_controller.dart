import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/models/additive_obs.dart';
import 'package:foodly/models/api_error.dart';
import 'package:foodly/models/food.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FoodController extends GetxController {
  RxInt currentPage = 0.obs;
  bool initialCheckValue = false;
  var additiveList = <AdditiveObs>[].obs;

  void changePage(int index) {
    currentPage.value = index;
  }

  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  set setLoading(bool value) {
    _isLoading.value = value;
  }

  RxInt count = 1.obs;

  void increment() {
    count.value++;
  }

  void decrement() {
    if (count.value > 1) {
      count.value--;
    } else {
      Get.snackbar("Error", "Out of foods in stock",
          colorText: kLightWhite,
          backgroundColor: kRed,
          icon: const Icon(Icons.error_outline));
      return;
    }
  }

  void updateCountInStock(int total, String id) async {
    setLoading = true;

    var url = Uri.parse("$appBaseUrl/api/foods/$id");

    try {
      // Convert the total to a JSON object
      var body = jsonEncode({'total': total});

      var response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json', // Set content type to JSON
        },
        body: body,
      );

      print("nnnnnnnnnn: ${response.body}");
      if (response.statusCode == 200) {
        var data = foodModelFromJson(response.body);
        setLoading = false;

        print("data response: ${data}");
      } else {
        var error = apiErrorFromJson(response.body);
        print("Error: ${error.message}");
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setLoading = false;
    }
  }

  void loadAdditves(List<Additive> additives) {
    additiveList.clear();

    for (var additiveInfo in additives) {
      var additive = AdditiveObs(
          id: additiveInfo.id,
          title: additiveInfo.title,
          price: additiveInfo.price,
          checked: initialCheckValue);

      if (additives.length == additiveList.length) {
      } else {
        additiveList.add(additive);
      }
    }
  }

  List<String> getCartAdditive() {
    List<String> additives = [];

    for (var additive in additiveList) {
      if (additive.isChecked.value && !additives.contains(additive.title)) {
        additives.add(additive.title);
      } else if (!additive.isChecked.value &&
          additives.contains(additive.title)) {
        additives.remove(additive.title);
      }
    }
    return additives;
  }

  RxInt _totalPrice = 0.obs;

  int get additivePrice => _totalPrice.value;

  set setTotalPrice(int newPrice) {
    _totalPrice.value = newPrice;
  }

  int getTotalPrice() {
    int totalPrice = 0;

    for (var additive in additiveList) {
      if (additive.isChecked.value) {
        totalPrice += int.tryParse(additive.price) ?? 0;
      }
    }

    setTotalPrice = totalPrice;
    return totalPrice;
  }
}

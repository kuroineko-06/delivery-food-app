// ignore_for_file: prefer_final_fields

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:restaurant_foodly/constants/constants.dart';
import 'package:restaurant_foodly/models/addittives.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_foodly/models/api_error.dart';
import 'package:restaurant_foodly/models/succes_model.dart';
import 'package:restaurant_foodly/views/home/home_page.dart';

class FoodController extends GetxController {
  final box = GetStorage();
  String _category = "";
  String get category => _category;

  set setCategory(String newValue) {
    _category = newValue;
  }

  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  set isLoading(bool value) => _isLoading.value = value;

  RxInt _countStock = 0.obs;
  int get countStock => _countStock.value;

  set setCountStock(int value) {
    _countStock.value = value;
  }

  RxList<String> _types = <String>[].obs;
  RxList<String> get types => _types;

  set setTypes(String newValue) {
    _types.add(newValue);
  }

  int generateId() {
    int min = 0;
    int max = 10000;

    final _random = Random();
    return min + _random.nextInt(max - min);
  }

  RxList<Addittives> _addittiveList = <Addittives>[].obs;
  List<Addittives> get addittiveList => _addittiveList;

  set addAddittives(Addittives newValue) {
    _addittiveList.add(newValue);
  }

  RxList<String> _tag = <String>[].obs;
  RxList<String> get tags => _tag;

  set setTags(String newValue) {
    _tag.add(newValue);
  }

  void clearAddittiveList() {
    _addittiveList.clear();
  }

  void addFoodFunction(String data) async {
    String accessToken = box.read("accessToken");
    isLoading = true;

    Uri url = Uri.parse("$appBaseUrl/api/foods");

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    try {
      var response = await http.post(url, headers: headers, body: data);

      print("respone: ${response.statusCode}");
      print("respone: ${response.body}");

      if (response.statusCode == 201) {
        var data = successResponseFromJson(response.body);
        isLoading = false;

        Get.snackbar("Success", data.message,
            backgroundColor: kPrimary,
            colorText: kLightWhite,
            icon: const Icon(Icons.error_outline));
        Get.to(() => const HomePage(),
            transition: kTransition, duration: kDuration);
      } else {
        isLoading = false;
        var data = apiErrorFromJson(response.body);
        Get.snackbar("Failed to upload", data.message,
            backgroundColor: kRed,
            colorText: kLightWhite,
            icon: const Icon(Icons.error_outline));
      }
    } catch (e) {
      isLoading = false;
      var data = apiErrorFromJson(e.toString());

      Get.snackbar("Error", data.message,
          backgroundColor: kRed,
          colorText: kLightWhite,
          icon: const Icon(Icons.error_outline));
    }
  }
}

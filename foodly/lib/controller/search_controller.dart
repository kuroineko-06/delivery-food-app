import 'package:flutter/material.dart';
import 'package:foodly/constants/constants.dart';
// import 'package:foodly/models/api_error.dart';
import 'package:foodly/models/food.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SearchFoodsController extends GetxController {
  RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set setLoading(bool value) {
    _isLoading.value = value;
  }

  RxBool _isTriggered = false.obs;

  bool get isTriggered => _isTriggered.value;

  set setTriggered(bool value) {
    _isTriggered.value = value;
  }

  List<FoodModel>? searchResults;

  void searchFoods(String key) async {
    setLoading = true;
    Uri url = Uri.parse("$appBaseUrl/api/foods/search/$key");

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        searchResults = foodModelFromJson(response.body);
        setLoading = false;
      } else {
        setLoading = false;
        // var error = apiErrorFromJson(response.body);
      }
    } catch (e) {
      setLoading = false;
      debugPrint(e.toString());
    }
  }
}

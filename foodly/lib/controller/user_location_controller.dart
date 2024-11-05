import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodly/constants/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class UserLocationController extends GetxController {
  RxBool _isDefault = false.obs;
  bool get isDefault => _isDefault.value;
  set setIsDefault(bool value) {
    _isDefault.value = value;
  }

  RxInt _tabIndex = 0.obs;
  int get tabIndex => _tabIndex.value;

  set setTabIndex(int value) {
    _tabIndex.value = value;
  }

  LatLng posistion = const LatLng(0, 0);

  void setPosistion(LatLng value) {
    value = posistion;
    update();
  }

  RxString _address = ''.obs;
  String get address => _address.value;

  set setAddress(String value) {
    _address.value = value;
  }

  RxString _distance = ''.obs;
  String get distance => _distance.value;

  set setDistance(String value) {
    _distance.value = value;
  }

  RxString _time = ''.obs;
  String get time => _time.value;

  set setTime(String value) {
    _time.value = value;
  }

  RxString _address1 = ''.obs;
  String get address1 => _address1.value;

  set setAddress1(String value) {
    _address1.value = value;
  }

  RxString _postalCode = ''.obs;
  String get postalCode => _postalCode.value;

  set setPostalCode(String value) {
    _postalCode.value = value;
  }

  void getUserAddress(LatLng posistion) async {
    final url = Uri.parse(
        "https://maps.gomaps.pro/maps/api/geocode/json?latlng=${posistion.latitude},${posistion.longitude}&key=$googleApiKey");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      final address = responseBody['results'][2]['formatted_address'];

      setAddress = address;

      final addressComponents =
          responseBody['results'][0]['address_components'];

      for (var component in addressComponents) {
        if (component['types'].contains('postal_code')) {
          setPostalCode = component['long_name'];
        }
      }
    }
  }

  void getDistanceAddress(
      String addressRestaurant, String addressClient) async {
    final url = Uri.parse(
        "https://maps.gomaps.pro/maps/api/distancematrix/json?destinations=$addressClient&origins=$addressRestaurant&key=$googleApiKey");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      final distance =
          responseBody['rows'][0]['elements'][0]['distance']['text'];

      setDistance = distance;

      final time = responseBody['rows'][0]['elements'][0]['duration']['text'];

      setTime = time;
    }
  }

  void addAddress(String data) async {
    final box = GetStorage();
    String accessToken = box.read("token");
    final url = Uri.parse("$appBaseUrl/api/address");

    Map<String, String> headers = {
      'Content-Type': "application/json",
      "Authorization": "Bearer $accessToken"
    };

    try {
      var response = await http.post(url, headers: headers, body: data);
      if (response.statusCode == 201) {
        Get.snackbar(
            "Your address has been added", "Enjoy your awesome experience",
            colorText: kLightWhite,
            backgroundColor: kPrimary,
            icon: const Icon(Icons.check_circle_outline));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void editAddress(String data, String id) async {
    final box = GetStorage();
    String accessToken = box.read("token");
    final url = Uri.parse("$appBaseUrl/api/address/$id");

    Map<String, String> headers = {
      'Content-Type': "application/json",
      "Authorization": "Bearer $accessToken"
    };

    try {
      var response = await http.put(url, headers: headers, body: data);
      if (response.statusCode == 200) {
        Get.snackbar(
            "Address update successfully", "Enjoy your awesome experience",
            colorText: kLightWhite,
            backgroundColor: kPrimary,
            icon: const Icon(Icons.check_circle_outline));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

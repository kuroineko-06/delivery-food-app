import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodly/common/address_verification_sheet.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/controller/user_location_controller.dart';
import 'package:foodly/models/address_response.dart';
import 'package:foodly/models/api_error.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodly/models/hook_models/hook_result.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

FetchHook fetchDefaultAddresses(BuildContext context) {
  final controller = Get.put(UserLocationController());
  final box = GetStorage();
  final addressItem = useState<AddressResponse?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    String accessToken = box.read("token");

    Map<String, String> headers = {
      'Content-Type': "application/json",
      "Authorization": "Bearer $accessToken"
    };
    isLoading.value = true;

    try {
      Uri url = Uri.parse('$appBaseUrl/api/address/default');
      final response = await http.get(url, headers: headers);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = response.body;
        box.write("defaultAddress", true);
        var decoded = jsonDecode(data);
        addressItem.value = AddressResponse.fromJson(decoded);
        controller.setAddress1 = addressItem.value!.addressLine1;
      } else {
        box.write("defaultAddress", false);
        showAddressSheet(context);
        apiError.value = apiErrorFromJson(response.body);
      }
    } catch (e) {
      box.write("defaultAddress", false);
      error.value = Exception(e.toString());
      print('Caught exception: $e');
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return null;
  }, []);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  return FetchHook(
    data: addressItem.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}

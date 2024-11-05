import 'package:foodly/constants/constants.dart';
import 'package:foodly/models/address_response.dart';
import 'package:foodly/models/api_error.dart';
import 'package:foodly/models/hook_models/address_hook.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

FetchAddress fetchAddresses() {
  final box = GetStorage();
  final addressItem = useState<List<AddressResponse>?>(null);
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
      Uri url = Uri.parse('$appBaseUrl/api/address/all');
      final response = await http.get(url, headers: headers);
      print(response.statusCode);
      if (response.statusCode == 200) {
        addressItem.value = addressResponseFromJson(response.body);
      } else {
        apiError.value = apiErrorFromJson(response.body);
      }
    } catch (e) {
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

  return FetchAddress(
    data: addressItem.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}

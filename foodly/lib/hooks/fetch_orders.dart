import 'package:foodly/constants/constants.dart';
import 'package:foodly/models/api_error.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodly/models/client_order.dart';
import 'package:foodly/models/hook_models/hook_result.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

FetchHook useFetchOrders(String orderStatus, String paymentStatus) {
  final box = GetStorage();
  final order = useState<List<ClientOrders>>([]);
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
      Uri url = Uri.parse(
          '$appBaseUrl/api/orders?orderStatus=$orderStatus&paymentStatus=$paymentStatus');
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        order.value = clientOrdersFromJson(response.body);
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

  return FetchHook(
    data: order.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}

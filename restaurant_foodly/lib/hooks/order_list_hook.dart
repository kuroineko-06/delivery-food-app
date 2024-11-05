import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_storage/get_storage.dart';
import 'package:restaurant_foodly/constants/constants.dart';
import 'package:restaurant_foodly/models/api_error.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_foodly/models/hook_model/order_results.dart';
import 'package:restaurant_foodly/models/order_model.dart';

FetchOrders fetchOrders(String status) {
  final box = GetStorage();
  final foodList = useState<List<OrderModel>?>(null);
  final isLoading = useState<bool>(false);
  final isError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    String id = box.read("restaurantId");
    String accessToken = box.read("accessToken");

    isLoading.value = true;

    try {
      final url = Uri.parse("$appBaseUrl/api/orders/rest-orders/$id/$status");

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      };
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        foodList.value = orderModelFromJson(response.body);

        isLoading.value = false;
        isError.value = null;
      } else {
        isLoading.value = false;
        isError.value = apiErrorFromJson(response.body);
      }
    } catch (e) {
      isLoading.value = false;
      isError.value = apiErrorFromJson(e.toString());
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

  return FetchOrders(
      data: foodList.value,
      isLoading: isLoading.value,
      error: isError.value,
      refetch: refetch);
}

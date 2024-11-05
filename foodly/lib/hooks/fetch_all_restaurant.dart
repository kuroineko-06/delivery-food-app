import 'package:foodly/constants/constants.dart';
import 'package:foodly/models/api_error.dart';
import 'package:foodly/models/hook_models/hook_result.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodly/models/restaurant.dart';
import 'package:http/http.dart' as http;

FetchHook useFetchAllRestaurants() {
  final restaurantItems = useState<List<RestaurantModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url = Uri.parse('$appBaseUrl/api/restaurant/all');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        restaurantItems.value = restaurantModelFromJson(response.body);
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
    data: restaurantItems.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}

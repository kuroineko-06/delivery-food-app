import 'package:foodly/constants/constants.dart';
import 'package:foodly/controller/category_controller.dart';
import 'package:foodly/models/api_error.dart';
import 'package:foodly/models/food.dart';
import 'package:foodly/models/hook_models/foods_hook.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

FetchFoods useFetchFoodByCategory(String code) {
  final controller = Get.put(CategoryController());
  final foodItems = useState<List<FoodModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url =
          Uri.parse('$appBaseUrl/api/foods/${controller.categoryValue}/$code');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        foodItems.value = foodModelFromJson(response.body);
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
    Future.delayed(const Duration(seconds: 3));
    fetchData();
    return null;
  }, []);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  return FetchFoods(
    data: foodItems.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}

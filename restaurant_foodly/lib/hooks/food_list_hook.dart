import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_storage/get_storage.dart';
import 'package:restaurant_foodly/constants/constants.dart';
import 'package:restaurant_foodly/models/api_error.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_foodly/models/food_model.dart';
import 'package:restaurant_foodly/models/hook_model/food_list_results.dart';

FetchFoods fetchFoods() {
  final box = GetStorage();
  final foodList = useState<List<FoodModel>?>(null);
  final isLoading = useState<bool>(false);
  final isError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    String id = box.read("restaurantId");
    isLoading.value = true;

    try {
      final url = Uri.parse("$appBaseUrl/api/foods/restaurant-foods/$id");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        foodList.value = foodModelFromJson(response.body);

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

  return FetchFoods(
      data: foodList.value,
      isLoading: isLoading.value,
      error: isError.value,
      refetch: refetch);
}

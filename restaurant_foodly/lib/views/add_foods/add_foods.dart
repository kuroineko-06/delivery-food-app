import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_foodly/common/app_style.dart';
import 'package:restaurant_foodly/common/background_container.dart';
import 'package:restaurant_foodly/common/reusable_text.dart';
import 'package:restaurant_foodly/constants/constants.dart';
import 'package:restaurant_foodly/controllers/food_controller.dart';
import 'package:restaurant_foodly/controllers/restaurant_controller.dart';
import 'package:restaurant_foodly/controllers/uploader_controller.dart';
import 'package:restaurant_foodly/models/add_food_model.dart';
import 'package:restaurant_foodly/views/add_foods/widget/additives_info.dart';
import 'package:restaurant_foodly/views/add_foods/widget/all_categories.dart';
import 'package:restaurant_foodly/views/add_foods/widget/food_info.dart';
import 'package:restaurant_foodly/views/add_foods/widget/upload_image.dart';

class AddFoods extends StatefulWidget {
  const AddFoods({super.key});

  @override
  State<AddFoods> createState() => _AddFoodsState();
}

class _AddFoodsState extends State<AddFoods> {
  final PageController _pageController = PageController();
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController preparation = TextEditingController();
  final TextEditingController types = TextEditingController();
  final TextEditingController additivesPrice = TextEditingController();
  final TextEditingController additivesTitle = TextEditingController();
  final TextEditingController countInStock = TextEditingController();

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    preparation.dispose();
    price.dispose();
    types.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FoodController());
    final images = Get.put(UploaderController());
    final restaurant = Get.put(RestaurantController());

    return Scaffold(
      backgroundColor: kSecondary,
      appBar: AppBar(
          backgroundColor: kSecondary,
          centerTitle: false,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusableText(
                  text: "Wellcom to Restaurant Panel",
                  style: appStyle(14, kLightWhite, FontWeight.w600)),
              ReusableText(
                  text: "Fill all the required info to add food items",
                  style: appStyle(12, kLightWhite, FontWeight.normal)),
            ],
          )),
      body: BackgroundContainer(
          child: ListView(
        children: [
          SizedBox(
            width: width,
            height: height,
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              pageSnapping: false,
              children: [
                ChooseCategory(
                  next: () {
                    _pageController.nextPage(
                        duration: const Duration(microseconds: 500),
                        curve: Curves.easeIn);
                  },
                ),
                ImageUpload(
                  back: () {
                    _pageController.previousPage(
                        duration: const Duration(microseconds: 500),
                        curve: Curves.easeIn);
                  },
                  next: () {
                    _pageController.nextPage(
                        duration: const Duration(microseconds: 500),
                        curve: Curves.easeIn);
                  },
                ),
                FoodInfo(
                  back: () {
                    _pageController.previousPage(
                        duration: const Duration(microseconds: 500),
                        curve: Curves.easeIn);
                  },
                  next: () {
                    _pageController.nextPage(
                        duration: const Duration(microseconds: 500),
                        curve: Curves.easeIn);
                  },
                  title: title,
                  description: description,
                  price: price,
                  preparation: preparation,
                  types: types,
                ),
                AdditivesInfo(
                  addttivesPrice: additivesPrice,
                  addttivesTitle: additivesTitle,
                  countInStock: countInStock,
                  back: () {
                    _pageController.previousPage(
                        duration: const Duration(microseconds: 500),
                        curve: Curves.easeIn);
                  },
                  submit: () {
                    if (title.text.isEmpty ||
                        description.text.isEmpty ||
                        price.text.isEmpty ||
                        preparation.text.isEmpty) {
                      Get.snackbar("You need fill all the field",
                          "All fields are required to upload food items to the app",
                          colorText: kLightWhite,
                          backgroundColor: kPrimary,
                          snackPosition: SnackPosition.TOP);
                    } else {
                      print(
                          "count in stock data: ${int.parse(countInStock.text)}");
                      AddFoodModel foodItem = AddFoodModel(
                          title: title.text,
                          foodTags: controller.tags,
                          foodType: controller.types,
                          code: restaurant.restaurant!.code,
                          category: controller.category,
                          time: preparation.text,
                          isAvailable: true,
                          restaurant: restaurant.restaurant!.id,
                          description: description.text,
                          price: double.parse(price.text),
                          additives: controller.addittiveList,
                          countInStock: int.parse(countInStock.text),
                          imageUrl: images.images);

                      String data = addFoodModelToJson(foodItem);
                      print("add food data: ${data}");
                      controller.addFoodFunction(data);
                      images.resetList();
                      controller.addittiveList.clear();
                      controller.tags.clear();
                      controller.types.clear();
                    }
                  },
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}

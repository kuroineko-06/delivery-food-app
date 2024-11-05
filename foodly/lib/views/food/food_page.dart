import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:foodly/common/address_verification_sheet.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/common/custom_button.dart';
import 'package:foodly/common/custom_text_field.dart';
import 'package:foodly/common/reusable_text.dart';
import 'package:foodly/common/verification_reason.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/controller/cart_controller.dart';
import 'package:foodly/controller/food_controller.dart';
import 'package:foodly/controller/login_controller.dart';
import 'package:foodly/hooks/fetch_default_address.dart';
import 'package:foodly/hooks/fetch_restaurants.dart';
import 'package:foodly/models/address_response.dart';
import 'package:foodly/models/cart_request.dart';
import 'package:foodly/models/food.dart';
import 'package:foodly/models/login_response.dart';
import 'package:foodly/models/order_request.dart';
import 'package:foodly/models/restaurant.dart';
import 'package:foodly/views/auth/login_page.dart';
import 'package:foodly/views/orders/order_page.dart';
import 'package:foodly/views/restaurant/restaurant_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FoodPage extends StatefulHookWidget {
  const FoodPage({super.key, required this.food});

  final FoodModel food;

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  final PageController _pageController = PageController();
  final TextEditingController _preferences = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();

    var addressTrigger = box.read("defaultAddress");
    final cartController = Get.put(CartController());
    LoginResponse? user;
    final hookResults = useFetchRestaurants(widget.food.restaurant);

    final data = fetchDefaultAddresses(context);
    AddressResponse? address = data.data;
    final controller = Get.put(FoodController());
    RestaurantModel? restaurant = hookResults.data;

    final loginController = Get.put(LoginController());
    user = loginController.getUserInfo();

    controller.loadAdditves(widget.food.additives);
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30.r),
            ),
            child: Stack(
              children: [
                SizedBox(
                  height: 230.h,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (i) {
                      controller.changePage(i);
                    },
                    itemCount: widget.food.imageUrl.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: width,
                        height: 230.h,
                        color: kLightWhite,
                        child: CachedNetworkImage(
                          imageUrl: widget.food.imageUrl[index],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),

                //Position
                Positioned(
                    bottom: 10,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Obx(
                          () => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                  widget.food.imageUrl.length, (index) {
                                return Container(
                                  margin: EdgeInsets.all(4.h),
                                  width: 10.w,
                                  height: 10.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: controller.currentPage == index
                                        ? kSecondary
                                        : kGrayLight,
                                  ),
                                );
                              })),
                        ))),

                Positioned(
                    top: 40.h,
                    left: 12.w,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Ionicons.chevron_back_circle,
                        color: kPrimary,
                        size: 33,
                      ),
                    )),
                Positioned(
                  bottom: 10,
                  right: 12.w,
                  child: CustomButton(
                    onTap: () {
                      Get.to(() => RestaurantPage(
                            restaurant: hookResults.data,
                            address: address,
                          ));
                    },
                    btnWidth: 120.w,
                    text: "Open Restaurant",
                  ),
                ),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReusableText(
                          text: widget.food.title,
                          style: appStyle(18, kDark, FontWeight.w600)),
                      Obx(
                        () => ReusableText(
                            text:
                                "\$${((widget.food.price + controller.additivePrice) * controller.count.value).toStringAsFixed(2)}",
                            style: appStyle(18, kPrimary, FontWeight.w600)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.food.description,
                      textAlign: TextAlign.start,
                      maxLines: 8,
                      style: appStyle(12, kGray, FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  SizedBox(
                    height: 18.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children:
                          List.generate(widget.food.foodTags.length, (index) {
                        final tag = widget.food.foodTags[index];
                        return Container(
                          margin: EdgeInsets.only(right: 5.w),
                          decoration: BoxDecoration(
                            color: kPrimary,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.r)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.h),
                            child: ReusableText(
                                text: tag,
                                style: appStyle(11, kWhite, FontWeight.w400)),
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    children: [
                      RatingBarIndicator(
                          itemCount: 5,
                          itemSize: 20,
                          rating: widget.food.rating.toDouble(),
                          itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              )),
                      SizedBox(
                        width: 10.w,
                      ),
                      Row(
                        children: [
                          ReusableText(
                              text: "${widget.food.ratingCount} rating count.",
                              style: appStyle(12, kGray, FontWeight.w400)),
                          SizedBox(
                            width: 10.w,
                          ),
                          ReusableText(
                              text:
                                  "Have ${widget.food.countInStock} in stock.",
                              style: appStyle(12, kGray, FontWeight.w400)),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: ReusableText(
                        text: "Additives and Toppings",
                        style: appStyle(18, kDark, FontWeight.w600)),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Obx(
                    () => Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 230, 229, 236),
                        borderRadius: BorderRadius.circular(13.r),
                      ),
                      height: height / 4.5,
                      child: SingleChildScrollView(
                        child: Column(
                            children: List.generate(
                                controller.additiveList.length, (index) {
                          final additives = controller.additiveList[index];
                          return CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                              dense: true,
                              activeColor: kSecondary,
                              value: additives.isChecked.value,
                              tristate: false,
                              title: Padding(
                                padding: EdgeInsets.only(left: 3.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ReusableText(
                                        text: additives.title,
                                        style: appStyle(
                                            14, kDark, FontWeight.w400)),
                                    ReusableText(
                                        text: "\$${additives.price}",
                                        style: appStyle(
                                            11, kPrimary, FontWeight.w600)),
                                  ],
                                ),
                              ),
                              onChanged: (bool? value) {
                                additives.toogleChecked();
                                controller.getTotalPrice();
                                controller.getCartAdditive();
                              });
                        })),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReusableText(
                          text: "Quantity",
                          style: appStyle(18, kDark, FontWeight.w600)),
                      SizedBox(width: 5.w),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.decrement();
                            },
                            child: const Icon(AntDesign.minuscircleo),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Obx(
                                () => ReusableText(
                                    text: "${controller.count.value}",
                                    style:
                                        appStyle(14, kDark, FontWeight.w600)),
                              )),
                          GestureDetector(
                            onTap: () {
                              controller.increment();
                            },
                            child: const Icon(AntDesign.pluscircleo),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: ReusableText(
                        text: "Preferences",
                        style: appStyle(18, kDark, FontWeight.w600)),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding: EdgeInsets.zero,
                    child: Container(
                      width: width,
                      height: 65.h,
                      child: CustomTextWidget(
                        controller: _preferences,
                        hintText: "Add a note with your preferences",
                        maxLines: 2,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    height: 40.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (user == null) {
                              Get.to(() => const LoginPage());
                            } else if (user.phoneVerification == false) {
                              showVerificationSheet(context);
                            } else if (addressTrigger == false) {
                              showAddressSheet(context);
                            } else {
                              double price = (widget.food.price +
                                      controller.additivePrice) *
                                  controller.count.value;

                              OrderItem items = OrderItem(
                                  foodId: widget.food.id,
                                  quantity: controller.count.value,
                                  price: price,
                                  additives: controller.getCartAdditive(),
                                  instructions: _preferences.text);

                              Get.to(
                                  () => OrderPage(
                                        restaurant: restaurant,
                                        foods: widget.food,
                                        items: items,
                                        address: address,
                                      ),
                                  transition: Transition.cupertino,
                                  duration: const Duration(microseconds: 600));
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: width / 2.5,
                            height: 40.h,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20.r)),
                            child: ReusableText(
                                text: "Place Order",
                                style:
                                    appStyle(18, kLightWhite, FontWeight.w600)),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            double price =
                                (widget.food.price + controller.additivePrice) *
                                    controller.count.value;
                            var data = CartRequest(
                                productId: widget.food.id,
                                additives: controller.getCartAdditive(),
                                quantity: controller.count.value,
                                totalPrice: price);
                            String cart = cartRequestToJson(data);

                            cartController.addToCart(cart);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: width / 2.5,
                            height: 40.h,
                            decoration: BoxDecoration(
                                color: kSecondary,
                                borderRadius: BorderRadius.circular(20.r)),
                            child: ReusableText(
                                text: "Add to Cart",
                                style:
                                    appStyle(18, kLightWhite, FontWeight.w600)),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}

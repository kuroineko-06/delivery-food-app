import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/common/custom_button.dart';
import 'package:foodly/common/reusable_text.dart';
import 'package:foodly/common/shimmers/foodlist_shimmer.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/common/custom_container.dart';
import 'package:foodly/controller/login_controller.dart';
import 'package:foodly/hooks/fetch_cart.dart';
import 'package:foodly/models/cart_response.dart';
import 'package:foodly/models/login_response.dart';
import 'package:foodly/views/auth/login_redirect.dart';
import 'package:foodly/views/auth/verification_page.dart';
import 'package:foodly/views/cart/widgets/cart_tile.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartPage extends HookWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchCart();
    final List<CartResponse> cart = hookResults.data ?? [];
    final isLoading = hookResults.isLoading;
    final refetch = hookResults.refetch;

    print("dataaa: ${hookResults.data}");

    final box = GetStorage();
    LoginResponse? user;
    final controller = Get.put(LoginController());
    String? token = box.read('token');

    if (token != null) {
      user = controller.getUserInfo();
    }

    if (token == null) {
      return const LoginRedirect();
    }

    if (user != null && user.verification == false) {
      return const VerificationPage();
    }

    return Scaffold(
        backgroundColor: kPrimary,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kOffWhite,
          centerTitle: true,
          title: ReusableText(
              text: "Cart", style: appStyle(14, kGray, FontWeight.w600)),
        ),
        body: SafeArea(
            child: CustomContainer(
                containerContent: isLoading
                    ? const FoodsListShimmer()
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Column(
                          children: [
                            SizedBox(
                              width: width,
                              height: height * 0.65,
                              child: ListView.builder(
                                itemCount: cart.length,
                                itemBuilder: (context, index) {
                                  var carts = cart[index];
                                  return CartTile(
                                    color: const Color.fromARGB(
                                        255, 236, 236, 238),
                                    cart: carts,
                                    refetch: refetch,
                                  );
                                },
                              ),
                            ),
                            Container(
                              width: width,
                              height: 20.h,
                            ),
                            CustomButton(
                              onTap: () {
                                // Get.to(() => OrderPage(
                                //     foods: foods,
                                //     items: items,
                                //     address: address));
                              },
                              text: "Placed Orders",
                              btnRadius: 10,
                              btnHeight: 45.h,
                              btnWidth: width * 0.7,
                              btnColor: kSecondary,
                            )
                          ],
                        ),
                      ))));
  }
}

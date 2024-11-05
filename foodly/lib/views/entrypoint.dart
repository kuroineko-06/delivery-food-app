// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/controller/tab_index_controller.dart';
import 'package:foodly/hooks/fetch_cart.dart';
import 'package:foodly/hooks/fetch_default_address.dart';
import 'package:foodly/models/cart_response.dart';
import 'package:foodly/views/cart/cart_page.dart';
import 'package:foodly/views/home/home_page.dart';
import 'package:foodly/views/profile/profile_page.dart';
import 'package:foodly/views/search/search_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainScreen extends HookWidget {
  MainScreen({super.key});

  List<Widget> pageList = const [
    HomePage(),
    SearchPage(),
    CartPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchCart();
    final List<CartResponse>? carts = hookResults.data ?? [];

    final box = GetStorage();
    String? token = box.read('token');
    if (token != null) {
      fetchDefaultAddresses(context);
    }

    final controller = Get.put(TabIndexController());

    return Obx(() => Scaffold(
          body: Stack(
            children: [
              pageList[controller.tabIndex],
              Align(
                alignment: Alignment.bottomCenter,
                child: Theme(
                    data: Theme.of(context).copyWith(canvasColor: kPrimary),
                    child: BottomNavigationBar(
                        showSelectedLabels: false,
                        showUnselectedLabels: false,
                        type: BottomNavigationBarType.fixed,
                        unselectedIconTheme:
                            const IconThemeData(color: Colors.black38),
                        selectedIconTheme:
                            const IconThemeData(color: kSecondary),
                        onTap: (value) {
                          controller.setTabIndex = value;
                        },
                        currentIndex: controller.tabIndex,
                        items: [
                          BottomNavigationBarItem(
                              icon: controller.tabIndex == 0
                                  ? const Icon(AntDesign.appstore1)
                                  : const Icon(AntDesign.appstore_o),
                              label: "Home"),
                          const BottomNavigationBarItem(
                              icon: Icon(Icons.search), label: "Search"),
                          BottomNavigationBarItem(
                              icon: Badge(
                                  label: Text(carts!.length.toString()),
                                  child: const Icon(FontAwesome.opencart)),
                              label: "Cart"),
                          BottomNavigationBarItem(
                              icon: controller.tabIndex == 3
                                  ? const Icon(FontAwesome.user_circle)
                                  : const Icon(FontAwesome.user_circle_o),
                              label: "Profile"),
                        ])),
              )
            ],
          ),
        ));
  }
}

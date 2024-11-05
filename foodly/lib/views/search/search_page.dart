import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:foodly/common/custom_text_field.dart';
import 'package:foodly/common/shimmers/foodlist_shimmer.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/common/custom_container.dart';
import 'package:foodly/controller/search_controller.dart';
import 'package:foodly/views/search/loading_widget.dart';
import 'package:foodly/views/search/search_results.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchFoodsController());
    return Obx(
      () => Scaffold(
          backgroundColor: kPrimary,
          appBar: AppBar(
            toolbarHeight: 75.h,
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: CustomTextWidget(
                  controller: _searchController,
                  keyBoardType: TextInputType.text,
                  hintText: "Search For Foods...",
                  suffixIcon: GestureDetector(
                    onTap: () {
                      if (controller.isTriggered == false) {
                        controller.searchFoods(_searchController.text);
                        controller.setTriggered = true;
                      } else {
                        controller.searchResults = null;
                        controller.setTriggered = false;
                        _searchController.clear();
                      }
                    },
                    child: controller.isTriggered == false
                        ? Icon(Ionicons.search_circle,
                            size: 40.h, color: kPrimary)
                        : Icon(Ionicons.close_circle, size: 38.h, color: kRed),
                  )),
            ),
          ),
          body: SafeArea(
              child: CustomContainer(
                  color: Colors.white,
                  containerContent: controller.isLoading
                      ? const FoodsListShimmer()
                      : controller.searchResults == null
                          ? const LoadingWidget()
                          : const SearchResults()))),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly/common/shimmers/categories_shimmer.dart';
import 'package:foodly/hooks/fetch_category.dart';
import 'package:foodly/models/category.dart';

import 'category_widget.dart';

class CategoryList extends HookWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchCategories();
    List<CategoryModel>? categoriesList = hookResult.data;
    final isLoading = hookResult.isLoading;

    return isLoading
        ? const CatergoriesShimmer()
        : Container(
            height: 80.h,
            padding: EdgeInsets.only(left: 12.w, top: 10.h),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(categoriesList!.length, (i) {
                CategoryModel category = categoriesList[i];
                return CategoryWidget(category: category);
              }),
            ),
          );
  }
}

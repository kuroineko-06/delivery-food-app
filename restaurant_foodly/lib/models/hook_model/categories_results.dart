import 'package:flutter/material.dart';
import 'package:restaurant_foodly/models/api_error.dart';
import 'package:restaurant_foodly/models/categories_model.dart';

class FetchCategories {
  final List<Categories>? data;
  final bool isLoading;
  final ApiError? error;
  final VoidCallback refetch;

  FetchCategories(
      {required this.data,
      required this.isLoading,
      required this.error,
      required this.refetch});
}

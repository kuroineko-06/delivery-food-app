import 'package:flutter/material.dart';
import 'package:restaurant_foodly/models/api_error.dart';
import 'package:restaurant_foodly/models/food_model.dart';

class FetchFoods {
  final List<FoodModel>? data;
  final bool isLoading;
  final ApiError? error;
  final VoidCallback refetch;

  FetchFoods(
      {required this.data,
      required this.isLoading,
      required this.error,
      required this.refetch});
}

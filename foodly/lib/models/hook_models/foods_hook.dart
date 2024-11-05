import 'package:flutter/material.dart';
import 'package:foodly/models/food.dart';

class FetchFoods {
  final List<FoodModel>? data;
  final bool isLoading;
  final Exception? error;
  final VoidCallback? refetch;

  FetchFoods(
      {required this.data,
      required this.isLoading,
      required this.error,
      required this.refetch});
}

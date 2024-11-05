import 'package:flutter/material.dart';
import 'package:restaurant_foodly/models/api_error.dart';
import 'package:restaurant_foodly/models/order_model.dart';

class FetchOrders {
  final List<OrderModel>? data;
  final bool isLoading;
  final ApiError? error;
  final VoidCallback refetch;

  FetchOrders(
      {required this.data,
      required this.isLoading,
      required this.error,
      required this.refetch});
}

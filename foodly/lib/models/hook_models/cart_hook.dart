import 'package:flutter/material.dart';
import 'package:foodly/models/cart_response.dart';

class FetchCart {
  final List<CartResponse>? data;
  final bool isLoading;
  final Exception? error;
  final VoidCallback? refetch;

  FetchCart(
      {required this.data,
      required this.isLoading,
      required this.error,
      required this.refetch});
}

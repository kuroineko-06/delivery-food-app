import 'package:flutter/material.dart';
import 'package:foodly/models/address_response.dart';

class FetchAddress {
  final List<AddressResponse>? data;
  final bool isLoading;
  final Exception? error;
  final VoidCallback? refetch;

  FetchAddress(
      {required this.data,
      required this.isLoading,
      required this.error,
      required this.refetch});
}

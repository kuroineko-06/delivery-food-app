import 'package:flutter/material.dart';
import 'package:foodly/models/address_response.dart';
import 'package:foodly/views/profile/widget/address_tile.dart';

class AddressListWidget extends StatelessWidget {
  const AddressListWidget({super.key, required this.addresses});

  final List<AddressResponse> addresses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: addresses.length,
      itemBuilder: (context, index) {
        final address = addresses[index];
        return SizedBox(
          child: AddressTile(address: address),
        );
      },
    );
  }
}

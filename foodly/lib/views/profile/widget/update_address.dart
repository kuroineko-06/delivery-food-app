import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/common/reusable_text.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/controller/user_location_controller.dart';
import 'package:foodly/models/address_response.dart';
import 'package:foodly/views/profile/widget/finsh_page.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class UpdateAddress extends StatefulWidget {
  const UpdateAddress(
      {super.key, required this.deliveryInstructions, required this.address});

  final String deliveryInstructions;
  final AddressResponse address;

  @override
  State<UpdateAddress> createState() => _UpdateAddressState();
}

class _UpdateAddressState extends State<UpdateAddress> {
  LatLng? _selectedPosition;
  GoogleMapController? _mapController;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _postalCode = TextEditingController();

  List<dynamic> _placeList = [];

  List<dynamic> _selectedPlace = [];
  void _onSearchChanged(String searchQuery) async {
    if (searchQuery.isNotEmpty) {
      final url = Uri.parse(
          "https://maps.gomaps.pro/maps/api/place/queryautocomplete/json?input=$searchQuery&key=$googleApiKey");

      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          _placeList = json.decode(response.body)['predictions'];
        });
      }
    } else {
      _placeList = [];
    }
  }

  void _getPlaceDetails(String placeId) async {
    final url = Uri.parse(
        "https://maps.gomaps.pro/maps/api/place/details/json?place_id=$placeId&key=$googleApiKey");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final location = json.decode(response.body);
      final lat = location['result']['geometry']['location']['lat'] as double;
      final lng = location['result']['geometry']['location']['lng'] as double;

      final address = location['result']['formatted_address'];
      String postalCode = "";

      final addressComponents = location['result']['address_components'];

      for (var component in addressComponents) {
        if (component['types'].contains('postal_code')) {
          postalCode = component['long_name'];
          break;
        }
      }

      setState(() {
        _selectedPosition = LatLng(lat, lng);
        _searchController.text = address;
        _postalCode.text = postalCode;
        moveToSelectedPosition();
        _placeList = [];
      });
    } else {}
  }

  void moveToSelectedPosition() {
    if (_selectedPosition != null && _mapController != null) {
      _mapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: _selectedPosition!, zoom: 15)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationController = Get.put(UserLocationController());

    return Scaffold(
      backgroundColor: kOffWhite,
      appBar: AppBar(
        backgroundColor: kOffWhite,
        title: ReusableText(
            text: "Update address",
            style: appStyle(13, kGray, FontWeight.w600)),
        centerTitle: true,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: _searchController.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      Get.to(() => FinshPage(
                            address: widget.address,
                            addL1: _searchController.text,
                            postalCode: _postalCode.text,
                            lat: _selectedPosition!.latitude,
                            deInstruct: widget.deliveryInstructions,
                            lng: _selectedPosition!.longitude,
                          ));
                    },
                    icon: const Icon(Icons.done),
                    color: Colors.green,
                  )
                : const SizedBox.shrink(),
          )
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            initialCameraPosition: CameraPosition(
                target:
                    _selectedPosition ?? const LatLng(21.0186661, 105.8005229),
                zoom: 15),
            markers: _selectedPosition == null
                // ignore: prefer_collection_literals
                ? Set.of([
                    Marker(
                        markerId: const MarkerId("Your Location 1"),
                        draggable: true,
                        position: const LatLng(21.0186661, 105.8005229),
                        onDragEnd: (LatLng position) {
                          locationController.getUserAddress(position);
                          setState(() {
                            _selectedPosition = position;
                            var addresses = locationController.address;
                            _searchController.text = addresses;
                            //_postalCode.text = postalCode;
                            moveToSelectedPosition();

                            _placeList = [];
                          });
                        }),
                  ])
                // ignore: prefer_collection_literals
                : Set.of([
                    Marker(
                        markerId: const MarkerId("Your Location 2"),
                        draggable: true,
                        position: _selectedPosition!,
                        onDragEnd: (LatLng position) {
                          locationController.getUserAddress(position);
                          setState(() {
                            _selectedPosition = position;
                            var addresses = locationController.address;
                            _searchController.text = addresses;
                            //_postalCode.text = postalCode;
                            moveToSelectedPosition();

                            _placeList = [];
                          });
                        }),
                  ]),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                color: kOffWhite,
                child: TextField(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  decoration: const InputDecoration(
                    hintText: "Search for your address ...",
                  ),
                ),
              ),
              _placeList.isEmpty
                  ? const SizedBox.shrink()
                  : Expanded(
                      child: ListView(
                      children: List.generate(_placeList.length, (index) {
                        return Container(
                          color: Colors.white,
                          child: ListTile(
                            visualDensity: VisualDensity.compact,
                            title: Text(
                              _placeList[index]['description'],
                              style: appStyle(14, kGray, FontWeight.w400),
                            ),
                            onTap: () {
                              _getPlaceDetails(_placeList[index]['place_id']);
                              _selectedPlace.add(_placeList[index]);
                            },
                          ),
                        );
                      }),
                    )),
            ],
          )
        ],
      ),
    );
  }
}

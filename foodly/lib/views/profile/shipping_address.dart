import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/common/background_container.dart';
import 'package:foodly/common/custom_button.dart';
import 'package:foodly/common/reusable_text.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/controller/user_location_controller.dart';
import 'package:foodly/models/address_model.dart';
import 'package:foodly/views/auth/widget/email_textfield.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class ShippingAddress extends StatefulWidget {
  const ShippingAddress({super.key});

  @override
  State<ShippingAddress> createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  late final PageController _pageController = PageController(initialPage: 0);
  LatLng? _selectedPosition;
  GoogleMapController? _mapController;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _postalCode = TextEditingController();
  final TextEditingController _deliveryInstruction = TextEditingController();

  List<dynamic> _placeList = [];
  List<dynamic> _selectedPlace = [];

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String searchQuery) async {
    if (searchQuery.isNotEmpty) {
      final url = Uri.parse(
          "https://maps.gomaps.pro/maps/api/place/queryautocomplete/json?input=$searchQuery&key=$googleApiKey");

      final response = await http.get(url);
      print("response address ggapi: ${response.body}");
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kOffWhite,
        title: ReusableText(
            text: "Shipping address",
            style: appStyle(13, kGray, FontWeight.w600)),
        centerTitle: true,
        actions: [
          Obx(() => locationController.tabIndex == 1
              ? const SizedBox.shrink()
              : Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: IconButton(
                      onPressed: () {
                        locationController.setTabIndex = 1;
                        _pageController.nextPage(
                            duration: const Duration(microseconds: 500),
                            curve: Curves.easeIn);
                      },
                      icon: const Icon(
                        AntDesign.rightcircleo,
                        color: kDark,
                      )),
                ))
        ],
        leading: Obx(() => Padding(
            padding: EdgeInsets.only(right: 0.w),
            child: locationController.tabIndex == 0
                ? IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      AntDesign.closecircleo,
                      color: kRed,
                    ))
                : IconButton(
                    onPressed: () {
                      locationController.setTabIndex = 0;
                      _pageController.previousPage(
                          duration: const Duration(microseconds: 500),
                          curve: Curves.easeIn);
                    },
                    icon: const Icon(
                      AntDesign.leftcircleo,
                      size: 23,
                      color: kDark,
                    )))),
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          pageSnapping: false,
          onPageChanged: (index) {
            setState(() {
              _pageController.jumpToPage(index);
            });
          },
          children: [
            Stack(
              children: [
                GoogleMap(
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  initialCameraPosition: CameraPosition(
                      target: _selectedPosition ??
                          const LatLng(21.0186661, 105.8005229),
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
                                    _getPlaceDetails(
                                        _placeList[index]['place_id']);
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
            BackgroundContainer(
              color: kOffWhite,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  EmailTextField(
                    controller: _searchController,
                    hintText: "Address",
                    prefixIcon: const Icon(Ionicons.location_sharp),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  EmailTextField(
                    controller: _postalCode,
                    hintText: "Postal Code",
                    prefixIcon: const Icon(Ionicons.location_sharp),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  EmailTextField(
                    controller: _deliveryInstruction,
                    hintText: "Delivery Instructions",
                    prefixIcon: const Icon(Ionicons.add_circle),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableText(
                            text: "Set address as default",
                            style: appStyle(12, kDark, FontWeight.w600)),
                        Obx(() => CupertinoSwitch(
                            thumbColor: kSecondary,
                            trackColor: kPrimary,
                            value: locationController.isDefault,
                            onChanged: (value) {
                              locationController.setIsDefault = value;
                            }))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomButton(
                    onTap: () {
                      if (_searchController.text.isNotEmpty &&
                          _postalCode.text.isNotEmpty &&
                          _deliveryInstruction.text.isNotEmpty) {
                        AddressModel model = AddressModel(
                            addressLine1: _searchController.text,
                            postalCode: _postalCode.text,
                            addressModelDefault: locationController.isDefault,
                            deliveryInstructions: _deliveryInstruction.text,
                            latitude: _selectedPosition!.latitude,
                            longitude: _selectedPosition!.longitude);

                        String data = addressModelToJson(model);
                        locationController.addAddress(data);
                      } else {
                        Get.snackbar("Oops, something went wrong",
                            "Your missing some field!",
                            colorText: kLightWhite,
                            backgroundColor: kRed,
                            icon: const Icon(Icons.error_outline));
                      }
                    },
                    text: "S U B M I T",
                    btnHeight: 45,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

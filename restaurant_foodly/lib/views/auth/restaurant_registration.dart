// ignore_for_file: prefer_collection_literals

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:restaurant_foodly/common/app_style.dart';
import 'package:restaurant_foodly/common/background_container.dart';
import 'package:restaurant_foodly/common/custom_button.dart';
import 'package:restaurant_foodly/common/reusable_text.dart';
import 'package:restaurant_foodly/constants/constants.dart';
import 'package:restaurant_foodly/controllers/restaurant_controller.dart';
import 'package:restaurant_foodly/controllers/uploader_controller.dart';
import 'package:restaurant_foodly/models/restaurant_request.dart';
import 'package:restaurant_foodly/views/auth/login_page.dart';
import 'package:restaurant_foodly/views/auth/widget/email_textfield.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_foodly/views/auth/widget/map_btn.dart';

class RestaurantRegistration extends StatefulWidget {
  const RestaurantRegistration({super.key});

  @override
  State<RestaurantRegistration> createState() => _RestaurantRegistrationState();
}

class _RestaurantRegistrationState extends State<RestaurantRegistration> {
  final box = GetStorage();
  late final PageController _pageController = PageController(initialPage: 0);
  GoogleMapController? _mapController;

  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _time = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _postalCode = TextEditingController();
  List<dynamic> _placeList = [];
  List<dynamic> _selectedPlaceList = [];

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
    _searchController.dispose();
    _title.dispose();
    _time.dispose();
    _address.dispose();
    _postalCode.dispose();
    super.dispose();
  }

  LatLng? _selectedLocation;

  void _onMarkerDragEnd(LatLng position) async {
    setState(() {
      _selectedLocation = position;
    });

    var reverseGeoCodingUrl = Uri.parse(
        "https://maps.gomaps.pro/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$googleApiKey");

    final response = await http.get(reverseGeoCodingUrl);

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);

      final address = responseBody['result'][2]['formatted_address'];

      String postalCode = '';
      final addressComponents = responseBody['result'][0]['address_components'];

      for (var component in addressComponents) {
        if (component['types'].contains('postal_code')) {
          postalCode = component['long_name'];
        }
      }

      setState(() {
        _searchController.text = address;
        _postalCode.text = postalCode;
      });
    } else {
      debugPrint("Error getting this address");
    }
  }

  void _getPlaceDetail(String placeId) async {
    var placeDetailUrl = Uri.parse(
        "https://maps.gomaps.pro/maps/api/place/details/json?place_id=$placeId&key=$googleApiKey");

    final response = await http.get(placeDetailUrl);
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final position = responseBody['result']['geometry']['location'];

      final lat = position['lat'];
      final lng = position['lng'];

      final address = responseBody['result']['formatted_address'];
      String postalCode = '';
      final addressComponents = responseBody['result']['address_components'];

      for (var component in addressComponents) {
        if (component['types'].contains('postal_code')) {
          postalCode = component['long_name'];
        }
        break;
      }

      setState(() {
        _selectedLocation = LatLng(lat, lng);
        _searchController.text = address;
        _postalCode.text = postalCode;
        _placeList = [];
        moveToSelection();
      });
    }
  }

  void moveToSelection() {
    if (_selectedLocation != null && _mapController != null) {
      _mapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: _selectedLocation!, zoom: 15)));
    }
  }

  void _onSearhChanged(String searchQuery) async {
    if (searchQuery.isNotEmpty) {
      final url = Uri.parse(
          "https://maps.gomaps.pro/maps/api/place/autocomplete/json?input=$searchQuery&key=$googleApiKey");

      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          _placeList = json.decode(response.body)['predictions'];
        });
      } else {
        setState(() {
          _placeList = [];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final uploader = Get.put(UploaderController());
    final controller = Get.put(RestaurantController());
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimary,
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MapBtn(
              text: "Back",
              onTap: () {
                Get.to(() => const LoginPage());
              },
            ),
            ReusableText(
                text: "Register Restaurant",
                style: appStyle(13, kLightWhite, FontWeight.w600)),
            MapBtn(
              text: "Next",
              onTap: () {
                _pageController.nextPage(
                    duration: const Duration(microseconds: 500),
                    curve: Curves.easeIn);
              },
            ),
          ],
        ),
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            BackgroundContainer(
              child: Stack(
                children: [
                  GoogleMap(
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      initialCameraPosition: CameraPosition(
                          target: _selectedLocation ??
                              const LatLng(21.0186661, 105.8005229),
                          zoom: 15),
                      onMapCreated: (GoogleMapController controller) {
                        _mapController = controller;
                      },
                      markers: _selectedLocation == null
                          ? Set.of([])
                          : Set.of([
                              Marker(
                                markerId: const MarkerId('Your location'),
                                position: _selectedLocation!,
                                draggable: true,
                                onDragEnd: (LatLng position) {
                                  _onMarkerDragEnd(position);
                                },
                              )
                            ])),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        color: Colors.white,
                        child: TextField(
                          controller: _searchController,
                          onChanged: _onSearhChanged,
                          decoration: InputDecoration(
                            hintText: "Search for your address...",
                            hintStyle: appStyle(13, kGray, FontWeight.normal),
                          ),
                        ),
                      ),
                      _placeList.isEmpty
                          ? const SizedBox.shrink()
                          : Expanded(
                              child: ListView(
                              children:
                                  List.generate(_placeList.length, (index) {
                                return Container(
                                  color: Colors.white,
                                  child: ListTile(
                                    visualDensity: VisualDensity.compact,
                                    title: Text(
                                      _placeList[index]['description'],
                                      style: appStyle(
                                          12, kGray, FontWeight.normal),
                                    ),
                                    onTap: () {
                                      _getPlaceDetail(
                                          _placeList[index]['place_id']);
                                      print(_placeList[index]['place_id']);
                                      _selectedPlaceList.add(_placeList[index]);
                                    },
                                  ),
                                );
                              }),
                            ))
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: height,
              child: BackgroundContainer(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              uploader.pickImage('logo');
                            },
                            child: Obx(
                              () => Container(
                                height: 120.h,
                                width: width / 2.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(color: kGrayLight),
                                ),
                                child: uploader.logoUrl == ''
                                    ? Center(
                                        child: ReusableText(
                                            text: "Upload Logo",
                                            style: appStyle(
                                                16, kDark, FontWeight.w600)),
                                      )
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        child: Image.network(
                                          uploader.logoUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              ),
                            )),
                        GestureDetector(
                            onTap: () {
                              uploader.pickImage('cover');
                            },
                            child: Obx(
                              () => Container(
                                height: 120.h,
                                width: width / 2.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(color: kGrayLight),
                                ),
                                child: uploader.coverUrl == ''
                                    ? Center(
                                        child: ReusableText(
                                            text: "Upload Cover",
                                            style: appStyle(
                                                16, kDark, FontWeight.w600)),
                                      )
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        child: Image.network(
                                          uploader.coverUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    EmailTextField(
                      prefixIcon:
                          const Icon(AntDesign.edit, size: 14, color: kGray),
                      controller: _title,
                      hintText: "Restaurant Title",
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    EmailTextField(
                      prefixIcon:
                          const Icon(AntDesign.edit, size: 14, color: kGray),
                      controller: _time,
                      hintText: "Business Hrs (08:00 AM - 10:00 PM)",
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    EmailTextField(
                      prefixIcon:
                          const Icon(AntDesign.edit, size: 14, color: kGray),
                      controller: _postalCode,
                      hintText: "Postal Code",
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    EmailTextField(
                      prefixIcon:
                          const Icon(AntDesign.edit, size: 14, color: kGray),
                      controller: _searchController,
                      hintText: "Address",
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomButton(
                      text: "A D D   R E S T A U R A N T",
                      btnHight: 35.h,
                      onTap: () {
                        if (_time.text.isEmpty ||
                            _title.text.isEmpty ||
                            _postalCode.text.isEmpty ||
                            _searchController.text.isEmpty ||
                            uploader.logoUrl.isEmpty ||
                            uploader.coverUrl.isEmpty) {
                          Get.snackbar("Error", "All fields are required",
                              colorText: kLightWhite,
                              backgroundColor: kRed,
                              icon: const Icon(Icons.error_outline));
                        }
                        String owner = box.read("userId");
                        RestaurantRequest model = RestaurantRequest(
                            title: _title.text,
                            time: _time.text,
                            owner: owner,
                            code: _postalCode.text,
                            logoUrl: uploader.logoUrl,
                            imageUrl: uploader.coverUrl,
                            coords: Coords(
                                id: controller.generateId(),
                                latitude: _selectedLocation!.latitude,
                                longitude: _selectedLocation!.longitude,
                                address: _searchController.text,
                                title: _title.text));

                        String data = restaurantRequestToJson(model);

                        controller.restaurantRegistration(data);
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

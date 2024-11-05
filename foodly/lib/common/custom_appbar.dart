// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/common/reusable_text.dart';
import 'package:foodly/controller/user_location_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomAppbar extends StatefulHookWidget {
  const CustomAppbar({super.key});

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    // final hookResults = fetchDefaultAddresses(context);
    // final box = GetStorage();
    // String? accessToken = box.read('token');

    // if (accessToken == null) {
    //   hookResults;
    // }

    final controller = Get.put(UserLocationController());

    return Container(
      width: width,
      height: 107.h,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent), color: kOffWhite),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      child: Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 23.r,
                  backgroundColor: kSecondary,
                  backgroundImage: const NetworkImage(
                      "https://images.unsplash.com/photo-1499557354967-2b2d8910bcca?q=80&w=1036&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 6.h, left: 8.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                          text: "Deliver to",
                          style: appStyle(13, kSecondary, FontWeight.w600)),
                      Obx(
                        () => SizedBox(
                          width: width * 0.62,
                          child: Text(
                            controller.address1 == ""
                                ? controller.address == ""
                                    ? "Tòa nhà Keangnam Landmark 72, E6 Phạm Hùng, Phường Mễ Trì, Quận Nam Từ Liêm, Hà Nội"
                                    : controller.address
                                : controller.address1,
                            overflow: TextOverflow.ellipsis,
                            style: appStyle(11, kDark, FontWeight.normal),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Text(getTimeOfDay(), style: const TextStyle(fontSize: 35)),
          ],
        ),
      ),
    );
  }

  String getTimeOfDay() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour >= 0 && hour < 12) {
      return " ☀️ ";
    } else if (hour >= 12 && hour < 16) {
      return " ⛅ ";
    } else {
      return " 🌙 ";
    }
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    _getCurrentLocation();
    //_getAddressFromLatng();
  }

  Future<void> _getCurrentLocation() async {
    final controller = Get.put(UserLocationController());
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    Position position =
        await Geolocator.getCurrentPosition(locationSettings: locationSettings);
    LatLng currentLocation = LatLng(position.latitude, position.longitude);

    controller.setPosistion(currentLocation);
    controller.getUserAddress(currentLocation);
  }
}

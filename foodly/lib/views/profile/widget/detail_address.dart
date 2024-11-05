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
import 'package:foodly/models/address_response.dart';
import 'package:foodly/views/auth/widget/email_textfield.dart';
import 'package:foodly/views/profile/widget/update_address.dart';
import 'package:get/get.dart';

class DetailAddress extends StatefulWidget {
  const DetailAddress({super.key, this.address, this.data});

  final AddressResponse? address;
  final List<dynamic>? data;

  @override
  State<DetailAddress> createState() => _DetailAddressState();
}

TextEditingController _addressLine1 = TextEditingController();
TextEditingController _postalCode = TextEditingController();
TextEditingController _deliveryInstruction = TextEditingController();
TextEditingController _lantitude = TextEditingController();
TextEditingController _longitude = TextEditingController();

class _DetailAddressState extends State<DetailAddress> {
  @override
  void initState() {
    if (widget.address != null) {
      setState(() {
        _addressLine1.text = widget.address!.addressLine1;
        _postalCode.text = widget.address!.postalCode;
        _deliveryInstruction.text = widget.address!.deliveryInstructions;
        _lantitude.text = widget.address!.latitude.toString();
        _longitude.text = widget.address!.longitude.toString();
      });
    } else {
      setState(() {
        _addressLine1.text = widget.data![0];
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    setState(() {
      _addressLine1.text = '';
      _postalCode.text = '';
      _deliveryInstruction.text = '';
      _lantitude.text = '';
      _longitude.text = '';
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locationController = Get.put(UserLocationController());

    return Scaffold(
        backgroundColor: kOffWhite,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kOffWhite,
          centerTitle: true,
          title: ReusableText(
              text: "Detail Address",
              style: appStyle(13, kGray, FontWeight.w600)),
        ),
        body: BackgroundContainer(
          color: kOffWhite,
          child: Container(
            width: width,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              children: [
                SizedBox(
                  height: 30.h,
                ),
                EmailTextField(
                  enabled: false,
                  controller: _addressLine1,
                  hintText: "Address",
                  prefixIcon: const Icon(Ionicons.location_sharp),
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
                ),
                SizedBox(
                  height: 15.h,
                ),
                EmailTextField(
                  enabled: false,
                  controller: _lantitude,
                  hintText: "Latitude",
                  prefixIcon: const Icon(Ionicons.location_sharp),
                ),
                SizedBox(
                  height: 15.h,
                ),
                EmailTextField(
                  enabled: false,
                  controller: _longitude,
                  hintText: "Longitude",
                  prefixIcon: const Icon(Ionicons.location_sharp),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widget.address!.addressResponseDefault == true
                          ? ReusableText(
                              text: "Address is default.",
                              style: appStyle(12, kDark, FontWeight.w600))
                          : Container(
                              width: width * 0.93,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ReusableText(
                                      text: "Set address as default",
                                      style:
                                          appStyle(12, kDark, FontWeight.w600)),
                                  Obx(() => CupertinoSwitch(
                                      thumbColor: kSecondary,
                                      trackColor: kPrimary,
                                      value: locationController.isDefault,
                                      onChanged: (value) {
                                        locationController.setIsDefault = value;
                                      }))
                                ],
                              ),
                            )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                CustomButton(
                  onTap: () {
                    Get.to(() => UpdateAddress(
                          address: widget.address!,
                          deliveryInstructions: _deliveryInstruction.text,
                        ));
                  },
                  text: "C L I C K  H E R E  T O  E D I T",
                  btnHeight: 45,
                )
              ],
            ),
          ),
        ));
  }
}


// _id
// 66e9ac540ce801bb64bb6c54
// userId
// "66e97b9f40b0093ce16ba6c1"
// addressLine1
// "150 Geary St Usa"
// postalCode
// "94108"
// default
// true
// deliveryInstructions
// "Laeve the package by the gate."
// latitude
// 40.7128
// longitude
// -74.006
// __v
// 0

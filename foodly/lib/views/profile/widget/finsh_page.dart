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
import 'package:foodly/models/address_response.dart';
import 'package:foodly/views/auth/widget/email_textfield.dart';
import 'package:get/get.dart';

class FinshPage extends StatefulWidget {
  FinshPage(
      {super.key,
      this.addL1,
      this.postalCode,
      this.deInstruct,
      this.lat,
      this.lng,
      required this.address});

  final AddressResponse address;
  final String? addL1;
  final String? postalCode;
  final String? deInstruct;
  final double? lat;
  final double? lng;

  @override
  State<FinshPage> createState() => _FinishPageState();
}

TextEditingController _addressLine1 = TextEditingController();
TextEditingController _postalCode = TextEditingController();
TextEditingController _deliveryInstruction = TextEditingController();
TextEditingController _lantitude = TextEditingController();
TextEditingController _longitude = TextEditingController();

class _FinishPageState extends State<FinshPage> {
  @override
  void initState() {
    setState(() {
      _addressLine1.text = widget.addL1!;
      _postalCode.text = widget.postalCode!;
      _deliveryInstruction.text = widget.deInstruct!;
      _lantitude.text = widget.lat!.toString();
      _longitude.text = widget.lng!.toString();
    });
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
                GestureDetector(
                  onTap: () {
                    // Get.to(() => UpdateAddress(deliveryInstructions: ,));
                  },
                  child: EmailTextField(
                    enabled: false,
                    controller: _addressLine1,
                    hintText: "Address",
                    prefixIcon: const Icon(Ionicons.location_sharp),
                  ),
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
                      widget.address.addressResponseDefault == true
                          ? Container(
                              width: width * 0.93,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ReusableText(
                                      text: "Address is default",
                                      style:
                                          appStyle(12, kDark, FontWeight.w600)),
                                  Obx(() => CupertinoSwitch(
                                      thumbColor: kSecondary,
                                      trackColor: kPrimary,
                                      value: locationController.isDefault,
                                      onChanged: (value) {
                                        locationController.setIsDefault = value;
                                        print(value);
                                      }))
                                ],
                              ),
                            )
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
                    if (_addressLine1.text.isNotEmpty &&
                        _postalCode.text.isNotEmpty &&
                        _deliveryInstruction.text.isNotEmpty) {
                      AddressModel model = AddressModel(
                          addressLine1: _addressLine1.text,
                          postalCode: _postalCode.text,
                          addressModelDefault: locationController.isDefault,
                          deliveryInstructions: _deliveryInstruction.text,
                          latitude: widget.lat!,
                          longitude: widget.lng!);

                      String data = addressModelToJson(model);
                      locationController.editAddress(data, widget.address.id);
                      Get.snackbar("Address update successfully",
                          "Enjoy your awesome experience",
                          colorText: kLightWhite,
                          backgroundColor: kPrimary,
                          icon: const Icon(Icons.done));
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

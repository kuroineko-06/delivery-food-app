import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant_foodly/common/app_style.dart';
import 'package:restaurant_foodly/common/background_container.dart';
import 'package:restaurant_foodly/common/custom_button.dart';
import 'package:restaurant_foodly/common/reusable_text.dart';
import 'package:restaurant_foodly/constants/constants.dart';
import 'package:restaurant_foodly/controllers/register_controller.dart';
import 'package:restaurant_foodly/models/register_model.dart';
import 'package:restaurant_foodly/views/auth/widget/email_textfield.dart';
import 'package:restaurant_foodly/views/auth/widget/password_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  late final TextEditingController _usernameController =
      TextEditingController();

  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    return Scaffold(
      backgroundColor: kOffWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: ReusableText(
            text: "Foodly Restaurant",
            style: appStyle(20, kPrimary, FontWeight.bold)),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
      ),
      body: BackgroundContainer(
        color: kOffWhite,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r), topRight: Radius.circular(30.r)),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 30.h,
              ),
              Lottie.asset("assets/anime/delivery.json"),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    EmailTextField(
                      hintText: "Username",
                      prefixIcon: const Icon(
                        CupertinoIcons.mail,
                        size: 22,
                        color: kGrayLight,
                      ),
                      controller: _usernameController,
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    EmailTextField(
                      hintText: "Email",
                      prefixIcon: const Icon(
                        CupertinoIcons.mail,
                        size: 22,
                        color: kGrayLight,
                      ),
                      controller: _emailController,
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    PasswordTextfield(
                      controller: _passwordController,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Obx(
                      () => controller.isLoading
                          ? const Center(
                              child: CircularProgressIndicator.adaptive(
                                backgroundColor: kPrimary,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(kLightWhite),
                              ),
                            )
                          : CustomButton(
                              text: "R E G I S T E R",
                              onTap: () {
                                if (_emailController.text.isNotEmpty &&
                                    _usernameController.text.isNotEmpty &&
                                    _passwordController.text.length >= 8) {
                                  RegisterModel model = RegisterModel(
                                      username: _usernameController.text,
                                      email: _emailController.text,
                                      password: _passwordController.text);

                                  String data = registerModelToJson(model);
                                  controller.registerFunction(data);
                                }
                              },
                              btnHight: 35.h,
                              btnColor: kPrimary,
                              btnWidth: width,
                            ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

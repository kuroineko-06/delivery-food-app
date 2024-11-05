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
import 'package:restaurant_foodly/controllers/login_controller.dart';
import 'package:restaurant_foodly/models/login_request.dart';
import 'package:restaurant_foodly/views/auth/register_page.dart';
import 'package:restaurant_foodly/views/auth/widget/email_textfield.dart';
import 'package:restaurant_foodly/views/auth/widget/password_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();

  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      backgroundColor: kOffWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Center(
          child: ReusableText(
              text: "Foodly Restaurant Panel",
              style: appStyle(20, kPrimary, FontWeight.bold)),
        ),
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
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const RegisterPage(),
                                  transition: Transition.fadeIn,
                                  duration: const Duration(microseconds: 900));
                            },
                            child: ReusableText(
                                text: "Register",
                                style: appStyle(
                                    12, Colors.blue, FontWeight.normal)),
                          ),
                        ],
                      ),
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
                              text: "L O G I N",
                              onTap: () {
                                if (_emailController.text.isNotEmpty &&
                                    _passwordController.text.length >= 8) {
                                  LoginRequest model = LoginRequest(
                                      email: _emailController.text,
                                      password: _passwordController.text);

                                  String data = loginRequestToJson(model);
                                  controller.loginFunction(data);
                                }
                              },
                              btnHight: 35.h,
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

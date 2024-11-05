// ignore_for_file: unnecessary_null_comparison

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:restaurant_foodly/firebase_options.dart';
import 'package:restaurant_foodly/views/auth/login_page.dart';
import 'package:restaurant_foodly/views/auth/verification_page.dart';
import 'package:restaurant_foodly/views/auth/waiting_page.dart';
import 'package:restaurant_foodly/views/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();
  runApp(const MyApp());
}

Widget defaultHome = const LoginPage();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    String? accessToken = box.read("accessToken");
    String? restaurantId = box.read("restaurantId");
    String? verification = box.read("verification");
    // ignore: non_constant_identifier_names
    bool? e_verification = box.read("e-verification") ?? false;

    if (accessToken == null) {
      defaultHome = const LoginPage();
    } else if (accessToken != null && e_verification == false) {
      defaultHome = const VerificationPage();
    } else if (accessToken != null &&
        restaurantId != null &&
        verification == "Verified") {
      defaultHome = const HomePage();
    } else if (accessToken != null &&
        restaurantId != null &&
        verification != "Verified") {
      defaultHome = const WaitingPage();
    }
    return ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, snapshot) {
          return GetMaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: defaultHome,
          );
        });
  }
}

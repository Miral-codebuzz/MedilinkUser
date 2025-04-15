import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/constants/settings.dart';
import 'package:doc_o_doctor/screens/about_yourself_screen/about_yourself_screen.dart';
import 'package:doc_o_doctor/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:doc_o_doctor/screens/login_screen/login_screen.dart';
import 'package:doc_o_doctor/screens/medical_condition_screen/medical_condition_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/text_style_decoration.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      if (Settings.isUserLoggedIn) {
        if (Settings.step == "0") {
          Get.off(() => AboutYourselfScreen());
        } else if (Settings.step == "1") {
          Get.off(() => MedicalConditionScreen());
        } else {
          Get.off(() => BottomNavBar());
        }
      } else {
        Get.off(() => LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 150),
          Spacer(),
          Container(
            alignment: Alignment.center,
            child: Image.asset(AppImage.logoWhite, height: 120.h, width: 120.w),
          ),
          // SizedBox(height: 10.h),
          Text(
            "MEDILINK",
            style: TextStyleDecoration.labelSmall.copyWith(fontSize: 40.sp),
          ),
          Text(
            "Smart Care, Anytime",
            style: TextStyleDecoration.labelSmall.copyWith(fontSize: 15.sp),
          ),
          Spacer(),
          Image.asset("assets/images/h.gif", height: 150.h, width: 150.w),
        ],
      ),
    );
  }
}

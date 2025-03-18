import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/screens/login_screen/login_screen.dart';
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
    Future.delayed(Duration(seconds: 3), () {
      Get.off(() => LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Container(
            alignment: Alignment.center,
            child: Image.asset(AppImage.logoWhite, height: 150.h, width: 150.w),
          ),
          SizedBox(height: 10.h),
          Text(
            AppString.docO,
            style: TextStyleDecoration.labelSmall.copyWith(fontSize: 30.sp),
          ),
          Spacer(),
          Image.asset(AppImage.monitorHear, height: 150.h, width: 150.w),
        ],
      ),
    );
  }
}

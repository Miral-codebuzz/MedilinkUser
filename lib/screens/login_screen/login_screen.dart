import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/controller/login_controller.dart';
import 'package:doc_o_doctor/screens/book_appointment_screen/book_appointment_screen.dart';
import 'package:doc_o_doctor/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/app_color.dart';
import '../../constants/text_style_decoration.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 70.h),
                Image.asset(AppImage.logoBlue, height: 150.h, width: 150.w),
                SizedBox(height: 30.h),
                Text(
                  AppString.mobileNumber,
                  style: TextStyleDecoration.labelSmall.copyWith(
                    fontSize: 20.sp,
                    color: AppColor.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  AppString.pleaseEnterMobileNo,
                  textAlign: TextAlign.center,
                  style: TextStyleDecoration.labelSmall.copyWith(
                    fontSize: 14.sp,
                    color: AppColor.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        child: dividerWithText(text: AppString.orContinueWith),
                      ),

                      SizedBox(height: 15),
                      socialLoginButton(
                        btnText: AppString.signInWithGoogle,
                        image: AppImage.google,
                        onTap: () {},
                      ),
                      SizedBox(height: 20.h),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 50.w),
                        child: dividerWithText(text: AppString.or),
                      ),

                      SizedBox(height: 15),
                      commonButton(
                        text: AppString.continueAsAGuest,
                        bgColor: AppColor.lightGrey,
                        textColor: AppColor.black,
                        width: 267.w,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  dividerWithText({required String text}) {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColor.dividerColor)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text,
            style: TextStyleDecoration.labelSmall.copyWith(
              color: AppColor.grey,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(child: Divider(color: AppColor.dividerColor)),
      ],
    );
  }
}

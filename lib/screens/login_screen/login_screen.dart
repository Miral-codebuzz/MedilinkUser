import 'dart:developer';

import 'package:doc_o_doctor/constants/%20commonwidget.dart';
import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/controller/login_controller.dart';
import 'package:doc_o_doctor/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:doc_o_doctor/screens/home_screen/home_screen.dart';
import 'package:doc_o_doctor/widgets/common_button.dart';
import 'package:doc_o_doctor/widgets/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../constants/app_color.dart';
import '../../constants/text_style_decoration.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Obx(() {
        return SingleChildScrollView(
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
                      Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            IntlPhoneField(
                              controller: controller.mobileNumberController,
                              showDropdownIcon: true,
                              flagsButtonMargin: EdgeInsets.only(left: 10.w),
                              dropdownIconPosition: IconPosition.trailing,
                              dropdownIcon: Icon(Icons.keyboard_arrow_down),
                              showCountryFlag: false,
                              cursorColor: AppColor.primaryColor,
                              decoration: InputDecoration(
                                errorText:
                                    controller.errorText.value.isEmpty
                                        ? null
                                        : controller.errorText.value,
                                /* prefix: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(AppImage.keyboardDownArrow,
                                            width: 10.w),
                                        SizedBox(width: 10.w),
                                        Text(
                                          '|',
                                          style:
                                              TextStyleDecoration.labelSmall.copyWith(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                            // color: AppColor.black,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                      ],
                                    ),
                                    prefixIconColor: Colors.black54,
                                    prefixIcon: Text(
                                      '|',
                                      style: TextStyleDecoration.labelSmall.copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        // color: AppColor.black,
                                        color: Colors.black54,
                                      ),
                                    ), */
                                hintText: AppString.enterMobileNo,
                                hintStyle: TextStyleDecoration.labelSmall
                                    .copyWith(
                                      color: Colors.grey,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                contentPadding: EdgeInsets.only(left: 10),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(
                                    color: AppColor.textFieldBorderColor,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(
                                    color: AppColor.textFieldBorderColor,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(
                                    color: AppColor.textFieldBorderColor,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(
                                    color: AppColor.textFieldBorderColor,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade100,
                              ),
                              initialCountryCode: 'IN',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              dropdownTextStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              onChanged: (phone) {
                                controller.mobileNumber.value = phone.number;
                                log('Number: ${phone.countryCode}');
                                controller.countryCode = phone.countryCode;
                                controller.errorText.value = "";
                              },
                            ),
                            /* Container(
                                  // margin: EdgeInsets.symmetric(horizontal: 20.w),
                                  height: 45.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Colors.grey.shade100,
                                    border: Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: Text(
                                          '+91',
                                          style:
                                              TextStyleDecoration.labelSmall.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5.w),
                                      Image.asset(AppImage.keyboardDownArrow,
                                          width: 10.w),
                                      SizedBox(width: 10.w),
                                      Text(
                                        '|',
                                        style:
                                            TextStyleDecoration.labelSmall.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.black,
                                        ),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          cursorColor: AppColor.black,
                                          keyboardType: TextInputType.phone,
                                          style: TextStyle(color: AppColor.black),
                                          onChanged: (value) =>
                                              controller.mobileNumber.value = value,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.grey.shade100,
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(15),
                                              borderSide: BorderSide.none,
                                            ),
                                            /* enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(7),
                                              borderSide: BorderSide(
                                                color: AppColor.textFieldBorderColor,
                                                // width: 1,
                                              ),
                                            ),
                                             focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(7),
                                              borderSide: BorderSide(
                                                color: AppColor.textFieldBorderColor,
                                              ),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(7),
                                              borderSide: BorderSide(
                                                color: AppColor.textFieldBorderColor,
                                              ),
                                            ),
                                            focusedErrorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(7),
                                              borderSide: BorderSide(
                                                color: AppColor.textFieldBorderColor,
                                              ),
                                            ), */
                                            errorText: null,
                                            hintText: AppString.mobileNumber,
                                            hintStyle: TextStyleDecoration.labelSmall
                                                .copyWith(
                                              color: Colors.grey,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ), */
                            // if (controller.errorText.isNotEmpty)
                            //   Padding(
                            //     padding: const EdgeInsets.only(
                            //       top: 5,
                            //       left: 10,
                            //     ),
                            //     child: Text(
                            //       controller.errorText.value,
                            //       style: TextStyle(
                            //         color: Colors.red,
                            //         fontSize: 12,
                            //       ),
                            //     ),
                            //   ),
                            SizedBox(height: 20.h),
                            controller.isLoading.value
                                ? Commonwidget.commonLoader()
                                : commonButton(
                                  onPressed: () => controller.validate(),
                                  text: AppString.continues,
                                ),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),

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
                        onPressed: () {
                          Get.offAll(BottomNavBar());
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
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

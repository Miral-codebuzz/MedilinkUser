import 'package:doc_o_doctor/constants/%20commonwidget.dart';
import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/constants/text_style_decoration.dart';
import 'package:doc_o_doctor/controller/otp_controller.dart';
import 'package:doc_o_doctor/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OtpScreen extends StatelessWidget {
  final String mobileNo;
  final String countryCode;
  OtpScreen({super.key, required this.mobileNo, required this.countryCode});
  final OtpController controller = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    controller.countryCode.value = countryCode;
    controller.mobileNumber.value = mobileNo;
    controller.otp.value = '';
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70.h),
              Image.asset(AppImage.logoBlue, height: 150.h, width: 150.w),
              SizedBox(height: 30.h),
              Text(
                AppString.otpVerification,
                style: TextStyleDecoration.labelSmall.copyWith(
                  fontSize: 20.sp,
                  color: AppColor.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                AppString.wewillSendAnOTPTo,
                textAlign: TextAlign.center,
                style: TextStyleDecoration.labelSmall.copyWith(
                  fontSize: 14.sp,
                  color: AppColor.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "${countryCode.isNotEmpty ? countryCode : ''} ${mobileNo.isNotEmpty ? mobileNo : ''} ${AppString.mobileNo}",
                textAlign: TextAlign.center,
                style: TextStyleDecoration.labelSmall.copyWith(
                  fontSize: 14.sp,
                  color: AppColor.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 20.h),
              OtpTextField(
                mainAxisAlignment: MainAxisAlignment.center,
                fillColor: AppColor.lightGrey,
                focusedBorderColor: AppColor.primaryColor,
                filled: true,
                handleControllers: (controllers) {
                  debugPrint(controllers.length.toString());
                },
                fieldWidth: 43.45.w,
                fieldHeight: 43.45.h,
                cursorColor: AppColor.primaryColor,
                margin: EdgeInsets.symmetric(horizontal: 7.w),
                numberOfFields: 6,
                borderColor: AppColor.grey,

                //set to true to show as box or false to show as dash
                showFieldAsBox: true,

                //runs when a code is typed in
                onCodeChanged: (String code) => controller.otp.value = code,
                borderWidth: 1,
                borderRadius: BorderRadius.circular(12),
                alignment: Alignment.center,
                styles: const [
                  TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    // fontFamily: CustomFont.montserrat,
                    letterSpacing: 0,
                  ),
                  TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    //fontFamily: CustomFont.montserrat,
                    letterSpacing: 0,
                  ),
                  TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    // fontFamily: CustomFont.montserrat,
                    letterSpacing: 0,
                  ),
                  TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    //fontFamily: CustomFont.montserrat,
                    letterSpacing: 0,
                  ),
                  TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    //fontFamily: CustomFont.montserrat,
                    letterSpacing: 0,
                  ),
                  TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    //fontFamily: CustomFont.montserrat,
                    letterSpacing: 0,
                  ),
                ],
                //runs when every textfield is filled
                onSubmit: (String verificationCode) {
                  if (verificationCode.isEmpty) {
                    debugPrint("OTP is empty");
                    Get.snackbar(
                      "Error",
                      "Please enter the OTP",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  } else if (verificationCode.length < 6) {
                    debugPrint("Invalid OTP length");
                    Get.snackbar(
                      "Error",
                      "OTP must be 6 digits long",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  } else {
                    debugPrint("OTP entered: $verificationCode");
                    // Proceed with OTP verification
                    controller.otp.value = verificationCode;
                    controller.verifyOTP(context);
                  }
                }, // end onSubmit
              ),
              SizedBox(height: 20.h),
              Obx(() {
                int seconds = controller.resendTime.value;
                String formattedTime =
                    "${(seconds ~/ 60)}:${(seconds % 60).toString().padLeft(2, '0')}";
                return (controller.resendTime.value > 0)
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppString.otpResendIn,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColor.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          formattedTime,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                    : TextButton(
                      onPressed: () => controller.resendOtp(context),
                      child: Text(
                        AppString.resentOtp,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColor.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
              }),
              SizedBox(height: 30.h),
              Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: Commonwidget.commonLoader());
                }
                return commonButton(
                  onPressed: () {
                    if (controller.otp.value.length == 6) {
                      controller.verifyOTP(context);
                    } else {}
                  },
                  text: AppString.submit,
                  width: 325.w,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

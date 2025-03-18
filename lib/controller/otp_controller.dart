import 'package:doc_o_doctor/screens/about_yourself_screen/about_yourself_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  var otp = ''.obs;
  var resendTime = 59.obs;
  var isResendActive = false.obs;

  @override
  void onInit() {
    startResendTimer();
    super.onInit();
  }

  void startResendTimer() {
    resendTime.value = 59;
    isResendActive.value = false;
    Future.delayed(Duration(seconds: 1), countdown);
  }

  void countdown() {
    if (resendTime.value > 0) {
      resendTime.value--;
      Future.delayed(Duration(seconds: 1), countdown);
    } else {
      isResendActive.value = true;
    }
  }

  void verifyOTP() {
    if (otp.value.length == 6) {
      /* Get.snackbar(
        'Success',
        'OTP Verified!',
        snackPosition: SnackPosition.BOTTOM,
      ); */
      Get.to(() => AboutYourselfScreen());
    } else {
      /* Get.snackbar(
        'Error',
        'Please enter a valid 6-digit OTP',
        snackPosition: SnackPosition.BOTTOM,
      ); */
    }
  }
}

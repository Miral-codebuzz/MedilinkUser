import 'dart:developer';

import 'package:doc_o_doctor/screens/otp_screen/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController mobileNumberController = TextEditingController();
  var mobileNumber = ''.obs;
  var errorText = ''.obs;
  String countryCode = '';
  /* void validate() {
    if (formKey.currentState!.validate()) {
      // ✅ Check using form validation
      log("Validation successful!");
      Get.to(
        () => OtpScreen(
          mobileNo: mobileNumberController.text,
          countryCode: countryCode,
        ),
      );
    } else {
      log("Validation failed!");
    }
  } */
  void validate() {
    if (mobileNumber.value.isEmpty) {
      errorText.value = 'Mobile number cannot be empty';
    } else {
      errorText.value = '';
      Get.to(
        () => OtpScreen(
          mobileNo: mobileNumberController.text,
          countryCode: countryCode,
        ),
      );

      // Proceed with the next step
      // Get.snackbar('Success', 'Mobile number is valid');
    }
  }
}

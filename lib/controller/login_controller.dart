import 'dart:developer';

import 'package:doc_o_doctor/Model/loginModel.dart';
import 'package:doc_o_doctor/constants/%20commonwidget.dart';
import 'package:doc_o_doctor/screens/otp_screen/otp_screen.dart';
import 'package:doc_o_doctor/service/rest_services.dart';
import 'package:doc_o_doctor/service/service_configuration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController mobileNumberController = TextEditingController();
  var mobileNumber = ''.obs;
  var errorText = ''.obs;
  var service = Get.find<RestService>();
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
      login(Get.context!);

      // Proceed with the next step
      // Get.snackbar('Success', 'Mobile number is valid');
    }
  }

  var isLoading = false.obs;

  Future<void> login(context) async {
    try {
      var connection = await Commonwidget.checkConnectivity();
      if (!connection) return;
      isLoading.value = true;
      RegisterRequest registerRequest = RegisterRequest();
      registerRequest.mobileNumber =
          countryCode + " " + mobileNumberController.text;

      var result = await service.registerMobileNumber(registerRequest);

      if (result.status ?? false) {
        isLoading.value = false;
        Commonwidget.showSuccessSnackbar(
          message: result.message ?? ServiceConfiguration.commonErrorMessage,
        );
        Get.to(
          OtpScreen(
            mobileNo: mobileNumberController.text,
            countryCode: countryCode,
          ),
        );
      } else {
        isLoading.value = false;
        Commonwidget.showErrorSnackbar(
          message: result.message ?? ServiceConfiguration.commonErrorMessage,
        );
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint("ERROR :- ${e.toString()}");
    }
  }
}

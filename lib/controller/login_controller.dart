import 'dart:developer';

import 'package:doc_o_doctor/Model/loginModel.dart';
import 'package:doc_o_doctor/constants/commonwidget.dart';
import 'package:doc_o_doctor/screens/otp_screen/otp_screen.dart';
import 'package:doc_o_doctor/service/rest_services.dart';
import 'package:doc_o_doctor/service/service_configuration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  var mobileNumber = ''.obs;
  var errorText = ''.obs;
  var service = Get.find<RestService>();
  String countryCode = '';
  void validate() {
    if (formKey.currentState!.validate()) {
      login(Get.context!);
    } else {
      log("Validation failed!");
    }
  }

  var isLoading = false.obs;

  Future<void> login(context) async {
    try {
      var connection = await Commonwidget.checkConnectivity();
      if (!connection) return;
      isLoading.value = true;
      RegisterRequest registerRequest = RegisterRequest();
      registerRequest.email = emailController.text;

      var result = await service.registerMobileNumber(registerRequest);

      if (result.status ?? false) {
        isLoading.value = false;
        Commonwidget.showSuccessSnackbar(
          message: result.message ?? ServiceConfiguration.commonErrorMessage,
        );
        Get.offAll(OtpScreen(email: emailController.text));
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

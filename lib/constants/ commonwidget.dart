import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

class Commonwidget {
  static void showSuccessSnackbar({
    required String message,
    SnackPosition snackPosition = SnackPosition.TOP,
  }) {
    Get.snackbar(
      "Success",
      message,
      snackPosition: snackPosition,
      backgroundColor: Colors.green.withOpacity(0.7), // Correct opacity
      colorText: Colors.white,
      margin: const EdgeInsets.all(10.0),
      borderRadius: 8.0,
      snackStyle: SnackStyle.FLOATING,
    );
  }

  static void showErrorSnackbar({
    required String message,
    SnackPosition snackPosition = SnackPosition.TOP,
  }) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: snackPosition,
      backgroundColor: Colors.red.withOpacity(0.7), // Correct opacity
      colorText: Colors.white,
      margin: const EdgeInsets.all(10.0),
      borderRadius: 8.0,
      snackStyle: SnackStyle.FLOATING,
    );
  }

  static Future<bool> checkConnectivity() async {
    ConnectivityResult conenctivityResult =
        await Connectivity().checkConnectivity();
    if (conenctivityResult == ConnectivityResult.none) {
      return false;
    }
    return true;
  }

  static commonLoader() {
    return Stack(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: CircularProgressIndicator(color: AppColor.primaryColor),
          ),
        ),
      ],
    );
  }
}

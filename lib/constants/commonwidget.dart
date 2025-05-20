// ignore_for_file: deprecated_member_use

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  static Widget commonText({
    required String text,
    double fontSize = 16.0,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
    TextAlign? textAlign,
    String? fontFamily,
    TextDecoration? textDecoration,
    Color? decorationColor,
    int? maxLines,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines ?? 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: "Outfit",
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? Colors.black,
        decoration: textDecoration,
        decorationColor: decorationColor,
      ),
    );
  }
}

class DialogHelper {
  static Future<void> showCustomDialog({
    required BuildContext context,
    required String title,
    required String message,
    required String yesText,
    required String noText,
    required VoidCallback onTapYes,
    required VoidCallback onTapNo,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: SizedBox(
            height: 215,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Commonwidget.commonText(
                      text: title,
                      fontSize: 25,
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Commonwidget.commonText(
                      text: message,
                      maxLines: 3,
                      fontSize: 17,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: onTapYes,
                        child: Container(
                          alignment: Alignment.center,
                          width: Get.width * 0.30,
                          height: 45,
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor,

                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Commonwidget.commonText(
                            text: yesText,
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: onTapNo,
                        child: Container(
                          alignment: Alignment.center,
                          width: Get.width * 0.30,
                          height: 45,
                          decoration: BoxDecoration(
                            color: AppColor.borderColor,

                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Commonwidget.commonText(
                            text: noText,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

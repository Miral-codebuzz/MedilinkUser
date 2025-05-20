import 'package:device_info_plus/device_info_plus.dart';
import 'package:doc_o_doctor/Model/loginModel.dart';
import 'package:doc_o_doctor/constants/commonwidget.dart';
import 'package:doc_o_doctor/constants/settings.dart';
import 'package:doc_o_doctor/screens/about_yourself_screen/about_yourself_screen.dart';
import 'package:doc_o_doctor/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:doc_o_doctor/screens/medical_condition_screen/medical_condition_screen.dart';
import 'package:doc_o_doctor/screens/notification_screen/notificationController.dart';
import 'package:doc_o_doctor/service/rest_services.dart';
import 'package:doc_o_doctor/service/service_configuration.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  var otp = ''.obs;
  var resendTime = 59.obs;
  var isResendActive = false.obs;
  var service = Get.find<RestService>();
  final Notificationcontroller notificationcontroller = Get.put(
    Notificationcontroller(),
  );
  var email = "".obs;
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

  var isLoading = false.obs;

  void verifyOTP(context) {
    if (otp.value.length == 6) {
      otpVerification(context!);
    } else {
      /* Get.snackbar(
        'Error',
        'Please enter a valid 6-digit OTP',
        snackPosition: SnackPosition.BOTTOM,
      ); */
    }
  }

  Future<void> otpVerification(context) async {
    try {
      var connection = await Commonwidget.checkConnectivity();
      if (!connection) return;
      isLoading.value = true;
      OtpVerifierRequestModel otpVerifierRequestModel =
          OtpVerifierRequestModel();
      otpVerifierRequestModel.email = email.value;
      otpVerifierRequestModel.otp = otp.value;

      var result = await service.otpVerifier(otpVerifierRequestModel);

      if (result.status ?? false) {
        print(result.data?.authentication?.accessToken);
        print(result.data?.authentication?.refreshToken);
        isLoading.value = false;
        Commonwidget.showSuccessSnackbar(
          message: result.message ?? ServiceConfiguration.commonErrorMessage,
        );

        Settings.isUserLoggedIn = true;
        Settings.step = result.data!.step ?? "0";
        Settings.accessToken = result.data!.authentication?.accessToken ?? "";

        print(Settings.step);
        print(Settings.accessToken);
        print(Settings.isUserLoggedIn);

        final fcmToken = notificationcontroller.token.value;

        if (fcmToken.isNotEmpty) {
          final deviceInfo = DeviceInfoPlugin();
          String deviceId = "unknown";
          String deviceType = "unknown";

          try {
            if (GetPlatform.isAndroid) {
              final androidInfo = await deviceInfo.androidInfo;
              deviceId = androidInfo.id;
              deviceType = "Android";
            } else if (GetPlatform.isIOS) {
              final iosInfo = await deviceInfo.iosInfo;
              deviceId = iosInfo.identifierForVendor ?? "unknown";
              deviceType = "iOS";
            }
          } catch (e) {
            debugPrint("Error getting device info: $e");
          }

          notificationcontroller.sendTokenToServer(
            context,
            fcmToken: fcmToken,
            deviceId: deviceId,
            deviceType: deviceType,
          );
        } else {
          debugPrint("FCM token is empty");
        }

        if (Settings.step == "0") {
          Get.off(() => AboutYourselfScreen());
        } else if (Settings.step == "1") {
          Get.off(() => MedicalConditionScreen());
        } else {
          Get.off(() => BottomNavBar());
        }
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

  Future<void> resendOtp(context) async {
    try {
      var connection = await Commonwidget.checkConnectivity();
      if (!connection) return;

      RegisterRequest registerRequest = RegisterRequest();
      registerRequest.email = email.value;

      var result = await service.registerMobileNumber(registerRequest);

      if (result.status ?? false) {
        otp.value = "";
        startResendTimer();
        Commonwidget.showSuccessSnackbar(
          message: result.message ?? ServiceConfiguration.commonErrorMessage,
        );
      } else {
        Commonwidget.showErrorSnackbar(
          message: result.message ?? ServiceConfiguration.commonErrorMessage,
        );
      }
    } catch (e) {
      debugPrint("ERROR :- ${e.toString()}");
    }
  }
}

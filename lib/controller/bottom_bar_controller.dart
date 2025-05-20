// Controller to manage navigation state
import 'package:doc_o_doctor/Model/profileModel.dart';
import 'package:doc_o_doctor/constants/commonwidget.dart';
import 'package:doc_o_doctor/service/rest_services.dart';
import 'package:doc_o_doctor/service/service_configuration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavBarController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  var profileDetail = Rxn<ProfileResponse>(); // single doctor detail

  var service = Get.find<RestService>();

  var isLoading = false.obs;
  Future<void> getProfile() async {
    try {
      var connection = await Commonwidget.checkConnectivity();
      if (!connection) return;
      isLoading.value = true;
      var result = await service.getProfile();

      if (result.status ?? false) {
        profileDetail.value = result.data;
        isLoading.value = false;
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

  var isLogout = false.obs;

  Future<void> logout() async {
    try {
      var connection = await Commonwidget.checkConnectivity();
      if (!connection) return;
      isLoading.value = true;
      var result = await service.logOut();

      if (result.status ?? false) {
        isLogout.value = false;
      } else {
        isLogout.value = false;
        Commonwidget.showErrorSnackbar(
          message: result.message ?? ServiceConfiguration.commonErrorMessage,
        );
      }
    } catch (e) {
      isLogout.value = false;
      debugPrint("ERROR :- ${e.toString()}");
    }
  }
}

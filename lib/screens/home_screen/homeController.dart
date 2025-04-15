import 'package:doc_o_doctor/Model/homeModel.dart';
import 'package:doc_o_doctor/constants/%20commonwidget.dart';
import 'package:doc_o_doctor/service/rest_services.dart';
import 'package:doc_o_doctor/service/service_configuration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homecontroller extends GetxController {
  var isLoading = true.obs;
  var doctorList = <DoctorList>[].obs;
  var service = Get.find<RestService>();

  @override
  void onInit() {
    super.onInit();
    getDoctorList();
  }

  Future<void> getDoctorList() async {
    try {
      var connection = await Commonwidget.checkConnectivity();
      if (!connection) return;
      isLoading.value = true;
      var result = await service.getDoctorList();

      if (result.status ?? false) {
        doctorList.value = result.data ?? [];
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
}

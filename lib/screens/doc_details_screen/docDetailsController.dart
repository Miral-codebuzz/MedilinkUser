// ignore_for_file: file_names

import 'package:doc_o_doctor/Model/homeModel.dart';
import 'package:doc_o_doctor/constants/commonwidget.dart';
import 'package:doc_o_doctor/service/rest_services.dart';
import 'package:doc_o_doctor/service/service_configuration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Docdetailscontroller extends GetxController {
  var isLoading = false.obs;
  var doctorDetail = Rxn<DoctorDetail>(); // single doctor detail

  var service = Get.find<RestService>();

  var doctorId = 0.obs;

  Future<void> getDoctorList() async {
    try {
      var connection = await Commonwidget.checkConnectivity();
      if (!connection) return;
      isLoading.value = true;
      var result = await service.getDoctorDetail(doctorId: doctorId.value);

      if (result.status ?? false) {
        doctorDetail.value = result.data?.first ?? null;
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

  var isBookNow = false.obs;
  Future<void> addFamilyMemberdoctor(int id) async {
    try {
      var connection = await Commonwidget.checkConnectivity();
      if (!connection) return;
      isBookNow.value = true;
      var result = await service.addFamilyMemberdoctor(id);

      if (result.status ?? false) {
        Commonwidget.showSuccessSnackbar(
          message: result.message ?? ServiceConfiguration.commonErrorMessage,
        );
        isBookNow.value = false;
      } else {
        Commonwidget.showErrorSnackbar(
          message: result.message ?? ServiceConfiguration.commonErrorMessage,
        );
        isBookNow.value = false;
      }
    } catch (e) {
      isBookNow.value = false;
      debugPrint("ERROR :- ${e.toString()}");
    }
  }
}

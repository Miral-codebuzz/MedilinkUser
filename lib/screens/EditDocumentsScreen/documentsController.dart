// ignore_for_file: file_names

import 'package:doc_o_doctor/Model/documentModel.dart';
import 'package:doc_o_doctor/constants/commonwidget.dart';
import 'package:doc_o_doctor/service/rest_services.dart';
import 'package:doc_o_doctor/service/service_configuration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Documentscontroller extends GetxController {
  var service = Get.find<RestService>();
  var listOdDocumnets = <DocumentsList>[].obs;
  var isLoading = false.obs;
  Future<void> getDocument() async {
    try {
      var connection = await Commonwidget.checkConnectivity();
      if (!connection) return;
      isLoading.value = true;
      var result = await service.getDocuments();

      if (result.status ?? false) {
        listOdDocumnets.value = result.data ?? [];
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

  Future<void> deleteDocument({required int id}) async {
    try {
      var connection = await Commonwidget.checkConnectivity();
      if (!connection) return;
      isLoading.value = true;
      var result = await service.deleteDocument(id);

      if (result.status ?? false) {
        getDocument();
        Commonwidget.showSuccessSnackbar(
          message: result.message ?? ServiceConfiguration.commonErrorMessage,
        );
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

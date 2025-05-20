import 'package:doc_o_doctor/Model/bookNowModel.dart';
import 'package:doc_o_doctor/constants/commonwidget.dart';
import 'package:doc_o_doctor/service/rest_services.dart';
import 'package:doc_o_doctor/service/service_configuration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Bookingcontroller extends GetxController {
  var service = Get.find<RestService>();
  var selectedValue = "For Self".obs; // Observable variable
  var bookingList = <BookingList>[].obs;
  var isLoading = false.obs;
  var isbookingDatail = false.obs;
  var bookingDatail = Rxn<BookingDetail>();
  void updateSelection(String value) {
    selectedValue.value = value;
  }

  Future<void> getBookingList() async {
    try {
      var connection = await Commonwidget.checkConnectivity();
      if (!connection) return;
      isLoading.value = true;
      var result = await service.getBookingList();

      if (result.status ?? false) {
        bookingList.value = result.data ?? [];
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

  Future<void> getBookingDetail({required int id}) async {
    try {
      var connection = await Commonwidget.checkConnectivity();
      if (!connection) return;
      isbookingDatail.value = true;
      var result = await service.getBookingDetail(id: id);

      if (result.status ?? false) {
        bookingDatail.value = result.data;
        bookingDatail.value?.forWhom == "other"
            ? selectedValue.value = "For Other Person"
            : bookingDatail.value?.forWhom == "familyMember"
            ? selectedValue.value = "For Family Member"
            : selectedValue.value = "For Self";
        isbookingDatail.value = false;
      } else {
        isbookingDatail.value = false;
        Commonwidget.showErrorSnackbar(
          message: result.message ?? ServiceConfiguration.commonErrorMessage,
        );
      }
    } catch (e) {
      isbookingDatail.value = false;
      debugPrint("ERROR :- ${e.toString()}");
    }
  }

  Future<void> cancelAppoinment({required int id}) async {
    try {
      var connection = await Commonwidget.checkConnectivity();
      if (!connection) return;
      isLoading.value = true;
      var result = await service.cancelAppoinment(id: id);

      if (result.status ?? false) {
        Get.back();
        getBookingList();
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

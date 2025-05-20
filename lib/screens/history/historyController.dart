import 'package:doc_o_doctor/Model/bookNowModel.dart';
import 'package:doc_o_doctor/constants/commonwidget.dart';
import 'package:doc_o_doctor/service/rest_services.dart';
import 'package:doc_o_doctor/service/service_configuration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Historycontroller extends GetxController {
  var service = Get.find<RestService>();
  var selectedValue = "For Self".obs; // Observable variable
  var bookingList = <BookingList>[].obs;
  var isLoading = false.obs;
  var isbookingDatail = false.obs;
  final TextEditingController reviewController = TextEditingController();
  var bookingDatail = Rxn<BookingDetail>();
  final formKey = GlobalKey<FormState>();
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
}

import 'package:doc_o_doctor/Model/helpAndSupport.dart';
import 'package:doc_o_doctor/constants/commonwidget.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/service/rest_services.dart';
import 'package:doc_o_doctor/service/service_configuration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpAndSupportController extends GetxController {
  @override
  void dispose() {
    nameController.clear();
    ageController.clear();
    phoneController.clear();
    problemController.clear();
    super.dispose();
  }

  RxString selectedValue = AppString.selectpatient.obs;

  void updateSelectedValue(String value) {
    selectedValue.value = value;
  }

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final phoneController = TextEditingController();
  final problemController = TextEditingController();
  // final selectedGender = RxnString();
  //  RxString? selectedGender;
  final RxnString selectedProblem = RxnString();
  final List<String> problemOptions = ['Option 1', 'Option 2', 'Option 3'];

  void submitForm() {
    if (formKey.currentState!.validate()) {
      if (phoneController.text.isEmpty) {
        Commonwidget.showErrorSnackbar(message: "Please enter a mobile number");
        return;
      }
      // Get.back();
      helpAndSupport();
    }
  }

  var isLoading = false.obs;
  var countryCode = "+91".obs;
  var service = Get.find<RestService>();

  Future<void> helpAndSupport() async {
    try {
      var connection = await Commonwidget.checkConnectivity();
      if (!connection) return;
      isLoading.value = true;
      HelpAndSupportModel helpAndSupportModel = HelpAndSupportModel();
      helpAndSupportModel.name = nameController.text;
      helpAndSupportModel.mobileNumber = "$countryCode ${phoneController.text}";
      helpAndSupportModel.problemType = selectedValue.value;
      helpAndSupportModel.problem = problemController.text;

      var result = await service.helpAndSupport(helpAndSupportModel);

      if (result.status ?? false) {
        Get.back();
        isLoading.value = false;
        Commonwidget.showSuccessSnackbar(
          message: result.message ?? ServiceConfiguration.commonErrorMessage,
        );
      } else if (result.status == false) {
        isLoading.value = false;
        Commonwidget.showErrorSnackbar(
          message: result.message ?? ServiceConfiguration.commonErrorMessage,
        );
      } else {
        isLoading.value = false;
        Commonwidget.showErrorSnackbar(
          message: result.message ?? ServiceConfiguration.commonErrorMessage,
        );
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint("ERROR :- ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }
}

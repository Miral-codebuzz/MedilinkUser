import 'package:doc_o_doctor/constants/app_string.dart';
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
      Get.back();
    }
  }
}

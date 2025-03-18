import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpAndSupportController extends GetxController {
  @override
  void dispose() {
    nameController.clear();
    ageController.clear();
    phoneController.clear();
    phoneController.clear();
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
  final RxnString selectedGender = RxnString();
  final List<String> genderOptions = ['Male', 'Female', 'Other'];

  void submitForm() {
    if (formKey.currentState!.validate()) {}
  }
}

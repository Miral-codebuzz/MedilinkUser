import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddFamilyMemberController extends GetxController {
  @override
  void dispose() {
    nameController.clear();
    ageController.clear();
    phoneController.clear();
    relationController.clear();
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
  final relationController = TextEditingController();
  final dobController = TextEditingController();
  var dob = ''.obs;
  // final selectedGender = RxnString();
  //  RxString? selectedGender;
  final RxnString selectedGender = RxnString();
  final List<String> genderOptions = ['Male', 'Female', 'Other'];

  void submitForm() {
    if (formKey.currentState!.validate()) {
      Get.back();
    }
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dobController.text = DateFormat('dd/MM/yyyy').format(picked);
      dob.value = dobController.text;
    }
  }
}

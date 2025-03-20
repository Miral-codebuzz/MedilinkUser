import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/screens/medical_condition_screen/medical_condition_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AboutYourselfController extends GetxController {
  // var name = ''.obs;
  // var dob = ''.obs;
  // var streetAddress = ''.obs;
  // var city = ''.obs;
  // var country = ''.obs;
  // var selectedGender = RxnString();

  // bool validateForm() {
  //   return name.isNotEmpty &&
  //       dob.isNotEmpty &&
  //       streetAddress.isNotEmpty &&
  //       city.isNotEmpty &&
  //       country.isNotEmpty &&
  //       selectedGender.value != null;
  // }
  RxString selectedValue = AppString.selectpatient.obs;

  void updateSelectedValue(String value) {
    selectedValue.value = value;
  }

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final streetAddress = TextEditingController();
  final cityController = TextEditingController();
  final countryController = TextEditingController();
  final dobController = TextEditingController();
  var dob = ''.obs;

  final RxnString selectedGender = RxnString();
  final List<String> genderOptions = ['Male', 'Female', 'Other'];

  void submitForm() {
    if (formKey.currentState!.validate()) {
      Get.to(() => MedicalConditionScreen());
    }
  }

  @override
  void dispose() {
    nameController.clear();
    ageController.clear();
    streetAddress.clear();
    cityController.clear();
    countryController.clear();
    super.dispose();
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

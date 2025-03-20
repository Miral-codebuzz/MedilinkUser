import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/screens/thank_you_screen/thank_you_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookAppointmentController extends GetxController {
  var selectedDate = (-1).obs;
  var selectedTime = (-1).obs;
  RxString selectedValue = AppString.selectpatient.obs;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final phoneController = TextEditingController();
  final problemController = TextEditingController();
  final RxnString selectedGender = RxnString();
  final List<String> genderOptions = ['Male', 'Female', 'Other'];

  @override
  void dispose() {
    nameController.clear();
    ageController.clear();
    phoneController.clear();
    problemController.clear();
    selectedDate.value = -1;
    selectedTime.value = -1;
    super.dispose();
  }

  ///patient selection
  final List<String> options = [
    AppString.forSelf,
    AppString.forFamilyMember,
    AppString.forOtherPerson,
  ];

  void updateSelectedValue(String value) {
    selectedValue.value = value;
  }

  void submitForm() {
    if (selectedTime.value == -1 || selectedDate.value == -1) {
      Get.snackbar(
        "Date And Time",
        "Please select a Date and Time",
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColor.lightPinkColor,
        colorText: Colors.black,
        margin: EdgeInsets.all(10),
        duration: Duration(seconds: 2),
      );
      return; // Stop execution if time is not selected
    }
    if (formKey.currentState!.validate()) {
      Get.to(() => ThankYouScreen());
      nameController.clear();
      ageController.clear();
      phoneController.clear();
      problemController.clear();
      selectedDate.value = -1;
      selectedTime.value = -1;
    }
  }
}

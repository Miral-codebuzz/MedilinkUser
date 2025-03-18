import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/screens/thank_you_screen/thank_you_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class BookAppointmentController extends GetxController {
  var selectedDate = (-1).obs;
  var selectedTime = (-1).obs;

  RxString selectedValue = AppString.selectpatient.obs;
  // RxInt selectDate = 0.obs;
  // // final TextEditingController nameController = TextEditingController();
  // // final TextEditingController ageController = TextEditingController();
  // // final TextEditingController phoneController = TextEditingController();
  // // final TextEditingController genderController = TextEditingController();

  // var name = ''.obs;
  // var age = ''.obs;
  // var phoneNumber = ''.obs;
  // // var selectedGender = ''.obs;
  // var genderError = RxnString();

  // void setGender(String gender) {
  //   selectedGender.value = gender;
  //   genderError.value = null;
  // }

  // var nameError = RxnString();
  // var ageError = RxnString();
  // var phoneError = RxnString();
  // void validateForm() {

  //   nameError.value = name.value.isEmpty ? "Name is required" : null;
  //   ageError.value = age.value.isEmpty ? "Age is required" : null;
  //   phoneError.value =
  //       phoneNumber.value.isEmpty ? "Phone number is required" : null;
  //   genderError.value =
  //       selectedGender.value.isEmpty ? "Gender is required" : null;
  // }

  @override
  void dispose() {
    nameController.clear();
    ageController.clear();
    phoneController.clear();
    phoneController.clear();
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
    if (formKey.currentState!.validate()) {
      Get.to(() => ThankYouScreen());
      nameController.clear();
      ageController.clear();
      phoneController.clear();
      phoneController.clear();
    }
  }
}

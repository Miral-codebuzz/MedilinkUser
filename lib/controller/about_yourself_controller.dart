import 'package:doc_o_doctor/Model/loginModel.dart';
import 'package:doc_o_doctor/constants/%20commonwidget.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/constants/settings.dart';
import 'package:doc_o_doctor/screens/medical_condition_screen/medical_condition_screen.dart';
import 'package:doc_o_doctor/service/rest_services.dart';
import 'package:doc_o_doctor/service/service_configuration.dart';
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

  void submitForm(context) {
    if (formKey.currentState!.validate()) {
      userAbout(context);
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

  var isLoading = false.obs;

  var service = Get.find<RestService>();

  Future<void> userAbout(context) async {
    try {
      var connection = await Commonwidget.checkConnectivity();
      if (!connection) return;
      isLoading.value = true;
      TellAboutSelfRequest tellAboutSelfRequest = TellAboutSelfRequest();
      tellAboutSelfRequest.name = nameController.text;
      tellAboutSelfRequest.gender = selectedGender.value;
      tellAboutSelfRequest.address = streetAddress.text;
      tellAboutSelfRequest.city = cityController.text;
      tellAboutSelfRequest.country = countryController.text;
      tellAboutSelfRequest.dateOfBirth = dob.value;

      var result = await service.tellAboutSelf(tellAboutSelfRequest);

      if (result.status ?? false) {
        isLoading.value = false;
        Commonwidget.showSuccessSnackbar(
          message: result.message ?? ServiceConfiguration.commonErrorMessage,
        );
        Settings.step = "1";
        Get.off(() => MedicalConditionScreen());
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

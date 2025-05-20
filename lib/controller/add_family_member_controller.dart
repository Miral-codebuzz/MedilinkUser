import 'package:doc_o_doctor/Model/addFamilyMemberModel.dart';
import 'package:doc_o_doctor/constants/commonwidget.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/service/rest_services.dart';
import 'package:doc_o_doctor/service/service_configuration.dart';
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

  void submitForm({int? id}) {
    if (formKey.currentState!.validate()) {
      addFamilyMember(id: id);
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

  @override
  void onInit() {
    super.onInit();
    getDoctorList();
  }

  var familydoctorList = <FamilyDoctor>[].obs;

  var isfamilydoctor = false.obs;
  Future<void> getDoctorList() async {
    try {
      var connection = await Commonwidget.checkConnectivity();
      if (!connection) return;
      isfamilydoctor.value = true;
      var result = await service.getFamilyDoctorList();

      if (result.status ?? false) {
        familydoctorList.value = result.data ?? [];
        isfamilydoctor.value = false;
      } else {
        isfamilydoctor.value = false;
        Commonwidget.showErrorSnackbar(
          message: result.message ?? ServiceConfiguration.commonErrorMessage,
        );
      }
    } catch (e) {
      isfamilydoctor.value = false;
      debugPrint("ERROR :- ${e.toString()}");
    }
  }

  var isLoading = false.obs;
  var countryCode = "+91".obs;
  var service = Get.find<RestService>();
  Future<void> addFamilyMember({int? id}) async {
    try {
      var connection = await Commonwidget.checkConnectivity();
      if (!connection) return;
      isLoading.value = true;
      AddFamilyMemberRequestModel addFamilyMemberRequestModel =
          AddFamilyMemberRequestModel();
      addFamilyMemberRequestModel.name = nameController.text;
      addFamilyMemberRequestModel.gender = selectedGender.value;
      addFamilyMemberRequestModel.relation = relationController.text;

      addFamilyMemberRequestModel.dob = dobController.text;

      addFamilyMemberRequestModel.number =
          "${countryCode.value} ${phoneController.text}";

      var result = await service.addFamilyMember(
        addFamilyMemberRequestModel,
        id: id,
      );

      if (result.status ?? false) {
        Get.back();
        Commonwidget.showSuccessSnackbar(
          message: result.message ?? ServiceConfiguration.commonErrorMessage,
        );
        getMemberList();
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

  var addmemberLoder = false.obs;
  var familyList = <FamilyMember>[].obs;

  Future<void> getMemberList() async {
    try {
      var connection = await Commonwidget.checkConnectivity();
      if (!connection) return;
      addmemberLoder.value = true;
      var result = await service.getFamilyMember();

      if (result.status ?? false) {
        familyList.value = result.data ?? [];
        addmemberLoder.value = false;
      } else {
        addmemberLoder.value = false;
        Commonwidget.showSuccessSnackbar(
          message: result.message ?? ServiceConfiguration.commonErrorMessage,
        );
      }
    } catch (e) {
      addmemberLoder.value = false;
      debugPrint("ERROR :- ${e.toString()}");
    }
  }

  Future<void> deleteFamily(int id) async {
    try {
      var connection = await Commonwidget.checkConnectivity();
      if (!connection) return;

      var result = await service.deleteFamilyMember(id);

      if (result.status ?? false) {
        getMemberList();
        Commonwidget.showSuccessSnackbar(
          message: result.message ?? ServiceConfiguration.commonErrorMessage,
        );
      } else {
        Commonwidget.showErrorSnackbar(
          message: result.message ?? ServiceConfiguration.commonErrorMessage,
        );
      }
    } catch (e) {
      addmemberLoder.value = false;
      debugPrint("ERROR :- ${e.toString()}");
    }
  }
}

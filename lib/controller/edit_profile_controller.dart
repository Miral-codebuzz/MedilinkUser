import 'dart:io';
import 'package:doc_o_doctor/constants/commonwidget.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/controller/bottom_bar_controller.dart';
import 'package:doc_o_doctor/service/rest_services.dart';
import 'package:doc_o_doctor/service/service_configuration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';

class EditProfileController extends GetxController {
  RxString selectedValue = AppString.selectpatient.obs;
  final BottomNavBarController bottomNavBarController = Get.put(
    BottomNavBarController(),
  );

  void updateSelectedValue(String value) {
    selectedValue.value = value;
  }

  var countryCode = "+91".obs;

  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final streetAddress = TextEditingController();
  final cityController = TextEditingController();
  final countryController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  var dob = ''.obs;
  var image = "".obs;
  final RxnString selectedGender = RxnString();
  final List<String> genderOptions = ['Male', 'Female', 'Other'];

  @override
  void onInit() {
    nameController.text =
        bottomNavBarController.profileDetail.value?.name ?? '';
    streetAddress.text =
        bottomNavBarController.profileDetail.value?.address ?? '';
    cityController.text =
        bottomNavBarController.profileDetail.value?.city ?? "";
    countryController.text =
        bottomNavBarController.profileDetail.value?.country ?? '';
    dobController.text =
        bottomNavBarController.profileDetail.value?.dateOfBirth ?? '';
    selectedGender.value =
        bottomNavBarController.profileDetail.value?.gender ?? '';
    if (bottomNavBarController.profileDetail.value?.mobileNumber != null &&
        bottomNavBarController.profileDetail.value!.mobileNumber!.contains(
          ' ',
        )) {
      final parts = bottomNavBarController.profileDetail.value?.mobileNumber!
          .split(' ');
      countryCode.value = parts![0];
      phoneController.text = parts[1];
    }
    image.value = bottomNavBarController.profileDetail.value?.image ?? "";
    super.onInit();
  }

  void submitForm() {
    if (formKey.currentState!.validate()) {
      uploadEditUserData();
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

  final ImagePicker _picker = ImagePicker();

  // Observable to hold the selected image file
  final Rxn<File> pickedImage = Rxn<File>();

  // Pick image from gallery
  Future<void> pickImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      pickedImage.value = File(pickedFile.path);
    } else {}
  }

  var service = Get.find<RestService>();
  var isLoading = false.obs;
  void uploadEditUserData() async {
    var connection = await Commonwidget.checkConnectivity();
    if (!connection) return;

    isLoading.value = true;

    try {
      List<http.MultipartFile> imageFiles = [];

      if (pickedImage.value != null) {
        var mimeType =
            lookupMimeType(pickedImage.value!.path) ??
            'application/octet-stream';
        var file = await http.MultipartFile.fromPath(
          "image",
          pickedImage.value!.path,
          contentType: MediaType.parse(mimeType),
        );
        imageFiles.add(file);
      }

      var response = await service.postMultipart(
        method: "POST",
        path: ServiceConfiguration.profile,
        fields: {
          "name": nameController.text,
          "gender": selectedGender.value,
          'mobileNumber': "${countryCode.value} ${phoneController.text}",
          "dateOfBirth": dob.value,
          "address": streetAddress.text,
          "city": cityController.text,
          "country": countryController.text,
        },
        files: imageFiles,
      );

      if (response.statusCode == 200) {
        bottomNavBarController.getProfile();
        Get.back();
      } else {
        Commonwidget.showErrorSnackbar(
          message: "Failed to update profile. Please try again.",
        );
      }
    } catch (e) {
      Commonwidget.showErrorSnackbar(message: "Something went wrong.");
    } finally {
      isLoading.value = false;
    }
  }
}

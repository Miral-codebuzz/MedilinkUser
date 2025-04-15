// import 'package:doc_o_doctor/constants/%20commonwidget.dart';
// import 'package:doc_o_doctor/screens/bottom_nav_bar/bottom_nav_bar.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';

// class MedicalConditionController extends GetxController {
//   final TextEditingController medicalProblemController =
//       TextEditingController();
//   final formKey = GlobalKey<FormState>();

//   var isMedicalUploadVisible = false.obs;
//   var isReportUploadVisible = false.obs;

//   var medicalPdfs = <String>[].obs;
//   var reportPdfs = <String>[].obs;

//   var isLoading = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//   }

//   @override
//   void dispose() {
//     medicalProblemController.dispose();
//     super.dispose();
//   }

//   /// Submit form and navigate
//   void submitForm() {
//     if (formKey.currentState!.validate()) {
//       Get.to(() => BottomNavBar());
//       medicalProblemController.clear();
//     }
//   }

//   /// Request storage permission
//   Future<bool> requestStoragePermission() async {
//     final currentStatus = await Permission.storage.status;

//     if (currentStatus.isGranted) return true;

//     final status = await Permission.storage.request();

//     if (status.isGranted) {
//       return true;
//     } else if (status.isPermanentlyDenied) {
//       Get.snackbar(
//         "Permission Denied",
//         "Storage permission is permanently denied. Please enable it from app settings.",
//       );
//       await openAppSettings();
//     } else if (status.isDenied) {
//       Get.snackbar(
//         "Permission Denied",
//         "Storage permission is required to pick a file.",
//       );
//     }

//     return false;
//   }

//   /// Toggle medical PDF upload visibility
//   void toggleMedicalUpload() {
//     isMedicalUploadVisible.value = !isMedicalUploadVisible.value;
//   }

//   /// Toggle report PDF upload visibility
//   void toggleReportUpload() {
//     isReportUploadVisible.value = !isReportUploadVisible.value;
//   }

//   /// Pick medical PDFs
//   Future<void> pickMedicalPdfs() async {
//     if (!await requestStoragePermission()) return;

//     try {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['pdf'],
//         allowMultiple: true,
//       );

//       if (result != null && result.files.isNotEmpty) {
//         medicalPdfs.value =
//             result.files
//                 .where((file) => file.path != null)
//                 .map((file) => file.path!)
//                 .toList();

//         print("Selected Medical PDFs: ${medicalPdfs.join(', ')}");
//       } else {
//         print("No medical PDFs selected.");
//       }
//     } catch (e) {
//       print("Error picking medical PDFs: $e");
//     }
//   }

//   /// Remove a selected medical PDF
//   void removeMedicalPdf(String filePath) {
//     medicalPdfs.remove(filePath);
//     print('Updated medicalPdfs: $medicalPdfs');
//   }

//   /// Pick past report PDFs
//   Future<void> pickReportPdfs() async {
//     if (!await requestStoragePermission()) return;

//     try {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['pdf'],
//         allowMultiple: true,
//       );

//       if (result != null && result.files.isNotEmpty) {
//         reportPdfs.value =
//             result.files
//                 .where((file) => file.path != null)
//                 .map((file) => file.path!)
//                 .toList();

//         print("Selected Report PDFs: ${reportPdfs.join(', ')}");
//       } else {
//         print("No report PDFs selected.");
//       }
//     } catch (e) {
//       print("Error picking report PDFs: $e");
//     }
//   }

//   /// Remove a selected report PDF
//   void removeReportPdf(String filePath) {
//     reportPdfs.remove(filePath);
//     print('Updated reportPdfs: $reportPdfs');
//   }

//   // void uploadEditUserData(context) async {
//   //   var connection = await Commonwidget.checkConnectivity();
//   //   if (!connection) return;
//   //   isLoading.value = true;
//   //   List<http.MultipartFile> imageFiles = [];
//   //   if (proFileImage.value != null) {
//   //     var mimeType =
//   //         lookupMimeType(proFileImage.value!.path) ??
//   //         'application/octet-stream';
//   //     imageFiles.add(
//   //       await http.MultipartFile.fromPath(
//   //         "image",
//   //         proFileImage.value!.path,
//   //         contentType: MediaType.parse(mimeType),
//   //       ),
//   //     );
//   //   }
//   //   var response = await service.postMultipart(
//   //     path: ServiceConfiguration.profile,
//   //     method: "POST",
//   //     fields: {
//   //       "name": fullNameController.text,
//   //       "dateOfBirth": dobController.text,
//   //       "address": address.text,
//   //       "country": countryController.text,
//   //       "gender": genderController.text,
//   //     },
//   //     files: imageFiles,
//   //   );

//   //   if (response.statusCode == 200) {
//   //     Get.back();
//   //     _bottomcontroller.getProfile(context);
//   //     isLoading.value = false;
//   //   } else {
//   //     isLoading.value = false;
//   //   }
//   // }
// }

import 'dart:io';
import 'package:doc_o_doctor/constants/%20commonwidget.dart';
import 'package:doc_o_doctor/constants/settings.dart';
import 'package:doc_o_doctor/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:doc_o_doctor/service/rest_services.dart';
import 'package:doc_o_doctor/service/service_configuration.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class MedicalConditionController extends GetxController {
  final TextEditingController medicalProblemController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  var isMedicalUploadVisible = false.obs;
  var isReportUploadVisible = false.obs;

  var medicalPdfs = <String>[].obs; // insurance
  var reportPdfs = <String>[].obs; // report

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    medicalProblemController.dispose();
    super.dispose();
  }

  /// Request storage permission
  Future<bool> requestStoragePermission() async {
    final currentStatus = await Permission.storage.status;

    if (currentStatus.isGranted) return true;

    final status = await Permission.storage.request();

    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      Get.snackbar(
        "Permission Denied",
        "Storage permission is permanently denied. Please enable it from app settings.",
      );
      await openAppSettings();
    } else {
      Get.snackbar(
        "Permission Denied",
        "Storage permission is required to pick a file.",
      );
    }

    return false;
  }

  /// Toggle UI
  void toggleMedicalUpload() {
    isMedicalUploadVisible.value = !isMedicalUploadVisible.value;
  }

  void toggleReportUpload() {
    isReportUploadVisible.value = !isReportUploadVisible.value;
  }

  /// Pick PDFs
  Future<void> pickMedicalPdfs() async {
    if (!await requestStoragePermission()) return;

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: true,
      );

      if (result != null && result.files.isNotEmpty) {
        medicalPdfs.value =
            result.files
                .where((file) => file.path != null)
                .map((e) => e.path!)
                .toList();
      }
    } catch (e) {
      print("Error picking medical PDFs: $e");
    }
  }

  Future<void> pickReportPdfs() async {
    if (!await requestStoragePermission()) return;

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: true,
      );

      if (result != null && result.files.isNotEmpty) {
        reportPdfs.value =
            result.files
                .where((file) => file.path != null)
                .map((e) => e.path!)
                .toList();
      }
    } catch (e) {
      print("Error picking report PDFs: $e");
    }
  }

  /// Remove files
  void removeMedicalPdf(String filePath) {
    medicalPdfs.remove(filePath);
  }

  void removeReportPdf(String filePath) {
    reportPdfs.remove(filePath);
  }

  var service = Get.find<RestService>();

  Future<void> uploadMedicalCondition(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    var connection = await Commonwidget.checkConnectivity();
    if (!connection) return;

    isLoading.value = true;

    try {
      List<http.MultipartFile> insuranceFiles = [];
      List<http.MultipartFile> reportFiles = [];

      // Add insurance files
      for (var path in medicalPdfs) {
        var mimeType = lookupMimeType(path) ?? 'application/pdf';
        var file = await http.MultipartFile.fromPath(
          'insurance',
          path,
          contentType: MediaType.parse(mimeType),
        );
        insuranceFiles.add(file);
      }

      // Add report files
      for (var path in reportPdfs) {
        var mimeType = lookupMimeType(path) ?? 'application/pdf';
        var file = await http.MultipartFile.fromPath(
          'report',
          path,
          contentType: MediaType.parse(mimeType),
        );
        reportFiles.add(file);
      }

      // Combine all files
      List<http.MultipartFile> allFiles = [...insuranceFiles, ...reportFiles];

      var response = await service.postMultipart(
        path: ServiceConfiguration.medicalCondition,
        method: "POST",
        fields: {"medicalProblem": medicalProblemController.text},
        files: allFiles,
      );

      if (response.statusCode == 200) {
        medicalProblemController.clear();
        medicalPdfs.clear();
        reportPdfs.clear();
        Settings.step = "2";
        Get.offAll(() => BottomNavBar());
      } else {
        Commonwidget.showErrorSnackbar(
          message: "Failed to upload. Try again later.",
        );
      }
    } catch (e) {
      print("Upload exception: $e");
      Commonwidget.showErrorSnackbar(message: "Something went wrong.");
    } finally {
      isLoading.value = false;
    }
  }
}

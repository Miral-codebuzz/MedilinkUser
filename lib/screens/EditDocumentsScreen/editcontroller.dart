import 'package:doc_o_doctor/Model/loginModel.dart';
import 'package:doc_o_doctor/constants/commonwidget.dart';
import 'package:doc_o_doctor/constants/settings.dart';
import 'package:doc_o_doctor/screens/EditDocumentsScreen/documentsController.dart';
import 'package:doc_o_doctor/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:doc_o_doctor/service/rest_services.dart';
import 'package:doc_o_doctor/service/service_configuration.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

class AddDocController extends GetxController {
  final TextEditingController medicalProblemController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  var isMedicalUploadVisible = false.obs;
  var isReportUploadVisible = false.obs;

  RxList<String> medicalPdfs = <String>[].obs;
  RxList<String> reportPdfs = <String>[].obs;

  var isLoading = false.obs;
  final Documentscontroller documentscontroller = Get.put(
    Documentscontroller(),
  );

  @override
  void dispose() {
    medicalProblemController.dispose();
    super.dispose();
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
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: true,
      );

      if (result != null) {
        for (String path in result.paths.whereType<String>()) {
          String fileName = p.basename(path);

          bool alreadyExists = medicalPdfs.any(
            (existingPath) => p.basename(existingPath) == fileName,
          );

          if (!alreadyExists) {
            medicalPdfs.add(path);
          } else {
            Commonwidget.showErrorSnackbar(
              message: "You've already added this file.",
            );
          }
        }
      }
    } catch (e) {
      debugPrint("Error picking medical PDFs: $e");
    }
  }

  Future<void> pickReportPdfs() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: true,
      );

      if (result != null) {
        for (String path in result.paths.whereType<String>()) {
          String fileName = p.basename(path);

          bool alreadyExists = reportPdfs.any(
            (existingPath) => p.basename(existingPath) == fileName,
          );

          if (!alreadyExists) {
            reportPdfs.add(path);
          } else {
            Commonwidget.showErrorSnackbar(
              message: "You've already added this file.",
            );
          }
        }
      }
    } catch (e) {
      debugPrint("Error picking report PDFs: $e");
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
        fields: {
          "medicalProblem": medicalProblemController.text,
          "sendNotification": false,
        },
        files: allFiles,
      );

      if (response.statusCode == 200) {
        medicalProblemController.clear();
        medicalPdfs.clear();
        reportPdfs.clear();
        documentscontroller.getDocument();
        Get.back();
        Commonwidget.showSuccessSnackbar(message: "Successfully add document");
      } else {
        Commonwidget.showErrorSnackbar(
          message: "Failed to upload. Try again later.",
        );
      }
    } catch (e) {
      debugPrint("Upload exception: $e");
      Commonwidget.showErrorSnackbar(message: "Something went wrong.");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> skipForNow() async {
    try {
      var connection = await Commonwidget.checkConnectivity();
      if (!connection) return;
      isLoading.value = true;
      SkipForNowModel skipForNowModel = SkipForNowModel();

      skipForNowModel.step = 2;

      var result = await service.skipForNow(skipForNowModel);

      if (result.status ?? false) {
        Commonwidget.showSuccessSnackbar(
          message: result.message ?? ServiceConfiguration.commonErrorMessage,
        );
        Settings.step = "2";
        Get.off(() => BottomNavBar());
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
}

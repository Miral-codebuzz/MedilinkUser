import 'package:doc_o_doctor/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class MedicalConditionController extends GetxController {
  final TextEditingController medicalProblemController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  var isMedicalUploadVisible = false.obs;
  var isReportUploadVisible = false.obs;
  var medicalPdfs = <String>[].obs;
  var reportPdfs = <String>[].obs;

  //onNavigate Other screen
  void submitForm() {
    if (formKey.currentState!.validate()) {
      Get.to(() => BottomNavBar());
      medicalProblemController.clear();
    }
  }

  @override
  void dispose() {
    medicalProblemController.clear();
    super.dispose();
  }

  /// Request storage permission
  Future<bool> requestStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      return true;
    } else {
      Get.snackbar(
        "Permission Denied",
        "Storage permission is required to pick a file.",
      );
      return false;
    }
  }

  //show Medical Report PDF uplocde Widget
  void toggleMedicalUpload() {
    isMedicalUploadVisible.value = !isMedicalUploadVisible.value;
  }

  ///Show Past Medical Report PDF uplode Widget
  void toggleReportUpload() {
    isReportUploadVisible.value = !isReportUploadVisible.value;
  }

  ///Pic medical Pdfs
  Future<void> pickMedicalPdfs() async {
    if (!await requestStoragePermission()) return;

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: true,
    );

    if (result != null) {
      medicalPdfs.value = result.files.map((file) => file.name).toList();
      print("Selected Medical PDFs: ${medicalPdfs.join(', ')}");
    }
  }

  ///remove Medical Pdfs
  void removeMedicalPdf(String fileName) {
    medicalPdfs.remove(fileName);
    print('insurancePdfs $medicalPdfs');
  }

  ///Pic past Medical Pdfs
  Future<void> pickReportPdfs() async {
    if (!await requestStoragePermission()) return;

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: true,
    );

    if (result != null) {
      reportPdfs.value = result.files.map((file) => file.name).toList();
      print("Selected Report PDFs: ${reportPdfs.join(', ')}");
    }
  }

  ///Remove Past Pdfs
  void removeReportPdf(String fileName) {
    reportPdfs.remove(fileName);
    print('reportPdfs $reportPdfs');
  }
}

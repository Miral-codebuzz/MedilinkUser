import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class MedicalConditionController extends GetxController {
  RxString medicalInsuranceFile = ''.obs;
  RxString pastMedicalReportFile = ''.obs;
  RxBool isMadicalInstsurance = false.obs;
  RxBool isMedicalReport = false.obs;

  Future<void> pickFile(RxString fileName) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      fileName.value = result.files.single.name;
    }
  }

  void showMadicalInstsurance() {
    isMadicalInstsurance.value != isMadicalInstsurance.value;
  }

  void removeFile(RxString fileName) {
    fileName.value = '';
  }
}

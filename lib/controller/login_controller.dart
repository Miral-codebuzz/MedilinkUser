import 'package:doc_o_doctor/screens/otp_screen/otp_screen.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // TextEditingController mobileNumberController = TextEditingController();
  var mobileNumber = ''.obs;
  var errorText = ''.obs;

  void validate() {
    if (mobileNumber.value.isEmpty) {
      errorText.value = 'Mobile number cannot be empty';
    } else if (mobileNumber.value.length < 10) {
      errorText.value = 'Mobile number must be at least 10 digits';
    } else {
      errorText.value = '';
      Get.to(() => OtpScreen(mobileNo: mobileNumber.value));
      // Proceed with the next step
      // Get.snackbar('Success', 'Mobile number is valid');
    }
  }
}
